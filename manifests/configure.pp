class icecc::configure (
  $manage_firewall    = $::icecc::manage_firewall,
  $max_jobs           = $::icecc::max_jobs,
  $base_dir           = $::icecc::base_dir,
  $netname            = $::icecc::netname,
  $log_level          = $::icecc::log_level,
  $log_file           = $::icecc::log_file,
  $scheduler_log_file = $::icecc::scheduler_log_file,
  $scheduler_host     = $::icecc::scheduler_host
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

  file {
    $::icecc::config_file:
      ensure  => present,
      content => template('icecc/icecc.conf.erb');
  }
}
