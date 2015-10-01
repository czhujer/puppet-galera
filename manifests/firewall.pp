# == Class: galera::firewall
#
# === Parameters
#
# [*source*]
# (optional) The firewall source addresses to unblock
# Defaults to undef
#
class galera::firewall (
  $source = undef,
) {

  define galera::firewall::source_ip ( $ip = $title){
      firewall { "4567 galera accept tcp from ${ip}":
        before => Anchor['mysql::server::start'],
        proto  => 'tcp',
        dport   => $galera::firewall::galera_ports,
        action => accept,
        source => $ip,
      }
  }

  $galera_ports = [$galera::mysql_port, $galera::wsrep_group_comm_port, $galera::wsrep_state_transfer_port, $galera::wsrep_inc_state_transfer_port]
  if !empty($source) {
    galera::firewall::source_ip { $source: }
  }
  else {
     firewall { '4567 galera accept tcp':
       before => Anchor['mysql::server::start'],
       proto  => 'tcp',
       dport  => $galera_ports,
       action => accept,
       source => $source,
     }
  }
}
