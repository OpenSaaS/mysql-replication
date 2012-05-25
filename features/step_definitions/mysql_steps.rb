Given /^a master is up and running$/ do
  @master = ::Mysql.new '192.168.1.10', 'root', 'test', 'replication_test'
end

Given /^a slave is running$/ do
  @slave = ::Mysql.new '192.168.1.11', 'root', 'test', 'replication_test'
end

Given /^a people table is present$/ do
  @master.query("CREATE TABLE people (id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,first_name VARCHAR(100), last_name VARCHAR(100));")
end

Given /^a person$/ do
  @person = {"first_name"=> "John", "last_name" => "Doo"}
end

When /^the data of a person is written to the master$/ do
  command = "INSERT INTO people (first_name, last_name) VALUES (?, ?);"
  stmt = @master.prepare(command)
  stmt.execute(@person["first_name"], @person["last_name"])
  stmt.close
end

Then /^the data of the person can be read back from the slave$/ do
  command = "SELECT * from people where first_name = ? and last_name = ?;"
  stmt = @slave.prepare(command)
  stmt.execute(@person["first_name"], @person["last_name"])
  stmt.num_rows.should == 1
end