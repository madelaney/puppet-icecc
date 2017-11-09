class icecc::install (
  $package_name   = $::icecc::package_name,
  $package_ensure = $::icecc::package_ensure
) inherits icecc  {
  package {
    $package_name:
      ensure => $package_ensure
  }
}
