@ignore
Feature: Retrieve existing bookings and generate an invalid booking ID

  Scenario: Retrieve existing bookings and generate an invalid booking ID
    Given url "https://restful-booker.herokuapp.com/booking"
    When method GET
    Then status 200
    * def arraySize = karate.sizeOf(response)
    * print arraySize
    * def invalidBookingId = arraySize + 2000
    * print invalidBookingId
