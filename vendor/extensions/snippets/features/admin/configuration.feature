Feature: Rich configuration
  In order to control site delivery
  an administrator
  wants to change the configuration of the site
  
  Scenario: Reviewing configuration
    Given I am logged in as "admin"
    And I go to the "configuration" admin page
    Then I should see "Snippet Filter"