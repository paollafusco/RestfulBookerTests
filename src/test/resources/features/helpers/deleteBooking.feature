@ignore
Feature: Authentication

  Scenario: Delete Booking
    * def authResponse = call read('classpath:features/helpers/authentication.feature')
    * def token = authResponse.token
    Given url 'https://restful-booker.herokuapp.com/booking' + '/' + bookingId
    And header Cookie = 'token=' + token
    And header Content-Type = 'application/json'
    When method DELETE
    Then status 201
    And match response == "Created"