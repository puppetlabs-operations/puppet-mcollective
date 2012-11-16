class mcollective::params(
  $topicprefix          = '/topic/',
  $logfile              = '/var/log/mcollective.log',
  $mcollective_loglevel = 'warn',
  $extra_libdirs        = [],
) {

  case $osfamily {
    'FreeBSD': {
      $sharedir        = '/usr/local/share/mcollective'
      $core_libdir     = $sharedir
      $configdir       = '/usr/local/etc/mcollective'
      $servicename     = 'mcollectived'
      $custom_sharedir = '/var/mcollective'

      $stomp_pkgname   = 'stomp'
      $stomp_provider  = 'gem'
    }
    'RedHat': {
      $sharedir        = '/usr/libexec/mcollective'
      $core_libdir     = $sharedir
      $configdir       = '/etc/mcollective'
      $servicename     = 'mcollective'
      $custom_sharedir = '/var/lib/mcollective'

      $stomp_pkgname   = 'rubygem-stomp'
      $stomp_provider  = 'yum'
    }
    default: {
      $sharedir        = '/usr/share/mcollective'
      $core_libdir     = "${sharedir}/plugins"
      $configdir       = '/etc/mcollective'
      $servicename     = 'mcollective'
      $custom_sharedir = '/var/lib/mcollective'

      $stomp_pkgname   = 'ruby-stomp'
      $stomp_provider  = 'apt'
    }
  }

  $custom_libdir = "${custom_sharedir}/plugins"
}
