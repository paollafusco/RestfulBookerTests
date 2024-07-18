Feature: Sample Karate Test

  Scenario: Get All Booking Ids
    Given url 'https://restful-booker.herokuapp.com/booking'
    When method GET
    Then status 200
    And print response
    And match response.id == 1