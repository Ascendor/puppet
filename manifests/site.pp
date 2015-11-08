node 'loadbalancer' {
  class { 'apache': }
  apache::vhost { 'example.com':
    port => '80',
    docroot => '/var/www/html'
  }
}