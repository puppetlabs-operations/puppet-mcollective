# = Class: mcollective::remove
#
class mcollective::remove {

  include mcollective::params

  $mcollective_packages = [ 'mcollective', 'mcollective-common', 'mcollective-client' ]

  service { $mcollective::params::servicename: ensure => stopped } ->
  package { $mcollective_packages: ensure => absent }

  case $::osfamily {
    Debian: {
      # Mcollective packages currently install into ruby/1.8 instead of vendor_ruby
      # for compatibility with hardy. If the current rubyversion is 1.9 then we
      # need symlinks so mcollective can find itself.
      if $::rubyversion =~ /^1\.9/ {
        file { '/usr/lib/ruby/vendor_ruby/mcollective.rb':
            ensure  => absent,
            require => [
              Package[$mcollective_packages],
              Service[$mcollective::params::servicename]
            ],
        }
        file { '/usr/lib/ruby/vendor_ruby/mcollective':
            ensure  => absent,
            require => [
              Package[$mcollective_packages],
              Service[$mcollective::params::servicename]
            ],
        }
      }
    }
    FreeBSD: {
      # The mcollective package drops all plugins in /usr/local/share/mcollective
      # which breaks the mcollective libdir path, which expects "${libdir}/mcollective"
      # so we patch that in with a symlink
      file { "${mcollective::params::core_libdir}/mcollective":
        ensure => absent,
        require => [
          Package[$mcollective_packages],
          Service[$mcollective::params::servicename]
        ],
      }
    }
  }
}
