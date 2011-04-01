Feature: Add a comment to something
  In order to comment on something
  As the user of the site
  I want to leave my comments on that something

  @javascript
  Scenario: Add a comment
    When I visit a page with comments
    Then I fill "Comment" with "I love to comment"
    And press "Send Comment"
    Then I should see "Comment sent."
