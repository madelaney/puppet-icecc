class icecc::service() inherits icecc {
  if $::icecc::manage_firewall {
    firewall {
      '810 Accept ICEcc Scheduler/TCP traffic':
        dport  => ['8765', '8766'],
        proto  => 'tcp',
        action => 'accept';

      '811 Accept ICEcc Scheduler/UDP traffic':
        dport  => ['8765'],
        proto  => 'udp',
        action => 'accept';
    }
  }

  service {
    'icecc-scheduler':
      ensure => running;
  }
}
