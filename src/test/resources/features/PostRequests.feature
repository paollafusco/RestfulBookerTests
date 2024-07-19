Feature: Create Booking Endpoint

  Scenario: Testing Successful Response for POST Request
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

    * def authResponse = call read('classpath:features/helpers/Authentication.feature')
    * def token = authResponse.token
    Given url 'https://restful-booker.herokuapp.com/booking' + '/' + bookingId
    And header Cookie = 'token=' + token
    And header Content-Type = 'application/json'
    When method DELETE
    Then status 201
    And match response == "Created"

  Scenario: Negative Test to Verify When a Field is Missing from the Request Payload
    Given url 'https://restful-booker.herokuapp.com/booking'
    And header Content-Type = 'application/json'
    And header Accept = 'application/json'
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

