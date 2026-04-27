Feature: Payment Link
  As an app user
  I want to navigate to the Invoices tab
  So that I can manage payment links

  Scenario: Navigate to Invoices tab under Selling section
    Given I am on the app login page at "https://app.development.qawafel.dev/login"
    When I enter "540000007" in the mobile number field with country code "+966"
    And I submit the login form
    And I enter the OTP "201111"
    Then I should be logged in successfully
    When I select the vendor "الواهب 2 للحلويات" from the vendors dropdown list on the top navbar
    And I click on the "Selling" tab in the left navbar
    And I click on the "Invoices" tab inside the Selling section
    Then I should be on the Invoices page
