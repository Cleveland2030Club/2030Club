Feature: Register Users
  In order to access the full site
  As a user
  I want be able to register on the site

  Scenario: All fields should be validated
    Given there are no users in the database
      And I go to the user registration page
    When I press "Submit"
    Then I should see "Email can't be blank"
     And I should see "First name can't be blank"
     And I should see "Last name can't be blank"
     And I should see "Password can't be blank"
     And I should see "Password confirmation can't be blank"
     And I should see "Address can't be blank"
     And I should see "City can't be blank"
     And I should see "Zip can't be blank"
     And I should see "Phone number can't be blank"

  Scenario: Password and Password confirmation should match
    Given there are no users in the database
      And I go to the user registration page
      And I fill in "First name" with "John"
      And I fill in "Last name" with "Doe"
      And I fill in "Email" with "jdoe@gmail.com"
      And I fill in "Password" with "password"
      And I fill in "Verify password" with "password1"
      And I fill in "Address" with "243 Cedar"
      And I fill in "City" with "Mayfield Heights"
      And I select "Ohio" from "State"
      And I fill in "Zip" with "44124"
      And I fill in "Phone number" with "651-342-3987"
    When I press "Submit"
    Then I should see "Password and confirmation do not match"

  Scenario: User should successfully register
    Given there are no users in the database
      And I go to the user registration page
      And I fill in "First name" with "John"
      And I fill in "Last name" with "Doe"
      And I fill in "Email" with "jdoe@gmail.com"
      And I fill in "Password" with "password"
      And I fill in "Verify password" with "password"
      And I fill in "Address" with "243 Cedar"
      And I fill in "City" with "Mayfield Heights"
      And I select "Ohio" from "State"
      And I fill in "Zip" with "44124"
      And I fill in "Phone number" with "651-342-3987"
    When I press "Submit"
    Then I should see "Member Registration"
     And I should see the Paypal button
     And I should have a User account created with "jdoe@gmail.com"

