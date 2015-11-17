node 'loadbalancer' {
  class { 'nginx':}
  nginx::resource::upstream { 'puppet_web':
    members => [
      'webnode2.puppet.local',
      'webnode.puppet.local',
    ],
  }

  nginx::resource::vhost { 'www.puppet.local':
    proxy => 'http://puppet_web',
  }
}

node 'webnode', 'webnode2' {
  class { 'apache': }
  apache::vhost { 'www.puppet.local':
    port => '80',
    docroot => '/var/www/html'
  }
  class { 'wordpress':
    wp_owner    => 'root',
    wp_group    => 'root',
    db_host	=> 'mysql.puppet',
    db_name	=> 'wordpress',
    db_user     => 'wordpress',
    db_password => 'EinMannDerSichKolumbusNannt',
    create_db      => true,
    create_db_user => true,
    install_dir => '/var/www/wordpress',
  }
  class { mysql::client: }
}

node 'mysql', 'database' {
  class { '::mysql::server':
    create_root_user 	  => true,
    root_password           => 'EinMannDerSichKolumbusNannt',
    remove_default_accounts => true,
    service_enabled	  => true,
    override_options        => $override_options
  }
  mysql::db { 'wordpress':
    user     => 'wordpress',
    password => 'EinMannDerSichKolumbusNannt',
    host     => '%',
  }
}

