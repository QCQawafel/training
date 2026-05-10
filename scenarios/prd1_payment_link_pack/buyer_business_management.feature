@buyer-business-management
Feature: Buyer Business Management
  As a selling business user on the APEX platform
  I want to create buyer business records
  So that I can reuse them during invoice creation and payment link generation

  Background:
    Given I am on the APEX platform login page at "https://apex.development.qawafel.dev/login"
    And I log in with a valid selling business account
    And I navigate to the Buyer Business Management page

  # ──────────────── Positive Scenarios ────────────────

  @buyer-business-management @positive @smoke
  Scenario: Create a buyer business with the minimum required fields
    When I create a buyer business with the following details:
      | Field         | Value                      |
      | Business Name | Al Ahmed Trading           |
      | Email         | accounts@alahmedtrading.example |
    Then a buyer business creation success message should be displayed
    And the buyer business "Al Ahmed Trading" should appear in the buyer listing
    And the buyer listing should show the email "accounts@alahmedtrading.example" for "Al Ahmed Trading"

  @buyer-business-management @positive
  Scenario: Create a buyer business with all supported fields
    When I create a buyer business with the following details:
      | Field             | Value                      |
      | Business Name     | Al Ahmed Wholesale        |
      | Email             | finance@alahmedwholesale.example |
      | CR/Unified Number | 4030201000                 |
      | Phone             | 0551234567                 |
      | Tax Number        | 310234567800003            |
      | Address           | Riyadh Business District   |
    Then a buyer business creation success message should be displayed
    And the buyer listing should show the buyer business details including:
      | Field             | Value                      |
      | Business Name     | Al Ahmed Wholesale        |
      | CR/Unified Number | 4030201000                 |
      | Email             | finance@alahmedwholesale.example |
      | Phone             | 0551234567                 |
