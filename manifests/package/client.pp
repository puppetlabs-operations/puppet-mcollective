# = Class: mcollective::package::client
#
# This class will pull in the mcollective::package::stomp dependency and
# install the mcollective client gem.
#
class mcollective::package::client {

  require mcollective::package::stomp

  package { 'mcollective-client':
    ensure => present,
  }
}
