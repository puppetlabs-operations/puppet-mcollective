class mcollective::params {

  $topicprefix = '/topic/'
  $libdir  = '/usr/share/mcollective/plugins'
  $logfile = '/var/log/mcollective.log'

  $loglevel = hiera('mcollective_loglevel', 'log')

  $host = hiera('mcollective_host')
  # port 61613 is more standard for the stomp protocol
  $port = hiera('mcollective_port', '61613')

  $user     = hiera('mcollective_user')
  $password = hiera('mcollective_password')

  $psk = hiera('mcollective_psk')
}
