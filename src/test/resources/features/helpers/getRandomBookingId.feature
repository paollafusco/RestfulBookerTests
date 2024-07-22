@ignore
Feature: Get a Random Booking ID

  Scenario: Get a random booking ID
    Given url baseUrl + "booking/"
    When method GET
    Then status 200
    * def randomIndex = function(max) { return Math.floor(Math.random() * max) }
    * def index = randomIndex(response.length)
    * def randomObject = response[index]
    * def randomBookingId = randomObject.bookingid