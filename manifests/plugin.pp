define mcollective::plugin($type, $has_ddl = false) {

  include mcollective::params

  include mcollective::server::pluginbase

  $filebase = "${mcollective::params::libdir}/mcollective/${type}/${name}"

  # This assumes that we're only going to install vendored plugins. This is
  # fucking silly and lazy.
  file { "${filebase}.rb":
    ensure => present,
    mode   => '0644',
    owner  => 'root',
    group  => 'root',
    source => "puppet:///modules/mcollective/plugins/${type}/${name}.rb",
    before => [Package['mcollective'], Service['mcollective']],
  }

  if $has_ddl {
    file { "${filebase}.ddl":
      ensure => present,
      mode   => '0644',
      owner  => 'root',
      group  => 'root',
      source => "puppet:///modules/mcollective/plugins/${type}/${name}.ddl",
      before => [Package['mcollective'], Service['mcollective']],
    }
  }
}
