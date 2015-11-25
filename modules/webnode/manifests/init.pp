# == Class: webnode
#
# Full description of class webnode here.
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if
#   it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should be avoided in favor of class parameters as
#   of Puppet 2.6.)
#
# [*db_username*]
# [*db_password*]

# === Examples
#
#  class { 'webnode':
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#  }
#
# === Authors
#
# Author Name <author@domain.com>
#
# === Copyright
#
# Copyright 2015 Your name here, unless otherwise noted.
#
class webnode ($db_name, $wp_owner, $wp_group, $db_host, $db_user, $db_password, $install_dir){
  class { 'apache':
    mpm_module => false,
  }
  include apache::mod::prefork
  include apache::mod::php

  apache::vhost { 'www.puppet.local':
    port => '80',
    docroot => '/var/www'
  }

  class { 'wordpress':
    wp_owner    => $wp_owner,
    wp_group    => $wp_group,
    db_host	=> $db_host,
    db_name	=> $db_name,
    db_user     => $db_user,
    db_password => $db_password,
    create_db      => false,
    create_db_user => false,
    install_dir => $install_dir,
  }
  class { mysql::client: }
  class {'mysql::bindings' :
    php_enable => true
  }


}
