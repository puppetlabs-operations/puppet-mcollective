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
    }
    'RedHat': {
      $sharedir        = '/usr/libexec/mcollective'
      $core_libdir     = $sharedir
      $configdir       = '/etc/mcollective'
      $servicename     = 'mcollective'
      $custom_sharedir = '/var/lib/mcollective'
    }
    default: {
      $sharedir        = '/usr/share/mcollective'
      $core_libdir     = "${sharedir}/plugins"
      $configdir       = '/etc/mcollective'
      $servicename     = 'mcollective'
      $custom_sharedir = '/var/lib/mcollective'
    }
  }

  $custom_libdir = "${custom_sharedir}/plugins"
}
