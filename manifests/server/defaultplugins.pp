# This pulls in plugins required for the mcollective service to function
class mcollective::server::defaultplugins {

  mcollective::plugin { 'facts/facter_facts': }
  mcollective::plugin { 'registration/meta':  }
  mcollective::plugin { 'conneector/activemq': }
  mcollective::plugin { 'security/psk': }
}
