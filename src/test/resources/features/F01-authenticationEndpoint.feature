@authenticateTests
Feature: Test the Authentication Endpoint

  Background:
    * url baseUrl

  Scenario: Testing successful response with valid credentials
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

  Scenario: Testing negative response with invalid username
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

  Scenario: Testing negative response with invalid password
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
