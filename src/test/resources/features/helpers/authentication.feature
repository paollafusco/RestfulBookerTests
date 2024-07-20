@ignore
Feature: Authentication

  Scenario: Authentication
    Given url 'https://restful-booker.herokuapp.com/auth'
    And header Content-Type = 'application/json'
    And request
      """
      {
        "username" : "admin",
        "password" : "password123"
      }
      """
    When method POST
    Then status 200
    * def token = response.token
