class watch_graphql_server {


exec { 'yum-update':
    command => '/usr/bin/yum update bash -y',
  }

  exec { 'ghost-issue':
    command => '/usr/bin/yum clean all; /usr/bin/yum update glibc -y',
  }

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
    proxy             => "http://watchgraphql",
    server_name       => [ "_", "local-graphql.watch.aetnd.com"],
    index_files       => [],
    vhost_cfg_prepend => {
      "error_page 403" => "/403",
      "error_page 404" => "/404",
      "error_page 500" => "/timeout.html",
      "error_page 503" => "/timeout.html",
    },
  }
}
