@invoice-list
Feature: Home - Invoice List
  As a selling business user
  I want to see all my invoices on the home screen after login
  So that I can manage my invoices and create new ones

  Background:
    Given the user is logged in as a selling business
    And the user has completed business profile setup

  @positive
  Scenario: Invoice list is the landing page after login
    When the user logs in successfully
    Then the user is redirected to the Invoice List screen

  @positive
  Scenario: Invoice list is the landing page after completing business profile
    Given the user has just completed business profile setup
    Then the user is redirected to the Invoice List screen

  @positive
  Scenario: Invoice table displays all required columns
    Given the user has at least one invoice
    When the user views the Invoice List screen
    Then the table displays the following columns:
      | Column            |
      | Invoice Number    |
      | Buyer Business Name |
      | Invoice Date      |
      | Total Amount (SAR) |
      | Invoice Status    |

  @positive
  Scenario: Invoice status displays correct badge values
    Given the following invoices exist:
      | Invoice Number  | Status    |
      | INV-26-000001   | Sent      |
      | INV-26-000002   | Paid      |
      | INV-26-000003   | Cancelled |
    When the user views the Invoice List screen
    Then each invoice row shows exactly one status badge
    And the status values are limited to "Sent", "Paid", or "Cancelled"

  @positive
  Scenario: Create Invoice CTA is visible on the invoice list
    When the user views the Invoice List screen
    Then a "Create Invoice" CTA is visible
    And clicking "Create Invoice" navigates to the invoice creation screen

  @positive
  Scenario: Generate Payment Link CTA on Sent invoice
    Given an invoice exists with status "Sent" and is not fully paid
    When the user views the Invoice List screen
    Then a "Generate Payment Link" CTA is visible on that invoice row

  @negative
  Scenario: Empty state when no invoices exist
    Given the user has no invoices
    When the user views the Invoice List screen
    Then an empty state message is displayed
    And a "Create Invoice" CTA is shown in the empty state
    And no blank table is displayed

  @negative
  Scenario: No filter or sort controls exist on the invoice table
    When the user views the Invoice List screen
    Then no filter controls are present on the table
    And no sort controls are present on the table
    And no linked-document columns are present

  @negative
  Scenario: Generate Payment Link CTA is not visible on Paid invoice
    Given an invoice exists with status "Paid"
    When the user views the Invoice List screen
    Then no "Generate Payment Link" CTA is visible on that invoice row

  @negative
  Scenario: Generate Payment Link CTA is not visible on Cancelled invoice
    Given an invoice exists with status "Cancelled"
    When the user views the Invoice List screen
    Then no "Generate Payment Link" CTA is visible on that invoice row
