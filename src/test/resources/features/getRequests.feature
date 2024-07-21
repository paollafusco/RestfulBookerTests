Feature: Get All Booking Ids Endpoint

  Background:
    * url "https://restful-booker.herokuapp.com"
    * configure headers = { "Content-Type": "application/json", "Accept": "application/json" }

  Scenario: Testing Successful Response for GET All Booking Ids
    Given  url 'https://restful-booker.herokuapp.com/booking'
    When method GET
    Then status 200
    And match response == '#[]'
    And match each response == { bookingid: '#number'}

  Scenario: Testing Successful Response for a GET Request After Adding a Booking
    Given url 'https://restful-booker.herokuapp.com/booking'
    And request
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
    When method POST
    Then status 200
    * def bookingId = response.bookingid
    * print bookingId

    Given url 'https://restful-booker.herokuapp.com/booking/' + bookingId
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
    Given url 'https://restful-booker.herokuapp.com/booking'
    When method GET
    Then status 200
    * def randomIndex = function(max) { return Math.floor(Math.random() * max) }
    * def index = randomIndex(response.length)
    * print index
    * def randomObject = response[index]
    * print randomObject
    * def randomBookingId = randomObject.bookingid
    * print randomBookingId

    Given url 'https://restful-booker.herokuapp.com/booking/' + randomBookingId
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

  Scenario: Testing Error Response for a GET Request for a Wrong BookingId
    * def bookingId = call read("classpath:features/helpers/generateFakeBookingID.feature")
    * def fakeBookingId = bookingId.fakeBookingId
    And path 'booking/' + fakeBookingId
    When method GET
    Then status 404
    And match response == "Not Found"










