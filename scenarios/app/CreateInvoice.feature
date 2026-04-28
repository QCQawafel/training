@app @invoice @smoke
Feature: Create Invoice
  As a registered user
  I want to create a new invoice by selecting a legal company
  So that the invoice is generated with the correct company details

  # The invoice list screen displays all previously created invoices.
  # Clicking "Create Invoice" opens a form with a "Legal Company Name" dropdown.
  # Selecting a company auto-fills all remaining fields with pre-registered data.
  # All auto-filled fields are read-only (dimmed) and cannot be edited.

  @positive @create-invoice
  Scenario: Successfully create an invoice by selecting a legal company
    # -- Pre-condition: user is logged in and at least one legal company exists
    Given I am on the invoice list screen
    And I can see the list of all created invoices
    And I can see the "Create Invoice" button

    # -- Navigate to the create invoice form
    When I click the "Create Invoice" button
    Then I should be on the create invoice screen

    # -- Verify the form fields
    And I can see the "Legal Company Name" dropdown
    And I can see the following fields:
      | Field Name     |
      | CR/UN Number   |
      | First Name     |
      | Last Name      |
      | Email Address  |
      | Phone Number   |
      | Country        |
      | City           |
      | District       |
      | Street Name    |
      | Postal Code    |
      | Short Address  |

    # -- Select a legal company and verify auto-fill behavior
    When I select a value from the "Legal Company Name" dropdown
    Then all the remaining fields should be auto-filled with the related company data

    # -- Verify all auto-filled fields are read-only (dimmed) and have a value (not empty)
    And the "CR/UN Number" field should be dimmed and should not be empty
    And the "First Name" field should be dimmed and should not be empty
    And the "Last Name" field should be dimmed and should not be empty
    And the "Email Address" field should be dimmed and should not be empty
    And the "Phone Number" field should be dimmed and should not be empty
    And the "Country" field should be dimmed and should not be empty
    And the "City" field should be dimmed and should not be empty
    And the "District" field should be dimmed and should not be empty
    And the "Street Name" field should be dimmed and should not be empty
    And the "Postal Code" field should be dimmed and should not be empty
    And the "Short Address" field should be dimmed and should not be empty

    # -- Submit the invoice
    When I click the "Create Invoice" button
    Then the invoice should be created successfully
    And I should see a success confirmation message