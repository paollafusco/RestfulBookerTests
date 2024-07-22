@deleteTests
Feature: Test the DELETE Booking Endpoint

  Background:
    * url baseUrl
    * def authResponse = call read("classpath:features/helpers/authentication.feature")
    * def token = authResponse.token

  Scenario: Testing successful response for deleting an existing booking
    * def booking = call read("classpath:features/helpers/createBooking.feature")
    * def bookingId = booking.bookingId
    Given path "booking/" + bookingId
    And header Cookie = "token=" + token
    And header Content-Type = "application/json"
    When method DELETE
    Then status 201
    And match response == "Created"

  Scenario: Testing negative response for deleting a booking when the booking ID is missing
    Given path "booking/"
    And header Cookie = "token=" + token
    And header Content-Type = "application/json"
    When method DELETE
    Then status 404
    And match response == "Not Found"

  Scenario: Testing negative response for when the auth token is missing from the request
    Given path "booking/123"
    And header Content-Type = "application/json"
    When method DELETE
    Then status 403
    And match response == "Forbidden"

  Scenario: Testing negative response for when the payload uses an invalid token
    Given path "booking/123"
    And header Cookie = "token=" + 11223344
    And header Content-Type = "application/json"
    When method DELETE
    Then status 403
    And match response == "Forbidden"

  @bug
  # Ignored because the response returns 405 ("Method Not Allowed") instead of 404 ("Not Found").
  Scenario: Testing negative response for deleting a booking with an invalid booking ID
    * def bookingId = call read("classpath:features/helpers/generateInvalidBookingId.feature")
    * def invalidBookingId = bookingId.invalidBookingId
    Given path "booking/" + invalidBookingId
    And header Cookie = "token=" + token
    And header Content-Type = "application/json"
    When method DELETE
    Then status 404
    And match response == "Not Found"
