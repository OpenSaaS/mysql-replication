#!/usr/bin/env ruby
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end

#$: << File.expand_path(File.join(File.dirname(__FILE__), '..', '..', 'lib'))
#$: << File.expand_path(File.dirname(__FILE__))

#require 'cucumber/nagios/steps'
#require 'webrat_logging_patches'
require 'vagrant'
require 'mysql'
require 'rspec'


# Global hooks: see this as the full setup/teardown of our infrastructure
# see https://github.com/cucumber/cucumber/wiki/Hooks -> global hooks for inspiration
@cluster = Vagrant::Environment.new
@cluster.cli("up")

#global teardown: Kernel#at_exit is used here, see https://github.com/cucumber/cucumber/wiki/Hooks 
at_exit do
  @cluster.cli("halt")
  @cluster.cli("destroy", '--force') # be sure vagrant doesn't ask for confirmation
end