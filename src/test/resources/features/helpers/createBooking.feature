@ignore
Feature: Create a New Booking

  Scenario: Create a new booking to be used as test data
    Given url baseUrl + "booking/"
    And header Content-Type = "application/json"
    And header Accept = "application/json"
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
