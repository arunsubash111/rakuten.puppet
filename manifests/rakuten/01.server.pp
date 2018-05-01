



# install apache2 package
package { 'apache2':
  ensure => installed,
}
service { 'apache2':
  ensure => running,
}

#node 'local.rakuten.puppet' {           
  #apache::vhost { 'local.rakuten.com':  
  # define vhost resource
    #port    => '80',
    #docroot => '/var/www/html'
  #}
#}
