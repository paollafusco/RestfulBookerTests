@patchTests
Feature: Test the PATCH (Partial Update) Booking Endpoint

  Background:
    * url baseUrl
    * def authResponse = call read("classpath:features/helpers/authentication.feature")
    * def token = authResponse.token
    * def booking = call read("classpath:features/helpers/createBooking.feature")
    * def bookingId = booking.bookingId

  Scenario: Testing successful response for partially updating an existing booking
    Given path "booking/" + bookingId
    And header Cookie = "token=" + token
    And header Content-Type = "application/json"
    And header Accept = "application/json"
    And request
      """
      {
        "firstname": "Jane",
        "lastname": "Doe"
      }
      """
    When method PATCH
    Then status 200
    And match response ==
      """
      {
        "firstname": "Jane",
        "lastname": "Doe",
        "totalprice": 605,
        "depositpaid": true,
        "bookingdates": {
          "checkin": "2024-12-11",
          "checkout": "2024-12-12"
        },
        "additionalneeds": "Breakfast / Lunch"
      }
      """
    * def DeleteBooking = call read("classpath:features/helpers/deleteBooking.feature")

  Scenario: Testing negative response for when the auth token is missing from the request
    Given path "booking/" + bookingId
    And header Content-Type = "application/json"
    And header Accept = "application/json"
    And request
      """
      {
        "firstname": "Jane",
        "lastname": "Doe"
      }
      """
    When method PATCH
    Then status 403
    And match response == "Forbidden"
    * def DeleteBooking = call read("classpath:features/helpers/deleteBooking.feature")

  Scenario: Testing negative response for when the payload uses an invalid token
    Given path "booking/" + bookingId
    And header Cookie = "token=" + 1122334455
    And header Content-Type = "application/json"
    And header Accept = "application/json"
    And request
      """
      {
        "firstname": "Jane",
        "lastname": "Doe"
      }
      """
    When method PATCH
    Then status 403
    And match response == "Forbidden"
    * def DeleteBooking = call read("classpath:features/helpers/deleteBooking.feature")

    @bug
  # Ignored because the response returns 405 ("Method Not Allowed") instead of 404 ("Not Found").
  Scenario: Testing negative response for when partially updating a booking using an invalid booking ID
    * def bookingId = call read("classpath:features/helpers/generateInvalidBookingId.feature")
    * def invalidBookingId = bookingId.invalidBookingId
    Given path "booking/" + invalidBookingId
    And header Cookie = "token=" + token
    And header Content-Type = "application/json"
    And header Accept = "application/json"
    And request
    """
    {
    "firstname": "Jane",
    "lastname": "Doe"
    }
    """
    When method PATCH
    Then status 404
    And match response == "Not Found"
    * def DeleteBooking = call read("classpath:features/helpers/deleteBooking.feature")
