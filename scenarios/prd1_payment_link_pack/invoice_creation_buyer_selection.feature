@invoice-creation @buyer-selection
Feature: Invoice Creation Buyer Selection
  As a selling business user on the APEX platform
  I want to select an existing buyer business during invoice creation
  So that I can generate an invoice for the correct buyer

  Background:
    Given I am on the APEX platform login page at "https://apex.development.qawafel.dev/login"
    And I log in with a valid selling business account
    And a buyer business exists with the following details:
      | Field         | Value                         |
      | Business Name | Al Rowad Industrial Supplies  |
      | Email         | procurement@alrowad.example   |
    And I navigate to the Invoice Creation page

  # ──────────────── Positive Scenarios ────────────────

  @invoice-creation @positive @smoke
  Scenario: Existing buyer business is selectable from the invoice buyer dropdown
    When I open the buyer business dropdown
    Then the buyer business "Al Rowad Industrial Supplies" should be available for selection

  @invoice-creation @positive
  Scenario: Search returns the matching buyer business in the invoice buyer dropdown
    When I open the buyer business dropdown
    And I search for "Al Rowad"
    Then the buyer business "Al Rowad Industrial Supplies" should be returned in the search results
