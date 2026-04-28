@app @login @smoke
Feature: App Login
  As a registered user
  I want to log in to the app using my email and password
  So that I can access my account

  # Login screen contains only Email, Password fields and a Login button.
  # No "Forgot Password" link and no OTP or any other verification method is required.

  @positive @valid-credentials
  Scenario: Successful login with valid email and password
    # -- Pre-condition: user is already registered with a valid email and password
    Given I am on the app login page

    # -- Verify the login page UI elements
    And I can see the "Email" field
    And I can see the "Password" field
    And I can see the "Login" button
    And there is no "Forgot Password" link on the page

    # -- Perform login with valid credentials
    When I enter a valid email in the "Email" field
    And I enter a valid password in the "Password" field
    And I click the "Login" button

    # -- Verify successful login without OTP or any additional verification
    Then I should be logged in successfully
    And I should be redirected to the home page