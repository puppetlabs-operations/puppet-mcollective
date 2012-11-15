class mcollective::params(
  $topicprefix          = '/topic/',
  $logfile              = '/var/log/mcollective.log',
  $mcollective_loglevel = 'warn',
  $extra_libdirs        = [],
) {

  case $osfamily {
    'FreeBSD': {
      $sharedir        = '/usr/local/share/mcollective'
      $configdir       = '/usr/local/etc/mcollective'
      $servicename     = 'mcollectived'
      $custom_sharedir = '/var/mcollective'
    }
    'RedHat': {
      $sharedir        = '/usr/libexec/mcollective'
      $configdir       = '/etc/mcollective'
      $servicename     = 'mcollective'
      $custom_sharedir = '/var/lib/mcollective'
    }
    default: {
      $sharedir        = '/usr/share/mcollective'
      $configdir       = '/etc/mcollective'
      $servicename     = 'mcollective'
      $custom_sharedir = '/var/lib/mcollective'
    }
  }

  # Plugins installed by the mcollective package will be put here.
  $core_libdir   = "${sharedir}/plugins"
  $custom_libdir = "${custom_sharedir}/plugins"
}
