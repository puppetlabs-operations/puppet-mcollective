define mcollective::plugin($type, $has_ddl = false) {

  include mcollective::params

  require mcollective::server::pluginbase

  $filebase = "${mcollective::params::libdir}/${type}/${name}"

  # This assumes that we're only going to install vendored plugins. This is
  # fucking silly and lazy.
  file { "${filebase}.rb":
    ensure => present,
    mode   => '0644',
    owner  => 'root',
    group  => 'root',
    source => "puppet:///modules/mcollective/${type}/${name}.rb",
    before => Service['mcollective'],
  }

  if $has_ddl {
    file { "${filebase}.ddl":
      ensure => present,
      mode   => '0644',
      owner  => 'root',
      group  => 'root',
      source => "puppet:///modules/mcollective/${type}/${name}.ddl",
      before => Service['mcollective'],
    }
  }
}
