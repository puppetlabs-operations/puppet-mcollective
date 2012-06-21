# Allow plugins and DDLs to be shipped separately if desired
define mcollective::plugin::ddl {
  file { "${filebase}.ddl":
    ensure => present,
    mode   => '0644',
    owner  => 'root',
    group  => 'root',
    source => "puppet:///modules/mcollective/plugins/${name}.ddl",
    before => [Package['mcollective'], Service['mcollective']],
  }
}
