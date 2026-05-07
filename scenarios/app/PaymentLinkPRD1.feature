@app @payment-request @smoke
Feature: Create Payment Request
  As a registered user
  I want to create a payment request with scheduling, expiration, and payment method options
  So that I can send a payment link to my customer with the correct configuration

  # The Create Payment Request screen contains three sections:
  # 1. Send Time: "Send Now" or "Send Later" (single selection).
  #    Selecting "Send Later" reveals two additional fields: Scheduled Date and Scheduled Time.
  # 2. Payment Link Expiration: 7 / 15 / 30 / 45 days (single selection).
  # 3. Available Payment Methods: Credit Card, Apple Pay, Sadad, Alrajhi BNPL (multi-selection).
  # The form is submitted via the "Create Payment Request" button.

  @positive @send-time @send-now
  Scenario: Scheduled Date and Time fields are hidden when Send Now is selected
    Given I am logged in and on the create payment request screen
    When I select the "Send Now" option
    Then the "Scheduled Date" field should not be visible
    And the "Scheduled Time" field should not be visible

  @positive @send-time @send-later
  Scenario: Scheduled Date and Time fields appear when Send Later is selected
    Given I am logged in and on the create payment request screen
    When I select the "Send Later" option
    Then the "Scheduled Date" field should be visible
    And the "Scheduled Time" field should be visible

 
  @positive @expiration
  Scenario Outline: Selecting a payment link expiration deselects all other expiration options
    Given I am logged in and on the create payment request screen
    When I select the "<Expiration>" expiration option
    Then the "<Expiration>" expiration option should be selected
    And all other expiration options should not be selected

    Examples:
      | Expiration |
      | 7 Days     |
      | 15 Days    |
      | 30 Days    |
      | 45 Days    |

  @positive @create-payment-request @send-now
  Scenario: Successfully create a payment request with Send Now
    Given I am logged in and on the create payment request screen
    When I select the "Send Now" option
    And I select the "7 Days" expiration option
    And I select the "Credit Card" payment method
    And I click the "Create Payment Request" button
    Then I should see a success confirmation message

  @positive @create-payment-request @send-later
  Scenario: Successfully create a payment request with Send Later and a scheduled date and time
    Given I am logged in and on the create payment request screen
    When I select the "Send Later" option
    And I enter a valid date in the "Scheduled Date" field
    And I enter a valid time in the "Scheduled Time" field
    And I select the "30 Days" expiration option
    And I select the "Credit Card" payment method
    And I select the "Apple Pay" payment method
    And I click the "Create Payment Request" buttons
    Then I should see a success confirmation message

  @positive @create-payment-request @payment-method
  Scenario: Successfully create a payment request with all payment methods selected
    Given I am logged in and on the create payment request screen
    When I select the "Send Now" option
    And I select the "15 Days" expiration option
    And I select the "Credit Card" payment method
    And I select the "Apple Pay" payment method
    And I select the "Sadad" payment method
    And I select the "Alrajhi BNPL" payment method
    And I click the "Create Payment Request" button
    Then I should see a success confirmation message

  @negative @validation @send-time @send-date
  Scenario: Cannot submit the form without selecting a send time and a send date option
    Given I am logged in and on the create payment request screen
    When I select the "Send Later" option
    And I select the "7 Days" expiration option
    And I select the "Credit Card" payment method
    When I click the "Create Payment Request" button
    Then the payment request should not be created
    And I should see a clear, user-friendly validation message indicating that the send time is required
     And I should see a clear, user-friendly validation message indicating that the send date is required

  
  @negative @validation
  Scenario: Cannot submit when all required fields are empty
    Given I am logged in and on the create payment request screen
    When I click the "Create Payment Request" button
    Then the payment request should not be created
    And I should see a clear, user-friendly validation message indicating that the send time is required
    And I should see a clear, user-friendly validation message indicating that the payment link expiration is required
    And I should see a clear, user-friendly validation message indicating that at least one payment method is required

  @negative @validation @payment-methods @alrajhi-bnpl
  Scenario: Selecting Alrajhi BNPL with a total amount below SAR 1,500 shows an amount range validation message
    Given I am logged in and on the create payment request screen
    And the total amount is less than SAR 1,500
    When I select the "Alrajhi BNPL" payment method
    Then I should see the validation message "To use Al Rajhi BNPL, total amount should be between SAR 1,500 to SAR 20,000."
