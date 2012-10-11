define mcollective::plugin($has_ddl = false, $module = 'mcollective') {

  include mcollective::params
  include mcollective::server
  require mcollective::server::plugindir

  $filebase = "${mcollective::params::libdir}/mcollective/${name}"

  file { "${filebase}.rb":
    ensure => present,
    mode   => '0644',
    owner  => 'root',
    group  => 'root',
    source => "puppet:///modules/${module}/plugins/${name}.rb",
    before => Package['mcollective'],
    notify => Service['mcollective'],
  }

  if $has_ddl {
    mcollective::plugin::ddl { $name: module => $module }
  }
}
