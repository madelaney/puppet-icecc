class icecc::configure (
  $manage_firewall = $::icecc::manage_firewall,
  $max_jobs        = $::icecc::max_jobs,
  $cache_dir       = $::icecc::cache_dir,
  $netname         = $::icecc::netname,
  $log_level       = $::icecc::log_level,
  $log_file        = $::icecc::log_file
) inherits icecc {
  if $::icecc::manage_firewall {
    firewall {
      '800 Allow ICEcc/TCP Daemon':
        dport  => ['10245'],
        proto  => 'tcp',
        action => 'accept';
    }
  }

  service {
    'iceccd':
      ensure => running;
  }

  file_line {
    'icecc_max_jobs':
      path  => $::icecc::config_file,
      line  => "ICECC_MAX_JOBS=${max_jobs}",
      match => '^ICECC_MAX_JOBS\=';
  }
}
