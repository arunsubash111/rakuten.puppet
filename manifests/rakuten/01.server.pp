


exec { 'apt-update':                    # exec resource named 'apt-update'
  command => '/usr/bin/apt-get update'  # command this resource will run
}

# install apache2 package
package { 'apache2':
  require => Exec['apt-update'],        # require 'apt-update' before installing
  ensure => installed,
}

node 'local.rakuten.puppet' {
  class { 'apache': }             # use apache module
  apache::vhost { 'local.rakuten.com':  # define vhost resource
    port    => '80',
    docroot => '/var/www/html'
  }
}
