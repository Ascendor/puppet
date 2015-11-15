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
}

node 'mysql' {
class { '::mysql::server':
  create_root_user 	  => true,
  root_password           => 'EinMannDerSichKolumbusNannt',
  remove_default_accounts => true,
  service_enabled	  => true,
  override_options        => $override_options
  }
}

