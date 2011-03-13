Feature:  Member Event Registration
  In order to pay for an event
  As a member
  I want to be able to complete an event registration

  Scenario:  Navigating to the event with a fee
    Given I am logged in as a member
    And I have an event named "Fun Times" with standard price of "25.00" and club price of "15.00"
    And I am on the calendar page
    When I follow "Fun Times"
    Then I should be on the "Fun Times" details page
    And I should see "Fun Times"
    And I should see "Register as a Member"
    
