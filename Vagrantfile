# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant::Config.run do |config|
  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.

  # Every Vagrant virtual environment requires a box to build off of.

  config.vm.define :db1 do |db_config|
    own_ip = "192.168.1.10"
    db_config.vm.box = "myubuntu-11.10"
    db_config.vm.forward_port 3306, 3306
    db_config.vm.network :hostonly, own_ip
	db_config.vm.provision :chef_solo do |chef|     
	  chef.cookbooks_path = ["cookbooks","cookbooks-src"]                                                                                                                      
	  chef.add_recipe "apt"  
	  chef.add_recipe "build-essential"
	  chef.add_recipe "mysql::client"
	  chef.add_recipe "mysql::server"
	  
	  chef.json = {
       :mysql => { :server_root_password => 'test',
                   :allow_remote_root => true,
 				   :bind_address => own_ip,
				   :master => true}	
	  }
	end
  end



  config.vm.define :db2 do |db_config|
    own_ip = "192.168.1.11"
	db_config.vm.box = "myubuntu-11.10"
	db_config.vm.forward_port 3306, 3307
	db_config.vm.network :hostonly, own_ip
	db_config.vm.provision :chef_solo do |chef|     
	  chef.cookbooks_path = ["cookbooks","cookbooks-src"]                                                                                                                      
	  chef.add_recipe "apt"  
	  chef.add_recipe "build-essential"
	  chef.add_recipe "mysql::client"
	  chef.add_recipe "mysql::server"
	  
      chef.json = {
	     :mysql => { :server_root_password => 'test',
                     :allow_remote_root => true,
       			     :bind_address => own_ip,
				     :slave => true,
	 			     :server_id => 2,
	 			     :master_host => "192.168.1.10"}	
	   }
	 end
	end
end
