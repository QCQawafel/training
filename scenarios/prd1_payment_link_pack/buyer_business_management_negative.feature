@buyer-business-management
Feature: Buyer Business Management Validation
  As a selling business user on the APEX platform
  I want the buyer business form to reject invalid input
  So that only valid buyer business records are saved

  Background:
    Given I am on the APEX platform login page at "https://apex.development.qawafel.dev/login"
    And I log in with a valid selling business account
    And I navigate to the Buyer Business Management page

  # ──────────────── Negative Scenarios ────────────────

  @buyer-business-management @negative
  Scenario Outline: Creating a buyer business fails when required or formatted data is invalid
    When I create a buyer business with the following details:
      | Field         | Value           |
      | Business Name | <business_name> |
      | Email         | <email>         |
    Then the buyer business should not be created
    And I should remain on the Buyer Business Management form
    And I should see an inline validation error on the "<field>" field
    And the buyer business "<list_value>" should not appear in the buyer listing

    Examples:
      | business_name        | email                                 | field         | list_value                         |
      |                      | operations@alnourtrading.example      | Business Name | operations@alnourtrading.example   |
      | Al Noor Supplies     |                                       | Email         | Al Noor Supplies                   |
      | Al Rawabi Trading    | invalid-email                         | Email         | Al Rawabi Trading                  |
