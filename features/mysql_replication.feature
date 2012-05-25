Feature: Basic replication Feature
  In order to ensure that we store our users data in a redundant fashion
  As a devops
  I setup mysql in replication

 Background: database cluster is running
	Given a master is up and running
	And a slave is running
	And a people table is present

  Scenario: Basic read/write to database
    Given a person
    When the data of a person is written to the master
    Then the data of the person can be read back from the slave
