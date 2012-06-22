class mcollective::server (
  $host     = $mcollective::params::host,
  $user     = $mcollective::params::user,
  $password = $mcollective::params::password,
  $port     = $mcollective::params::port,
  $psk      = $mcollective::params::psk,
  $ssl      = true
) inherits mcollective::params {

  # ---
  # package requirements

  case $operatingsystem {
    Debian: {
      package { 'ruby-stomp':
        ensure => present,
        before => Package['mcollective'],
      }
    }
  }

  package { 'mcollective':
    ensure  => present,
  }

  # Mcollective will break itself by default, so we need to get there first
  file { '/etc/mcollective':
    ensure => directory,
    mode   => '0600',
    owner  => 'root',
    group  => 'root',
  }

  file { '/etc/mcollective/server.cfg':
    ensure  => present,
    mode    => '0600',
    owner   => 'root',
    group   => 'root',
    content => template('mcollective/server.cfg.erb'),
    before => Package['mcollective'],
  }

  service { 'mcollective':
    ensure    => running,
    enable    => true,
    require   => Package['mcollective'],
    subscribe => File['/etc/mcollective/server.cfg'],
  }

  include mcollective::server::defaultplugins
  include mcollective::server::pluginbase
}
