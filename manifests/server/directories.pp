class mcollective::server::directories {

  include '::mcollective::params'

  exec { 'mco-create-dirs':
    command => "mkdir -p ${mcollective::params::core_libdir}",
    creates => $mcollective::params::sharedir,
  }

}
