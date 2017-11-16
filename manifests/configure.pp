class icecc::configure (
  $manage_firewall    = $::icecc::manage_firewall,
  $max_jobs           = $::icecc::max_jobs,
  $base_dir           = $::icecc::base_dir,
  $netname            = $::icecc::netname,
  $log_file           = $::icecc::log_file,
  $scheduler_log_file = $::icecc::scheduler_log_file,
  $scheduler_host     = $::icecc::scheduler_host,
  $allow_remote       = $::icecc::allow_remote,
  $config_file        = $::icecc::config_file,
  $nice_level         = $::icecc::nice_level
) inherits icecc {
  if $manage_firewall {
    firewall {
      '800 Allow ICEcc/TCP Daemon':
        dport  => ['10245'],
        proto  => 'tcp',
        action => 'accept';
    }
  }

  notice("Running with configure::allow_remote == ${allow_remote}")
  notify { "Running with configure::allow_remote == ${allow_remote}": }

  service {
    'iceccd':
      ensure    => running,
      subscribe => File[$config_file];
  }

  file {
    $config_file:
      ensure  => present,
      content => template('icecc/icecc.conf.erb');
  }
}
