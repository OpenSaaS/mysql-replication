begin
  require 'mysql'
rescue LoadError
  Chef::Log.info("Missing gem 'mysql'")
end

module Opscode
  module Mysql
    module Database
      def db
        @db ||= ::Mysql.new node['mysql']['bind_address'], 'root', node['mysql']['server_root_password']
      end
      def close
        @db.close rescue nil
        @db = nil
      end
    end
  end
end
