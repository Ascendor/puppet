node 'loadbalancer' {
  class { 'apache': }
  apache::vhost { 'example.com':
    port => '80',
    docroot => '/var/www/html'
  }
}
node 'mysql' {
  class { '::mysql::server':
	root password => 'EinMannDerSichKolumbusNannt',
	remove default accounts => true,
	override_options => $override_options
  }
}

