@patchTests
Feature: Test the partial update endpoint

  Background:
    * url "https://restful-booker.herokuapp.com/"
    * def authResponse = call read("classpath:features/helpers/authentication.feature")
    * def token = authResponse.token
    * def booking = call read("classpath:features/helpers/createBooking.feature")
    * def bookingId = booking.bookingId

  Scenario: Testing Successful Response for a PATCH Request to update an existing Booking
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

  Scenario: Testing Negative Response for a PATCH Request when auth token is missing
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
    * def DeleteBooking = call read("classpath:features/helpers/deleteBooking.feature")

  @ignore # Ignored because of the existing defect
  Scenario: Testing Negative Response for a PATCH Request when using an invalid bookingId
    * def bookingId = call read("classpath:features/helpers/generateFakeBookingID.feature")
    * def fakeBookingId = bookingId.fakeBookingId
    Given path "booking/" + fakeBookingId
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
    * def DeleteBooking = call read("classpath:features/helpers/deleteBooking.feature")
