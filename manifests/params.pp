class mcollective::params {

  $topicprefix = '/topic/'
  $libdir  = '/usr/share/mcollective/plugins'
  $logfile = '/var/log/mcollective.log'

  $loglevel = hiera('mcollective_loglevel', 'log')

  $stomp_host     = hiera('mcollective_stomp_host')
  # port 61613 is the standard for the stomp protocol
  $stomp_portport = hiera('mcollective_stomp_port', '61613')

  $stomp_user     = hiera('mcollective_stomp_user')
  $stomp_password = hiera('mcollective_stomp_password')

  $psk = hiera('mcollective_psk')
}
