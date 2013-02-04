# This pulls in plugins required for the mcollective service to function
class mcollective::server::defaultplugins {

  mcollective::plugin { 'facts/facter_facts':
    before => Class['mcollective::package::server'],
  }
  mcollective::plugin { 'registration/meta':  }
  mcollective::plugin { 'audit/logfile': }
}
