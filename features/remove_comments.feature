Feature: Remove comments
  In order to remove a comment
  As a site user
  I want to remove a comment I've sent

  @javascript
  Scenario: Remove your own comment
    Given I have sent a comment
    When I remove that comment
    Then I should see a message confirming I removed it
    And I should not see my comment

  Scenario: Remove someone else's comment
    Given someone else have sent a comment
    When I see the comment
    Then I should not be able to delete it
