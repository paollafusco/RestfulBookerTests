Feature: Test the delete endpoint

  Background:
    * url "https://restful-booker.herokuapp.com/"
    * def authResponse = call read("classpath:features/helpers/authentication.feature")
    * def token = authResponse.token
    * def booking = call read("classpath:features/helpers/createBooking.feature")
    * def bookingId = booking.bookingId

  Scenario: Testing Successful Response for a DELETE Request of an existing Booking
    Given path "booking/" + bookingId
    And header Cookie = 'token=' + token
    And header Content-Type = 'application/json'
    When method DELETE
    Then status 201

  Scenario: Testing Negative Response for a DELETE Request when bookingId is missing from the request
    Given path "booking/"
    And header Cookie = 'token=' + token
    And header Content-Type = 'application/json'
    When method DELETE
    Then status 404

  Scenario: Testing Negative Response for a DELETE Request when auth token is missing from the request
    Given path "booking/" + bookingId
    And header Content-Type = 'application/json'
    When method DELETE
    Then status 403

  #    if I had time I would add non existing bookingId (get all from array)