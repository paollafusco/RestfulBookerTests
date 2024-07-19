Feature: Get All Booking Ids Endpoint

  Scenario: Testing Successful Response for GET All Booking Ids
    Given url 'https://restful-booker.herokuapp.com/booking'
    When method GET
    Then status 200
    And match response == '#[]'
    And match each response == { bookingid: '#number'}

  Scenario: Testing Successful Response for a GET Request After Adding a Booking
    Given url 'https://restful-booker.herokuapp.com/booking'
    And header Content-Type = 'application/json'
    And header Accept = 'application/json'
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

    Given url 'https://restful-booker.herokuapp.com/booking' + "/" + bookingId
    And header Accept = 'application/json'
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

    Given url 'https://restful-booker.herokuapp.com/booking' + "/" + randomBookingId
    And header Accept = 'application/json'
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










