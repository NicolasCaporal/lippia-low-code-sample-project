@TP_Final
Feature: TimeEntry

  Background:
    Given base url https://api.clockify.me/api/v1
    Given header x-api-key = YTUxYmQ4ZWEtODk3Mi00YWI2LTk3MDktM2M1ODRiYWI3NWRl


  @GetTimeEntry
  Scenario: Get time entry
    Given call Workspace.feature@GetWorkspaceId
    And call User.feature@GetUserId
    And call TimeEntry.feature@AddNewTimeEntry
    And endpoint /workspaces/{{workspaceId}}/user/{{userId}}/time-entries
    When execute method GET
    Then the status code should be 200
    And response should be [0].timeInterval.duration = PT4H15M
    * define timeEntryId = response[0].id


  @AddNewTimeEntry
  Scenario: Add a new time entry
    Given call Workspace.feature@GetWorkspaceId
    And endpoint /workspaces/{{workspaceId}}/time-entries
    And header Content-Type = application/json
    And set value Lippia low code testing. of key description in body jsons/bodies/addNewTimeEntry.json
    And set value 2024-05-02T08:00:00Z of key start in body jsons/bodies/addNewTimeEntry.json
    And set value 2024-05-02T12:15:00Z of key end in body jsons/bodies/addNewTimeEntry.json
    When execute method POST
    Then the status code should be 201



  @UpdateTimeEntry
  Scenario: Update time entry on workspace
    Given call Workspace.feature@GetWorkspaceId
    And call TimeEntry.feature@GetTimeEntry
    And endpoint /workspaces/{{workspaceId}}/time-entries/{{timeEntryId}}
    And header Content-Type = application/json
    And set value 2024-01-01T08:00:00Z of key start in body jsons/bodies/updateTimeEntry.json
    And set value 2024-01-01T10:00:00Z of key end in body jsons/bodies/updateTimeEntry.json
    When execute method PUT
    Then the status code should be 200

  @DeleteTimeEntry @TP_Final
  Scenario: Delete time entry from workspace
    Given header x-apy-key = YTUxYmQ4ZWEtODk3Mi00YWI2LTk3MDktM2M1ODRiYWI3NWRl
    And call Workspace.feature@GetWorkspaceId
    And call TimeEntry.feature@GetTimeEntry
    And endpoint /workspaces/{{workspaceId}}/time-entries/{{timeEntryId}}
    When execute method DELETE
    Then the status code should be 204
