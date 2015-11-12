node 'loadbalancer' {
  class { 'apache': }
  apache::vhost { 'example.com':
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

