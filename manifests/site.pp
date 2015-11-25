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
  class {'webnode':
    db_name => 'wordpress',
    wp_owner => 'root',
    wp_group => 'root',
    db_host => 'mysql.puppet',
    db_user => 'wordpress',
    db_password => 'EinMannDerSichKolumbusNannt',
    install_dir => '/var/www/wordpress'
  }
}

node 'mysql', 'database' {
  include mysql::server
  class { '::mysql::server':
    create_root_user 	  => true,
    remove_default_accounts => true,
    service_enabled	  => true,
    override_options => {
        mysqld => { bind-address => '0.0.0.0'} #Allow remote connections
      },
  }
}

