Feature: Have comments on something
  In order to have comments on something
  As the user of the site
  I want to see comments of that something
  And leave my comments on that something

  Scenario: See comments
    Given I visit a page with comments
    Then I should see "comment number" within "#comments"

  @focus
  Scenario: Test Pagination
    Given I visit a page with comments
    When I follow "2"
    Then I should see "comment number 13" within "#comments"

  @javascript
  Scenario: Add a comment
    Given I visit a page with comments
    When I fill in "Comment" with "I love to comment"
    And press "Send Comment"
    Then I should see "I love to comment" within "#comments"
