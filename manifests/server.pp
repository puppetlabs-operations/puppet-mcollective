class mcollective::server (
  $stomp_host     = $mcollective::params::stomp_host,
  $stomp_user     = $mcollective::params::stomp_user,
  $stomp_password = $mcollective::params::stomp_password,
  $stomp_port     = $mcollective::params::stomp_port,
  $psk            = $mcollective::params::psk
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
}
