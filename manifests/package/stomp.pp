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
