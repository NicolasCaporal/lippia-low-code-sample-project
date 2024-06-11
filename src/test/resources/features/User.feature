Feature: User

  Background:
    Given base url https://api.clockify.me/api/v1

  @GetUserId
  Scenario: Get User Id
    Given header x-api-key = YTUxYmQ4ZWEtODk3Mi00YWI2LTk3MDktM2M1ODRiYWI3NWRl
    And endpoint /user/
    When execute method GET
    Then the status code should be 200
    * define userId = response.id
