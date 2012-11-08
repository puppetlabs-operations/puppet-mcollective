class mcollective::params(
  $topicprefix = '/topic/',
  $logfile     = '/var/log/mcollective.log',
  $loglevel    = 'warn',
) {

  case $kernel {
    'freebsd': {
      $sharedir      = '/usr/local/share/mcollective'
      $configdir     = '/usr/local/etc/mcollective'
      $servicename   = 'mcollectived'
      $custom_libdir = '/var/mcollective'
    }
    default: {
      $sharedir      = '/usr/share/mcollective'
      $configdir     = '/etc/mcollective'
      $servicename   = 'mcollective'
      $custom_libdir = '/var/lib/mcollective'
    }
  }

  # Plugins installed by the mcollective package will be put here.
  $core_libdir = "${sharedir}/plugins"
}
