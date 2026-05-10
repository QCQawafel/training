@invoice-creation
Feature: Invoice Creation
  As a selling business user
  I want to create an invoice against a buyer business
  So that I can generate a payment link for the invoice

  Background:
    Given the user is logged in as a selling business
    And the user has completed business profile setup
    And at least one buyer business exists
    And the user navigates to the Invoice Creation screen

  @positive
  Scenario: Seller information is pre-populated and read-only
    Then the seller block displays:
      | Field               | Source           |
      | Business Name       | Business Profile |
      | CR / Unified Number | Business Profile |
      | Tax Number          | Business Profile |
      | Address             | Business Profile |
      | Email               | Business Profile |
      | Phone               | Business Profile |
    And all seller fields are read-only


@positive
  Scenario: Invoice form contains only a single total amount field labelled 'Total Amount (SAR)'
    Then the invoice form displays a single amount input labelled "Total Amount (SAR)"
    And the form does not contain a line items section
    And the form does not contain a unit price field
    And the form does not contain a quantity field
    And the form does not contain a VAT field

    
  @positive
  Scenario: Successfully create an invoice with valid data
    When the user selects buyer "Acme Corp" from the buyer dropdown
    Then the buyer name, email, and phone are pre-filled from the buyer record
    When the user enters total amount "5000.00"
    And the user clicks "Save" or "Create Invoice"
    Then the invoice is created successfully
    And a unique invoice number is auto-generated in format "INV-YY-XXXXXX"
    And the user is returned to the Invoice List screen
    And the new invoice appears in the list with status "Sent"

  @positive
  Scenario: Invoice number is auto-generated and sequential
    When the user creates two invoices
    Then each invoice receives a unique sequential invoice number
    And the format follows "INV-YY-XXXXXX"
    And the user does not manually enter the invoice number

  @positive
  Scenario: Buyer dropdown is searchable and required
    When the user clicks the buyer dropdown field
    Then all buyer businesses added by the selling business are listed
    And the field is searchable
    And the field is marked as required

  @negative
  Scenario: Create invoice without selecting a buyer
    When the user leaves the buyer dropdown unselected
    And the user enters total amount "1000.00"
    And the user clicks "Save"
    Then an inline validation error is displayed for the buyer field
    And the invoice is not created

  @negative
  Scenario: Create invoice without entering total amount
    When the user selects buyer "Acme Corp" from the buyer dropdown
    And the user leaves the total amount field empty
    And the user clicks "Save"
    Then an inline validation error is displayed for the total amount field
    And the invoice is not created

  @negative
  Scenario: Create invoice with zero total amount
    When the user selects buyer "Acme Corp" from the buyer dropdown
    And the user enters total amount "0"
    And the user clicks "Save"
    Then an inline validation error is displayed indicating amount must be a positive value
    And the invoice is not created

  @negative
  Scenario: Create invoice with negative total amount
    When the user selects buyer "Acme Corp" from the buyer dropdown
    And the user enters total amount "-500"
    And the user clicks "Save"
    Then an inline validation error is displayed indicating amount must be a positive value
    And the invoice is not created

  @negative
  Scenario: Create invoice with non-numeric total amount
    When the user selects buyer "Acme Corp" from the buyer dropdown
    And the user enters total amount "abc"
    And the user clicks "Save"
    Then an inline validation error is displayed for the total amount field
    And the invoice is not created

  

  @positive
  Scenario: No ZATCA submission or ZATCA fields on the invoice
    When the user selects buyer "Acme Corp" from the buyer dropdown
    And the user enters total amount "2500.00"
    And the user clicks "Save"
    Then the invoice is created successfully
    And no ZATCA API call is triggered during creation
    And the invoice detail does not display a ZATCA status field
    And the invoice list does not display a ZATCA column

  @positive
  Scenario: Generate Payment Link button is visible on Sent invoices not fully paid
    Given an invoice exists with status "Sent" and is not fully paid
    When the user views the Invoice Table
    Then the "Generate Payment Link" button is visible for that invoice

  @negative
  Scenario: Generate Payment Link button is not visible on non-Sent invoices
    Given an invoice exists with status "Draft"
    When the user views the Invoice Table
    Then the "Generate Payment Link" button is not visible for that invoice