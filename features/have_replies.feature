Feature: Have replies
  In order to reply a comment
  As an user that can comment
  I want to be able to reply to his comment

  @javascript
  Scenario: Reply comment
    Given I visit a page with comments
    When I choose to reply a comment
    And I send the reply
    Then I should see my reply
