@getTests
Feature: Test the GET endpoint.

  Background:
    * url "https://restful-booker.herokuapp.com/"
    * configure headers = { "Content-Type": "application/json", "Accept": "application/json" }

  Scenario: Testing Successful Response for GET All Booking Ids
    Given path 'booking'
    When method GET
    Then status 200
    And match response == '#[]'
    And match each response == { bookingid: '#number'}

  Scenario: Testing Successful Response for a GET Request After Adding a Booking
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

  Scenario: Testing Successful Response for a GET Request for a Random BookingId
    Given path 'booking'
    When method GET
    Then status 200
    * def randomIndex = function(max) { return Math.floor(Math.random() * max) }
    * def index = randomIndex(response.length)
    * print index
    * def randomObject = response[index]
    * print randomObject
    * def randomBookingId = randomObject.bookingid
    * print randomBookingId

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

  Scenario: Testing Error Response for a GET Request for an Invalid BookingId
    * def bookingId = call read("classpath:features/helpers/generateInvalidBookingID.feature")
    * def invalidBookingId = bookingId.invalidBookingId
    Given path 'booking/' + invalidBookingId
    When method GET
    Then status 404
    And match response == "Not Found"










