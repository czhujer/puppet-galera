node default {
  class { 'galera':
    galera_servers  => ['192.168.99.101','192.168.99.102'],
    galera_master   => 'control1.domain.name',
    configure_repo => true,
    mysql_package_name => "Percona-XtraDB-Cluster-server-56",
    galera_package_name => "Percona-XtraDB-Cluster-galera-3",
    client_package_name => "Percona-XtraDB-Cluster-client-56",
  }
}
