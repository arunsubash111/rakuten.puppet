class watch_graphql_server {

  include stdlib

  $source = $::operatingsystemmajrelease ? {
    7 => 'http://dl.fedoraproject.org/pub/epel/7/x86_64/Packages/e/epel-release-7-11.noarch.rpm',
    6 => 'http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm',
  }

  package { 'epel-release':
    ensure          =>  installed,
    provider        =>  rpm,
    install_options => ['--nodeps'],
    source          => $source
  }


class { "nginx":
    worker_processes      => "auto",
    worker_rlimit_nofile  => 64000,
    worker_connections    => 20000,
    server_tokens         => "off"
  }


  file { '/webapps':
    ensure => directory,
    owner   => 'root',
    group   => 'root',
  }


  file { "/webapps/devops":
    ensure => directory,
    owner  => "root",
    group  => "root",
  }

}


class local_server {

  nginx::resource::vhost { "local-graphql.watch.aetnd.com":
    proxy             => "http://127.0.0.1:5000",
    server_name       => [ "_", "local-graphql.watch.aetnd.com"],
    index_files       => [],
  }
}
