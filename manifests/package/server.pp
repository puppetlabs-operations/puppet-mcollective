class mcollective::package::server {

  include mcollective::params

  # ---
  # package requirements

  case $::osfamily {
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

  # Mcollective packages currently install into ruby/1.8 instead of vendor_ruby
  # for compatibility with hardy. If the current rubyversion is 1.9 then we
  # need symlinks so mcollective can find itself.
  case $operatingsystem {
    Debian: {
      if $rubyversion =~ /^1\.9/ {
        file {
          '/usr/lib/ruby/vendor_ruby/mcollective.rb':
            ensure => link,
            target => '/usr/lib/ruby/1.8/mcollective.rb',
            before => Service[$mcollective::params::servicename];
          '/usr/lib/ruby/vendor_ruby/mcollective':
            ensure => link,
            target => '/usr/lib/ruby/1.8/mcollective',
            before => Service[$mcollective::params::servicename];
        }
      }
    }
    FreeBSD: {
      # The mcollective package drops all plugins in /usr/local/share/mcollective
      # which breaks the mcollective libdir path, which expects "${libdir}/mcollective"
      # so we patch that in with a symlink
      file { "${mcollective::params::core_libdir}/mcollective":
        ensure => link,
        target => $mcollective::params::sharedir,
        before => Service[$mcollective::params::servicename];
      }
    }
  }
}
