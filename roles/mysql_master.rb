name "mysql_master"
description "mysql master virtualbox stack"
run_list(
  "recipe[apt]",
  "recipe[build-essential]",
  "recipe[mysql::client]",
  "recipe[mysql::server]",
  "recipe[mysql::master]"
)