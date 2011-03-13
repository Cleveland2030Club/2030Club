Feature: Guest can RSVP to an event that is Free
  As a Guest
  I want to RSVP to an event
  In order to inform the 2030 Club I plan on attending.

  @wip
  Scenario: Non Member RSVP to an event that is Free
    Given I have an event named "LeanDog Hackibou" with standard price of "0.00" and club price of "0.00"
    And I am on the "LeanDog Hackibou" details page
    And I fill in "First name" with "Kevin"
    And I fill in "Last name" with "Solorio"
    And I fill in "Email" with "soloriok@gmail.com"
    When I press "Continue"
    Then I should be on the new order page
    And I should see "0.00" as the Total

