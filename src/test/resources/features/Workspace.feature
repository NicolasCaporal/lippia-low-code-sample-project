@Sample
Feature: Project

  Background:
    Given base url https://api.clockify.me/api/v1

  @GetWorkspaceId
  Scenario: Get Workspace
    Given header x-api-key = Y2U5NzYwZTMtNDdjMy00ZDgyLThmNmYtMTc0YmViYWJjNjg5
    And endpoint /workspaces
    When execute method GET
    Then the status code should be 200
    And response should be [0].name = Test Lippia Low Code
    * define workspaceId = response[0].id