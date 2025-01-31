@ignore
Feature: Delete Booking

  Scenario: Delete booking to clean up data
    * def authResponse = call read("classpath:features/helpers/authentication.feature")
    * def token = authResponse.token
    Given url baseUrl + "booking/" + bookingId
    And header Cookie = "token=" + token
    And header Content-Type = "application/json"
    When method DELETE
    Then status 201
    And match response == "Created"
