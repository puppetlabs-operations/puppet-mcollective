# = Class: mcollective::package::server
#
# This class will pull in the mcollective::package::stomp dependency and
# install the mcollective server. It will also add in the necessary shims
# on different platforms to ensure the server works as expected.
#
# This class will be brought in by mcollective::server and does not need to be
# directly included.
#
class mcollective::package::server {

  include mcollective::params
  require mcollective::package::stomp

  package { 'mcollective':
    ensure  => present,
  }

  case $::osfamily {
    Debian: {
      # Mcollective packages currently install into ruby/1.8 instead of vendor_ruby
      # for compatibility with hardy. If the current rubyversion is 1.9 then we
      # need symlinks so mcollective can find itself.
      if $::rubyversion =~ /^1\.9/ {
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
