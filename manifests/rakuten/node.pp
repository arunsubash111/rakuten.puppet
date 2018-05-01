node "local-graphql.watch.aetnd.com" {

  class { "watch_graphql_server": }
  class { "local_server": }
}

node "dev-graphql.watch.aetnd.com" {

  class { "watch_graphql_server": }
  class { "dev_server": }
}

node "qa-graphql.watch.aetnd.com" {
  
  class { "watch_graphql_server": }
  class { "qa_server": }
}

node "prod-graphql.watch.aetnd.com" {

  class { "watch_graphql_server": }
  class { "prod_server": }
}