class mcollective::server($main_collective = 'mcollective', $collectives = ['mcollective']) {

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

  # Mcollective packages currently install into ruby/1.8 instead of vendor_ruby
  # for compatibility with hardy. If the current rubyversion is 1.9 then we
  # need symlinks so mcollective can find itself.
  if $rubyversion =~ /^1\.9/ {
    file {
      '/usr/lib/ruby/vendor_ruby/mcollective.rb':
        ensure => link,
        target => '/usr/lib/ruby/1.8/mcollective.rb',
        before => Service['mcollective'];
      '/usr/lib/ruby/vendor_ruby/mcollective':
        ensure => link,
        target => '/usr/lib/ruby/1.8/mcollective',
        before => Service['mcollective'];
    }
  }
}
