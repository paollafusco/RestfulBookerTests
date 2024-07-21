@deleteTests
Feature: Test the DELETE endpoint

  Background:
    * url "https://restful-booker.herokuapp.com/"
    * def authResponse = call read("classpath:features/helpers/authentication.feature")
    * def token = authResponse.token
    * def booking = call read("classpath:features/helpers/createBooking.feature")
    * def bookingId = booking.bookingId

  Scenario: Testing Successful Response for a DELETE Request of an existing Booking
    Given path "booking/" + bookingId
    And header Cookie = "token=" + token
    And header Content-Type = "application/json"
    When method DELETE
    Then status 201

  Scenario: Testing Negative Response for a DELETE Request when bookingId is missing
    Given path "booking/"
    And header Cookie = "token=" + token
    And header Content-Type = "application/json"
    When method DELETE
    Then status 404

  Scenario: Testing Negative Response for a DELETE Request when auth token is missing
    Given path "booking/" + bookingId
    And header Content-Type = "application/json"
    When method DELETE
    Then status 403

  Scenario: Testing Negative Response for Deleting an Invalid Booking ID
    * def bookingId = call read("classpath:features/helpers/generateInvalidBookingID.feature")
    * def invalidBookingId = bookingId.invalidBookingId
    Given path "booking/" + invalidBookingId
    And header Content-Type = "application/json"
    When method DELETE
    Then status 403
