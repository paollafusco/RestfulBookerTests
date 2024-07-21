Feature: Create Booking Endpoint

  Background:
    * url 'https://restful-booker.herokuapp.com/booking'
    * configure headers = { "Content-Type": "application/json", "Accept": "application/json" }

  Scenario: Testing Successful Response for POST Request
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
    And match response ==
    """
    {
      "bookingid": '#number',
      "booking": {
        "firstname": "Alice",
        "lastname": "Brims",
        "totalprice": 605,
        "depositpaid": true,
        "bookingdates": {
          "checkin": "2024-12-11",
          "checkout": "2024-12-12"
        },
        "additionalneeds": "Breakfast / Lunch"
      }
    }
    """
    * def DeleteBooking = call read('classpath:features/helpers/deleteBooking.feature')

  Scenario: Testing Negative Response When a Field is Missing from the Request Payload
    Given url 'https://restful-booker.herokuapp.com/booking'
    And request
      """
      {
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
    Then status 500
    And match response == "Internal Server Error"

