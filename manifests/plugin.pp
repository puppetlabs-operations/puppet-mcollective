define mcollective::plugin($has_ddl = false) {

  include mcollective::params
  include mcollective::server
  include mcollective::server::pluginbase

  $filebase = "${mcollective::params::libdir}/mcollective/${name}"

  # This assumes that we're only going to install vendored plugins. This is
  # fucking silly and lazy.
  file { "${filebase}.rb":
    ensure => present,
    mode   => '0644',
    owner  => 'root',
    group  => 'root',
    source => "puppet:///modules/mcollective/plugins/${name}.rb",
    before => Package['mcollective'],
    notify => Service['mcollective'],
  }

  if $has_ddl {
    mcollective::plugin::ddl { $name: }
  }
}
