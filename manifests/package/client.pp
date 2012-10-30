class mcollective::package::client {
  package { 'mcollective-client':
    ensure => present,
  }
}
