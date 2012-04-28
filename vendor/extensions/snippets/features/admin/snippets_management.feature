Feature: Managing snippets
  In order to share content between layouts and pages, as a designer I want to
  manage a collection of snippets
  
  Background:
    Given I am logged in as "designer"
  
  Scenario: List snippets
    When I follow "Design" within "#navigation"
    And I follow "Snippets"
    Then I should see "first"
    And I should see "another"
    And I should see "markdown"
    # And a host of others
  
  Scenario: Create a snippet
    When I follow "Design" within "#navigation"
    And I follow "Snippets"
    And I follow "New Snippet"
    And I fill in "Name" with "Mine"
    And I fill in "Body" with "My snippet"
    And I press "Create Snippet"
    Then I should be on the snippets list
    And I should see "Mine"
  
  Scenario: Display form errors
    When I follow "Design" within "#navigation"
    And I follow "Snippets"
    And I follow "New Snippet"
    And I fill in "Body" with "My snippet"
    And I press "Create Snippet"
    Then I should see an error message
    And I should see the form
  
  Scenario: Continue editing
    When I follow "Design" within "#navigation"
    And I follow "Snippets"
    And I follow "New Snippet"
    And I fill in "Name" with "Mine"
    And I fill in "Body" with "My snippet"
    And I press "Save and Continue Editing"
    Then I should see "Edit Snippet"
    And I should see the form
  
  Scenario: View a snippet
    When I view a filtered snippet
    Then I should see "Edit Snippet"
    And I should see "Markdown"
  
  Scenario: Delete a snippet with confirmation
    When I follow "Design" within "#navigation"
    And I follow "Snippets"
    And I follow "Remove"
    Then I should see "permanently remove"
    And I should see "another"
    When I press "Delete Snippet"
    Then I should not see "another"
      
  Scenario Outline: Admins and designers can see and edit snippets
    Given I am logged in as "<username>"
    And I should see "Design"
    When I follow "Design" within "#navigation"
    And I follow "Snippets"
    And I should not see "You must have designer privileges"
    And I follow "first"
    Then I should see "Edit Snippet"
    
    Examples:
      | username  |
      | admin     |
      | designer |
  
  Scenario Outline: Ordinary users cannot edit snippets
    Given I am logged in as "<username>"
    And I should not see "Design"
    When I go to the "snippets" admin page
    Then I should see "You must have designer privileges"

    Examples:
      | username  |
      | existing  |
      | another   |