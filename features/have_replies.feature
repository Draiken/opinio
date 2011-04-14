Feature: Have replies
  In order to reply a comment
  As an user that can comment
  I want to be able to reply to his comment

  @javascript
  Scenario: Reply comment
    Given I visit a page with comments
    When I follow "Reply" within "#comments li:first-child"
    And I fill in "Comment" with "Your comment is useless"
    And press "Send Comment"
    Then I should see "Your comment is useless" within ".replies"
