class mcollective::server::plugindir {

  include mcollective::params

  $plugin_dirs = [
    "${mcollective::params::libdir}/mcollective/agent",
    "${mcollective::params::libdir}/mcollective/application",
    "${mcollective::params::libdir}/mcollective/audit",
    "${mcollective::params::libdir}/mcollective/connector",
    "${mcollective::params::libdir}/mcollective/facts",
    "${mcollective::params::libdir}/mcollective/registration",
    "${mcollective::params::libdir}/mcollective/security",
    "${mcollective::params::libdir}/mcollective/util",
  ]

  file { [$mcollective::params::sharedir, $mcollective::params::libdir, "${mcollective::params::libdir}/mcollective"]:
    ensure  => directory,
    owner   => 'root',
    group   => 0,
    mode    => '0755',
  }

  file { $plugin_dirs:
    ensure => directory,
    owner  => 'root',
    group  => 0,
    mode   => '0755',
  }


}
