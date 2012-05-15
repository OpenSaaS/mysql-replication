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

ruby_block "configure_replication_slave" do
  block do
    require 'mysql'
    db = ::Mysql.new node['mysql']['bind_address'], 'root', node['mysql']['server_root_password']
    if db.query('select * from mysql.user where User = "repl";').num_rows == 0
      db.query("CREATE USER 'repl'@'%' IDENTIFIED BY 'slavepass';")
      db.query("CREATE DATABASE replication_test;")
      #fetch master log file and position from the master
      m = ::Mysql.new node['mysql']['master_host'], 'root', node['mysql']['server_root_password']
      file, position = 0, 0
      m.query("show master status") do |row|
        row.each_hash do |h|
          file = h['File']
          position = h['Position']
        end
      end
      Chef::Log.info("Filename = #{file}, position = #{position}")
      host = node['mysql']['master_host']
      db.query("stop slave;")
      db.query("CHANGE MASTER TO MASTER_HOST='#{host}', MASTER_USER='repl', MASTER_PASSWORD='slavepass', MASTER_LOG_FILE='#{file}', MASTER_LOG_POS=#{position};")
      db.query("start slave;")      
    end
  end
  action :create
  only_if { node['mysql']['slave'] }
end
