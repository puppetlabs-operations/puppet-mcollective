class mcollective::server::dependencies {

  include '::mcollective::params'

  exec { 'mco-create-dirs':
    command => "mkdir -p ${mcollective::params::sharedir}",
    creates => $mcollective::params::sharedir,
  }

}
