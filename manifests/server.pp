# = Class: mcollective::server
#
# This class installs mcollective and lays down the core configuration for an
# mcollective server.
#
# Note that to bring the mcollective server online you need to additionally
# supply a security plugin and connector.
#
# == Parameters
#
# [*main_collective*]
#
# The collective mcollective will use when sending registration messages.
#
# default: 'mcollective'
#
# [*collectives*]
#
# A list of collectives mcollective should join.
#
# default: ['mcollective']
#
# == Examples
#
#     # Install an mcollective server with a single collective
#     include mcollective::server
#
#     # Install an mcollective server, send registration messages to the
#     # 'mcollective' collective, and additionally join the uk and eu
#     # collectives
#     class { 'mcollective::server':
#       main_collective => 'mcollective',
#       collectives     => ['mcollective', 'uk_collective', 'eu_collective'],
#     }
#
# == See also
#
#   * `manifests/connector/*`
#   * `manifests/security/*`
#
class mcollective::server(
  $main_collective = 'mcollective',
  $collectives     = ['mcollective']
) {

  include mcollective::package::server
  include mcollective::params

  $configdir   = $mcollective::params::configdir
  $servicename = $mcollective::params::servicename

  $core_libdir   = $mcollective::params::core_libdir
  $custom_libdir = $mcollective::params::custom_libdir
  $extra_libdirs = $mcollective::params::extra_libdirs

  # Mcollective will break itself by default, so we need to get there first
  file { $configdir:
    ensure => directory,
    mode   => '0600',
    owner  => 'root',
    group  => 0,
  }

  concat { "${configdir}/server.cfg":
    mode   => '0600',
    owner  => 'root',
    group  => 0,
    before => Package['mcollective'],
  }

  concat::fragment { 'mcollective base':
    order   => 0,
    content => template('mcollective/server.cfg.erb'),
    target  => "${configdir}/server.cfg",
  }

  service { $servicename:
    ensure    => running,
    enable    => true,
    require   => Package['mcollective'],
    subscribe => File["${configdir}/server.cfg"],
  }

  mcollective::connector { '/etc/mcollective/server.cfg':
    type => $mcollective::params::connector_type,
    pool => $mcollective::params::pool,
  }

  mcollective::security::psk { '/etc/mcollective/server.cfg':
    psk => $::mcollective::params::psk
  }

  include mcollective::server::defaultplugins
  include mcollective::server::core_plugins
  include mcollective::server::custom_plugins

}
