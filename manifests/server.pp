class mcollective::server($main_collective = 'mcollective', $collectives = ['mcollective']) {

  include mcollective::package::server
  include mcollective::params

  $configdir   = $mcollective::params::configdir
  $servicename = $mcollective::params::servicename

  # Mcollective will break itself by default, so we need to get there first
  file { $configdir:
    ensure => directory,
    mode   => '0600',
    owner  => 'root',
    group  => 0,
  }

  concat { "${configdir}/server.cfg":
    mode    => '0600',
    owner   => 'root',
    group   => 0,
    before => Package['mcollective'],
  }

  concat::fragment { 'mcollective base':
    order   => 0,
    content => template('mcollective/server.cfg.erb'),
    target  => "${configdir}/server.cfg",
  }

  service { $servicename:
    ensure    => running,
    enable    => true,
    require   => Package['mcollective'],
    subscribe => File["${configdir}/server.cfg"],
  }

  include mcollective::server::defaultplugins
  include mcollective::server::plugindir

}
