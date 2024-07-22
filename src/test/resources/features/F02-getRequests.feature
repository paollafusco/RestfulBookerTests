@getTests
Feature: Test the GET Booking Endpoint

  Background:
    * url baseUrl
    * configure headers = { "Content-Type": "application/json", "Accept": "application/json" }

  Scenario: Testing successful response for GET all booking IDs
    Given path 'booking'
    When method GET
    Then status 200
    And match response == '#[]'
    And match each response == { bookingid: '#number'}

  Scenario: Validate new booking is returned by GET request
    * def booking = call read("classpath:features/helpers/createBooking.feature")
    * def bookingId = booking.bookingId
    Given path 'booking/' + bookingId
    When method GET
    Then status 200
    And match response ==
      """
      {
        "firstname" : "Alice",
        "lastname" : "Brims",
        "totalprice" : 605,
        "depositpaid" : true,
        "bookingdates" : {
          "checkin" : "2024-12-11",
          "checkout" : "2024-12-12"
        },
        "additionalneeds" : "Breakfast / Lunch"
      }
      """
    * def DeleteBooking = call read("classpath:features/helpers/deleteBooking.feature")

  Scenario: Testing successful response for a GET request for a random booking ID
    * def randomBooking = call read("classpath:features/helpers/getRandomBookingId.feature")
    * def randomBookingId = randomBooking.randomBookingId
    Given path 'booking/' + randomBookingId
    When method GET
    Then status 200
    And match response ==
      """
      {
        "firstname" : '#string',
        "lastname" : '#string',
        "totalprice" : '#number',
        "depositpaid" : '#boolean',
        "bookingdates" : {
          "checkin" : '#string',
          "checkout" : '#string'
        },
        "additionalneeds" : '#string'
      }
      """

  Scenario: Testing error response for a GET request for an invalid booking ID
    * def bookingId = call read("classpath:features/helpers/generateInvalidBookingId.feature")
    * def invalidBookingId = bookingId.invalidBookingId
    Given path 'booking/' + invalidBookingId
    When method GET
    Then status 404
    And match response == "Not Found"










