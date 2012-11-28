# = Class: mcollective::server::core_plugins
#
# Core plugins are the plugins that are installed by the operating system
# package.
#
# In mcollective 2.0, this directory is not managed by the package. As of at
# least mcollective 2.2 this directory will be managed by the package and
# should be left well enough alone.
#
class mcollective::server::core_plugins {

  include mcollective::params

  $core_dirs = [
    "${mcollective::params::core_libdir}/mcollective/agent",
    "${mcollective::params::core_libdir}/mcollective/application",
    "${mcollective::params::core_libdir}/mcollective/audit",
    "${mcollective::params::core_libdir}/mcollective/connector",
    "${mcollective::params::core_libdir}/mcollective/facts",
    "${mcollective::params::core_libdir}/mcollective/registration",
    "${mcollective::params::core_libdir}/mcollective/security",
    "${mcollective::params::core_libdir}/mcollective/util",
  ]

  file { $core_dirs:
    ensure      => directory,
    owner       => 'root',
    group       => 0,
    mode        => '0755',
    require     => Class['mcollective::package::server'],
  }
}
