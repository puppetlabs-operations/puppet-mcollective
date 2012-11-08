# Allow plugins and DDLs to be shipped separately if desired
define mcollective::plugin::ddl($module = 'mcollective') {

  include mcollective::params

  $filebase = "${mcollective::params::libdir}/mcollective/${name}"

  file { "${filebase}.ddl":
    ensure => present,
    mode   => '0644',
    owner  => 'root',
    group  => 0,
    source => "puppet:///modules/${module}/plugins/${name}.ddl",
    before => [Package['mcollective'], Service[$mcollective::params::servicename]],
  }
}
