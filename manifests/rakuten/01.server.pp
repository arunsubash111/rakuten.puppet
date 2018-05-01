class watch_graphql_server {

class { "nginx":
    worker_processes      => "auto",
    worker_rlimit_nofile  => 64000,
    worker_connections    => 20000,
    server_tokens         => "off"
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
