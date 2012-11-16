# == Define: mcollective::client
#
# Bootstraps an mcollective client for a specific user, based on top of the
# Puppet CA.
#
# == Example
#
#     mcollective::client { 'mcoadmin':
#       group   => 'mcoadmin',
#       homedir => '/home/mcoadmin',
#       ca      => 'my.puppet.ca.com',
#     }
#
# == Caveats
#
# The buildout of .puppet should probably be done in a puppet module.
#
define mcollective::client(
  $group,
  $homedir,
  $ca,
  $main_collective = 'mcollective',
  $collectives     = ['mcollective'],
) {

  include mcollective::package::client

  $mcollective_certname = "user:${name}:${fqdn}"
  $mcollective_ssl_dir = "${homedir}/.puppet/ssl"

  Exec {
    logoutput   => on_failure,
    user        => $name,
    group       => $group,
    path        => '/usr/local/bin:/usr/bin:/bin',
    cwd         => $homedir,
    environment => "HOME=${homedir}",
  }

  file { ["${homedir}/.puppet", "${homedir}/.puppet/ssl"]:
    ensure => directory,
    owner  => $name,
    group  => $group,
    mode   => '0700',
  }

  file { "${homedir}/.puppet/puppet.conf":
    ensure  => present,
    owner   => $name,
    group   => $group,
    mode    => '0600',
    content => "[main]\nserver = ${ca}\ncertname = ${mcollective_certname}",
  }

  exec { "request-mc-cert(${mcollective_certname})":
    command => "puppet certificate --ca-location remote --terminus rest generate ${mcollective_certname}",
    creates => "${mcollective_ssl_dir}/private_keys/${mcollective_certname}.pem",
    require => File["${homedir}/.puppet/puppet.conf"],
  }

  # Copy Puppet CA cert
  file { "${mcollective_ssl_dir}/certs/ca.pem":
    ensure  => present,
    owner   => $name,
    group   => $group,
    mode    => '0600',
    source  => "${settings::ssldir}/certs/ca.pem",
    require => Exec["request-mc-cert(${mcollective_certname})"],
  }

  exec { "try-download-cert-(${mcollective_certname})":
    command => "curl --cacert ${mcollective_ssl_dir}/certs/ca.pem -H 'Accept: s' -s -o ${mcollective_ssl_dir}/certs/${mcollective_certname}.pem https://${ca}:8140/production/certificate/${mcollective_certname}",
    creates => "${mcollective_ssl_dir}/certs/${mcollective_certname}.pem",
    require => [
      Exec["request-mc-cert(${mcollective_certname})"],
      File["${mcollective_ssl_dir}/certs/ca.pem"],
    ],
  }

  concat { "${homedir}/.mcollective":
    owner => $name,
    group => $group,
    mode  => '0600',
  }

  $core_libdir   = $mcollective::params::core_libdir
  $custom_libdir = $mcollective::params::custom_libdir
  $extra_libdirs = $mcollective::params::extra_libdirs

  concat::fragment { "client-base-(${mcollective_certname})":
    target  => "${homedir}/.mcollective",
    order   => '00',
    content => template('mcollective/_mcollective.erb'),
  }
}
