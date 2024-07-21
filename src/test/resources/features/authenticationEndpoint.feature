@authenticate
Feature: Test the authentication endpoint

  Background:
    * url "https://restful-booker.herokuapp.com/"

  Scenario: Testing Successful Response with valid credentials
    Given path "auth"
    And request
      """
      {
        "username" : "admin",
        "password" : "password123"
      }
      """
    When method POST
    Then status 200
    And match response == { token: "#string"}

  Scenario: Testing Negative Response with invalid username
    Given path "auth"
    And request
      """
      {
        "username" : "Invalid User",
        "password" : "password123"
      }
      """
    When method POST
    Then status 200
    And match response == { reason: "Bad credentials"}

  Scenario: Testing Negative Response with invalid password
    Given path "auth"
    And request
      """
      {
        "username" : "admin",
        "password" : "invalidPassword"
      }
      """
    When method POST
    Then status 200
    And match response == { reason: "Bad credentials"}
