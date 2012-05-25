##Goal
I wanted to work with mysql replication in a test setup to see if it fits my particular needs.
I'd like to express my requirments BDD style, preferable through cucumber scripts and run the "cluster" locally via vagrant first.
Later on I might include running it elsewhere (e.g. amazon,..) too.

## Next steps
A few possible next steps could be:

+ cucumber features for logging of running cluster
+ cucumber features for simulating and testing failover scenario's
+ cucumber features to test backup/restore scenario's
+ cucumber features for logging 


## Running the example
Before you can run this example, you'll need to install some dependancies:
### Virtualbox:
You'll need to install Virtualbox: get your copy at [https://www.virtualbox.org/](https://www.virtualbox.org/)
### Ruby. 
Check out [http://www.ruby-lang.org/en/downloads/](http://www.ruby-lang.org/en/downloads/) for more information
### Install additional gems
	$ bundle install
This will install vagrant, veewee, cucumber, mysql and other necessary gems
### Run the scenario
	$ bundle exec cucumber

If all goes well, you'll see the cucumber output.

## Open issues
Setup and teardown of the Vagrant environment is done in the support/env.rb file. As such, the time it takes to setup/teardown the environment is not taken into account by cucumber. If somebody knows a fix for this, please let me know.