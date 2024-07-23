@postTests
Feature: Test the POST Booking Endpoint

  Background:
    * url baseUrl
    * configure headers = { "Content-Type": "application/json", "Accept": "application/json" }

  Scenario: Testing successful response for creating a new booking
    Given url baseUrl + "booking/"
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
    And match response ==
      """
      {
        "bookingid": "#number",
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
    * def bookingId = response.bookingid
    * def DeleteBooking = call read("classpath:features/helpers/deleteBooking.feature")

  @bug
  # Ignored because the response returns 500 ("Internal Server Error") instead of 400 ("Bad Request").
  Scenario: Testing negative response when a field is missing from the request payload
    Given path "booking/"
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
    Then status 400
    And match response == "Bad Request"

    @bug
  #Ignored because status is not always returning 400 ("Bad Request").
  Scenario Outline: Testing negative response when the request payload uses a field with the wrong data type
    Given url baseUrl + "booking/"
    And request
      """
      {
        "firstname" : <firstname>,
        "lastname" : <lastname>,
        "totalprice" : <totalprice>,
        "depositpaid" : <depositpaid>,
        "bookingdates" : {
          "checkin" : <checkin>,
          "checkout" : <checkout>
        },
        "additionalneeds" : <additionalneeds>
      }
      """
    When method POST
    Then status 400
    And match response == "Bad Request"

    Examples:
      | firstname | lastname | totalprice | depositpaid  | checkin      | checkout     | additionalneeds     |
      | 1         | "Scott"  | 100        | true         | "2024-12-11" | "2024-12-12" | "Breakfast"         |
      | "Julie"   | 1        | 100        | true         | "2024-12-11" | "2024-12-12" | "Breakfast"         |
      | "Julie"   | "Scott"  | 100        | "true"       | "2024-12-11" | "2024-12-12" | "Breakfast"         |
      | "Julie"   | "Scott"  | 100        | true         | "2024 12 11" | 2024-12-12   | "Breakfast"         |
      | "Jim"     | "Brown"  | 111        | true         | 2018 0aa1 01 | "2019-01-01" | "Breakfast"         |
      | "Julie"   | "Scott"  | 100        | true         | "2024-12-11" | "2024-12-12" | true                |