Feature: Admin Dashboard Login
  As an admin user
  I want to log in to the Qawafel admin dashboard
  So that I can manage the platform

  Scenario: Successful login with valid credentials
    Given I am on the admin login page at "admin.development.qawafel.dev/login"
    And I can see the Qawafel logo and the heading "Welcome to Qawafel admin dashboard"
    When I enter "shimaa@qawafel.sa" in the "Email" field
    And I enter a valid password in the "Password" field
    And I click the "Login" button
    Then I should be redirected to the Orders page at "/orders/list"
    And the page title should contain "Orders"
    And I should see the main navigation sidebar


    Scenario: Successful lgoin with new credentials
    Given I am on the admin "Orders" page with "Shimaa Fayze" credentials
    when i click on the logout icon on the left sidebar
    then i will be on the admin login page at "admin.development.qawafel.dev/login"
    And I can see the Qawafel logo and the heading "Welcome to Qawafel admin dashboard"
    When I enter "ahmedwahba@qawafel.sa" in the "Email" field
    And I enter a valid password in the "Password" field
    And click the "Login button"
    Then I should be redirected to the Orders page at "/orders/list"
    And the page title should contain "Orders"
    And I should see the main navigation sidebar
