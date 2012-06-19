class mcollective::server (
  $host     = $mcollective::params::host,
  $user     = $mcollective::params::user,
  $password = $mcollective::params::password,
  $port     = $mcollective::params::port,
  $psk      = $mcollective::params::psk
) inherits mcollective::params {

  # ---
  # package requirements

  case $osfamily {
    Debian: {
      package { 'libstomp-ruby':
        ensure => present,
        before => Package['mcollective'],
      }
    }
  }

  package { 'mcollective':
    ensure => present,
  }

  file { '/etc/mcollective/server.cfg':
    ensure  => present,
    mode    => '0600',
    owner   => 'root',
    group   => 'root',
    content => template('mcollective/server.cfg.erb'),
    require => Package['mcollective'],
  }

  service { 'mcollective':
    ensure    => running,
    enable    => true,
    require   => File['/etc/mcollective/server.cfg'],
    subscribe => File['/etc/mcollective/server.cfg'],
  }

  include mcollective::server::defaultplugins
  include mcollective::server::pluginbase
  Package['mcollective'] -> Class['mcollective::server::pluginbase']
}
