# = Define: mcollective::plugin
#
# Installs mcollective plugins
#
# == Parameters
#
# [*name*]
#
# The type and name of the plugin. Must be in the form of
# <plugin type>/<plugin name>.
#
# [*has_ddl*]
#
# Whether the plugin has a DDL that should be installed alongside the plugin.
#
# * default: false
#
# [*module*]
#
# The module to use when sourcing files.
#
# * default: mcollective
#
define mcollective::plugin(
  $has_ddl = false,
  $module = 'mcollective',
) {

  include mcollective::params
  include mcollective::server

  $filebase = "${mcollective::params::custom_libdir}/mcollective/${name}"

  file { "${filebase}.rb":
    ensure => present,
    mode   => '0644',
    owner  => 'root',
    group  => 0,
    source => "puppet:///modules/${module}/plugins/${name}.rb",
    before => Package['mcollective'],
    notify => Service[$mcollective::params::servicename],
  }

  if $has_ddl {
    mcollective::plugin::ddl { $name: module => $module }
  }
}
