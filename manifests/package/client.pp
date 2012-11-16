class mcollective::package::client {

  require mcollective::package::stomp

  package { 'mcollective-client':
    ensure => present,
  }
}
