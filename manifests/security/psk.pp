# == Define: mcollective::security::psk
#
#
# == Parameters
#
# [*name*]
#   The path to the mcollective configuration
# [*psk*]
#   The preshared key
#
# == Example:
#
#   mcollective::security::psk { '/etc/mcollective/server.cfg':
#     psk => 'my extremely long and tightly guarded preshared key',
#   }
define mcollective::security::psk($psk) {

  mcollective::plugin { 'security/psk': }
  concat::fragment { "${name} - psk security":
    content => template('mcollective/security/psk.cfg.erb'),
    order   => 10,
    target  => $name,
  }
}
