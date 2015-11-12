node 'loadbalancer' {
  class { 'nginx':}
  nginx::resource::upstream { 'puppet_web':
    members => [
      'webnode.puppet.local',
    ],
  }

  nginx::resource::vhost { 'www.puppet.local':
    proxy => 'http://puppet_web',
  }
}

node 'webnode' {
  class { 'apache': }
  apache::vhost { 'webnode.puppet.local':
    port => '80',
    docroot => '/var/www/html'
  }
}
# We want MySQL installed on our machine
# We want MySQL to be constantly running

node 'mysql' {
class { '::mysql::server':
  root_password           => 'EinMannDerSichKolumbusNannt',
  remove_default_accounts => true,
  override_options        => $override_options
  }
}

