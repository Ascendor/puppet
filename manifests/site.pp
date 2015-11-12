node 'loadbalancer' {
  class { 'nginx':}
  nginx::resource::upstream { 'puppet_web':
    members => [
      'localhost:3000',
      'localhost:3001',
      'localhost:3002',
    ],
  }

  nginx::resource::vhost { 'www.puppet.local':
    proxy => 'http://puppet_web',
  }
  package { 'apache2':
    ensure => purged,
  }
}

node 'node' {
  class { 'apache': }
  apache::vhost { 'example.com':
    port => '80',
    docroot => '/var/www/html'
  }
}

node 'mysql' {
  class { '::mysql::server':
	root_password => 'EinMannDerSichKolumbusNannt',
	remove_default_accounts => true,
	override_options => $override_options
  }
}

