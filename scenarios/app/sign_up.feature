Feature: User Sign Up
  As a new user
  I want to sign up to the Qawafel platform
  So that I can create an account and access the services

  Scenario: Successful sign up with valid new email and matching passwords
    Given I am on the sign up page at "https://app.development.qawafel.dev"
    And I can see heading "Create your account"
    When I enter "mohammedhamed@qawafel.sa" in the "Email" field
    And the email is not already registered
    And I enter "ValidPassword123" in the "Password" field
    And I enter "ValidPassword123" in the "Re-enter Password" field
    And I click the "Sign Up" button
    Then I should be redirected to next step  Business Profile setup screen


  Scenario: Sign up fails when email is already registered
    Given I am on the sign up page at "https://app.development.qawafel.dev"
    When I enter "mohammedhamed@qawafel.sa" in the "Email" field
    And I enter "ValidPassword123" in the "Password" field
    And I enter "ValidPassword123" in the "Re-enter Password" field
    And I click the "Sign Up" button
    Then I should see an error message "Email is already registered"
    And I should remain on the sign up page

  Scenario: Sign up fails when passwords do not match
    Given I am on the sign up page at "https://app.development.qawafel.dev"
    When I enter "anothernewuser@qawafel.sa" in the "Email" field
    And I enter "ValidPassword123" in the "Password" field
    And I enter "DifferentPassword456" in the "Re-enter Password" field
    And I click the "Sign Up" button
    Then I should see an error message "Passwords do not match"
    And I should remain on the sign up page
//comment to merge on github and test rebase 