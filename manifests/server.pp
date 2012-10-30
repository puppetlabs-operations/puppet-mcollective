class mcollective::server($main_collective = 'mcollective', $collectives = ['mcollective']) {

  include mcollective::package::server

  # Mcollective will break itself by default, so we need to get there first
  file { '/etc/mcollective':
    ensure => directory,
    mode   => '0600',
    owner  => 'root',
    group  => 'root',
  }

  concat { '/etc/mcollective/server.cfg':
    mode    => '0600',
    owner   => 'root',
    group   => 'root',
    before => Package['mcollective'],
  }

  concat::fragment { 'mcollective base':
    order   => 0,
    content => template('mcollective/server.cfg.erb'),
    target  => '/etc/mcollective/server.cfg',
  }

  service { 'mcollective':
    ensure    => running,
    enable    => true,
    require   => Package['mcollective'],
    subscribe => File['/etc/mcollective/server.cfg'],
  }

  include mcollective::server::defaultplugins
  include mcollective::server::plugindir

}
