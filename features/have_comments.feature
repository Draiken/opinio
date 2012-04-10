Feature: Have comments on something
  In order to have comments on something
  As the user of the site
  I want to see comments of that something
  And leave my comments on that something

  Scenario: See comments
    Given I visit a page with comments
    Then I should see the comments

  Scenario: Test Pagination
    Given I visit a page with comments
    When I use the pagination
    Then I should see more comments 

  @javascript
  Scenario: Add a comment
    Given I visit a page with comments
    When I send a comment
    Then I should see the comment I've sent
