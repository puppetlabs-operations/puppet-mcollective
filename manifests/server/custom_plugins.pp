# = Class: mcollective::server::custom_plugins
#
# Custom plugins are anything installed by the user and not the package. They
# are split out from the core plugins so that the core plugins are not modified.
#
class mcollective::server::custom_plugins {

  include mcollective::params

  $plugin_dirs = [
    $mcollective::params::custom_sharedir,
    $mcollective::params::custom_libdir,
    "${mcollective::params::custom_libdir}/mcollective",
    "${mcollective::params::custom_libdir}/mcollective/agent",
    "${mcollective::params::custom_libdir}/mcollective/application",
    "${mcollective::params::custom_libdir}/mcollective/audit",
    "${mcollective::params::custom_libdir}/mcollective/connector",
    "${mcollective::params::custom_libdir}/mcollective/facts",
    "${mcollective::params::custom_libdir}/mcollective/registration",
    "${mcollective::params::custom_libdir}/mcollective/security",
    "${mcollective::params::custom_libdir}/mcollective/util",
  ]

  file { $plugin_dirs:
    ensure  => directory,
    owner   => 'root',
    group   => 0,
    mode    => '0755',
  }
}
