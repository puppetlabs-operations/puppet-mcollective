class mcollective::params(
  $topicprefix = '/topic/',
  $logfile     = '/var/log/mcollective.log',
  $loglevel    = 'warn',
) {

  case $kernel {
    'freebsd': {
      $sharedir    = '/usr/local/share/mcollective'
      $configdir   = '/usr/local/etc/mcollective'
      $servicename = 'mcollectived'
    }
    default: {
      $sharedir    = '/usr/share/mcollective'
      $configdir   = '/etc/mcollective'
      $servicename = 'mcollective'
    }
  }

  $libdir      = "${sharedir}/plugins"
}
