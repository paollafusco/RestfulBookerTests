@ignore
Feature: Retrieve Existing Bookings and Generate an Invalid Booking ID

  Scenario: Retrieve existing bookings and generate an invalid booking ID
    Given url baseUrl + "booking/"
    When method GET
    Then status 200
    * def arraySize = karate.sizeOf(response)
    * def invalidBookingId = arraySize + 2000
