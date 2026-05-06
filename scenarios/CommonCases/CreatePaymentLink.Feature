@app @payment-request @positive @smoke
Feature: Create Payment Request - Positive Cases
  As a registered user
  I want to successfully create a payment request with different send time, expiration, and payment method combinations
  So that my customer receives a correctly configured payment link

  # The Create Payment Request screen contains three sections:
  # 1. Send Time: "Send Now" or "Send Later" (single selection).
  #    Selecting "Send Later" reveals Scheduled Date and Scheduled Time fields.
  # 2. Payment Link Expiration: 7 / 15 / 30 / 45 days (single selection).
  # 3. Available Payment Methods: Credit Card, Apple Pay, Sadad, Alrajhi BNPL (multi-selection).
  # The form is submitted via the "Create Payment Request" button.

  Scenario Outline: Create a payment request using Send Now with each expiration option
    Given I am logged in and on the create payment request screen
    When I select the "Send Now" option
    And I select the "<Expiration>" expiration option
    And I select the "Credit Card" payment method
    And I click the "Create Payment Request" button
    Then I should see a success confirmation message

    Examples:
      | Expiration |
      | 7 Days     |
      | 15 Days    |
      | 30 Days    |
      | 45 Days    |

  Scenario Outline: Create a payment request using Send Later with each expiration option
    Given I am logged in and on the create payment request screen
    When I select the "Send Later" option
    And I enter a valid date in the "Scheduled Date" field
    And I enter a valid time in the "Scheduled Time" field
    And I select the "<Expiration>" expiration option
    And I select the "Credit Card" payment method
    And I click the "Create Payment Request" button
    Then I should see a success confirmation message

    Examples:
      | Expiration |
      | 7 Days     |
      | 15 Days    |
      | 30 Days    |
      | 45 Days    |

  
  Scenario: Create a payment request with all payment methods selected
    Given I am logged in and on the create payment request screen
    When I select the "Send Now" option
    And I select the "30 Days" expiration option
    And I select the "Credit Card" payment method
    And I select the "Apple Pay" payment method
    And I select the "Sadad" payment method
    And I select the "Alrajhi BNPL" payment method
    And I click the "Create Payment Request" button
    Then I should see a success confirmation message

  Scenario: Create a payment request using Send Later with all payment methods selected
    Given I am logged in and on the create payment request screen
    When I select the "Send Later" option
    And I enter a valid date in the "Scheduled Date" field
    And I enter a valid time in the "Scheduled Time" field
    And I select the "15 Days" expiration option
    And I select the "Credit Card" payment method
    And I select the "Apple Pay" payment method
    And I select the "Sadad" payment method
    And I select the "Alrajhi BNPL" payment method
    And I click the "Create Payment Request" button
    Then I should see a success confirmation message
