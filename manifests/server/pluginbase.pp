class mcollective::server::pluginbase {

  include mcollective::params

  $plugin_dirs = [
    "${mcollective::params::libdir}/agent",
    "${mcollective::params::libdir}/application",
    "${mcollective::params::libdir}/audit",
    "${mcollective::params::libdir}/connector",
    "${mcollective::params::libdir}/facts",
    "${mcollective::params::libdir}/registration",
    "${mcollective::params::libdir}/security",
    "${mcollective::params::libdir}/util",
  ]

  file { $plugin_dirs:
    ensure => directory,
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
  }


}
