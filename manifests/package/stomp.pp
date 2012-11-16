# = Class: mcollective::package::stomp
#
# Install the stomp package for mcollective connectors
#
# This class will be brought in automatically and does not need to be directly
# included. If you need to manually specify parameters, it's recommended that
# the data binding in Puppet 3 is used to inject these values.
#
# == Parameters
#
# [*packagename*]
#
# The name of the mcollective package to install. Defaults to the platform
# specific value determined in mcollective::params
#
# [*provider*]
#
# The package provider to use for installation. Defaults to the platform
# specific provider determined in mcollective::params
#
# == Notes
#
# A number of mcollective connectors require at least mcollective 1.2.2, but
# a sufficiently recent package is usually unavailable via standard package
# repositories. Puppet Labs provides up to date packages for stomp at
# apt.puppetlabs.com and yum.puppetlabs.com. These repositories can be
# installed with the following optional modules:
#
#  * http://forge.puppetlabs.com/ploperations/puppetlabs_apt
#  * http://forge.puppetlabs.com/stahnma/puppetlabs_yum
#
class mcollective::package::stomp(
  $packagename = undef,
  $provider    = undef
) {

  include mcollective::params

  # Check to see if an explicit package was used, else default to the osfamily
  # specific value
  $packagename_real = $packagename ? {
    undef   => $mcollective::params::stomp_pkgname,
    default => $packagename,
  }

  # Check to see if an explicit provider was used, else default to the osfamily
  # specific value
  $provider_real = $provider ? {
    undef   => $mcollective::params::stomp_provider,
    default => $provider,
  }

  package { 'ruby-stomp':
    name     => $packagename_real,
    provider => $provider_real,
  }
}
