@payment-link
Feature: Payment Link
  As an app user
  I want to navigate to the Invoices tab
  So that I can manage payment links

  @positive
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


 @positive @seller
  Scenario: Selling business views Created Payment Requests listing
    Given the user is logged in as a selling business
    And the user has generated payment links
    When the user navigates to the "Created Payment Requests" listing
    Then the table displays the following columns:
      | Column                 |
      | Payment Request Number |
      | Linked Invoice Number  |
      | Buyer Name             |
      | Amount                 |
      | Expiry Date            |
      | Send Type              |
      | Status                 |

  @positive @seller
  Scenario: Payment request status badges in Created listing
    Given the user is logged in as a selling business
    And payment requests exist with statuses "Active", "Expired", "Paid", and "Cancelled"
    When the user views the Created Payment Requests listing
    Then each row displays exactly one of the following status badges:
      | Status    |
      | Active    |
      | Expired   |
      | Paid      |
      | Cancelled |

 @positive @seller
  Scenario: Cancel an active payment request from the listing
    Given the user is logged in as a selling business
    And an active payment request exists for invoice "INV-26-000010"
    When the user clicks the "Cancel" action on the active payment request
    Then the payment request status changes to "Cancelled"
    And the linked invoice "INV-26-000010" returns to "Sent" status