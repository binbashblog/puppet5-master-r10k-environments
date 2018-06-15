#profile/manifests/lamp.pp
class profiles::lamp {

  include mysql::server
  include apache
  include apache::mod::php

  create_resources('mysql_database', hiera('mysql_database', {}))
  create_resources('apache::vhost', hiera('apache::vhost', {}))




}

