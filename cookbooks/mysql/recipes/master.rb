#
# Cookbook Name:: mysql
# Recipe:: default
#
# Copyright 2008-2011, Opscode, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

::Chef::Recipe.send(:include, Opscode::OpenSSL::Password)

include_recipe "mysql::server"


ruby_block "configure_replication_master" do
  block do
    require 'mysql'
    db = ::Mysql.new node['mysql']['bind_address'], 'root', node['mysql']['server_root_password']
    if db.query('select * from mysql.user where User = "repl";').num_rows == 0
      db.query("CREATE USER 'repl'@'%' IDENTIFIED BY 'slavepass';")
      db.query("GRANT REPLICATION SLAVE ON *.* TO 'repl' identified by 'slavepass';")
      db.query("CREATE DATABASE replication_test;")
    end
  end
  action :create
  only_if { node['mysql']['master'] }
end
