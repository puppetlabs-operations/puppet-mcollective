# This pulls in plugins required for the mcollective service to function
class mcollective::server::defaultplugins {

  mcollective::plugin { 'facter_facts': type => facts }
  mcollective::plugin { 'meta': type => registration }
  mcollective::plugin { 'activemq': type => connector }
  mcollective::plugin { 'psk': type => security }
}
