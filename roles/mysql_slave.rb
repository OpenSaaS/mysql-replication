name "mysql_slave"
description "mysql slave virtualbox stack"
run_list(
  "recipe[apt]",
  "recipe[build-essential]",
  "recipe[mysql::client]",
  "recipe[mysql::server]",
  "recipe[mysql::slave]"
)