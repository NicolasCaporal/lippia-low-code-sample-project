@TP_Final
Feature: TimeEntry

  Background:
    Given base url https://api.clockify.me/api/v1
    Given header x-api-key = YTUxYmQ4ZWEtODk3Mi00YWI2LTk3MDktM2M1ODRiYWI3NWRl

  @GetTimeEntry
  Scenario: Get time entry
    Given call Workspace.feature@GetWorkspaceId
    And call User.feature@GetUserId
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


  @DeleteTimeEntry
  Scenario: Delete time entry from workspace
    Given header x-apy-key = YTUxYmQ4ZWEtODk3Mi00YWI2LTk3MDktM2M1ODRiYWI3NWRl
    And call Workspace.feature@GetWorkspaceId
    And call TimeEntry.feature@GetTimeEntry
    And endpoint /workspaces/{{workspaceId}}/time-entries/{{timeEntryId}}
    When execute method DELETE
    Then the status code should be 204
    And call TimeEntry.feature@AddNewTimeEntry


  @GetTimeEntry @Fallido
  Scenario Outline: Get time entry fallido por <motivo>
    Given header x-api-key = <apyKeyValue>
    And call Workspace.feature@GetWorkspaceId
    And call User.feature@GetUserId
    And endpoint <endpoint>
    When execute method GET
    Then the status code should be <statusCode>

    Examples:
      | motivo                      | statusCode | apyKeyValue                                      | endpoint                                                  |
      | Id de usuario incorrecta    | 400        | YTUxYmQ4ZWEtODk3Mi00YWI2LTk3MDktM2M1ODRiYWI3NWRl | /workspaces/{{workspaceId}}/user/wrongUserId/time-entries |
      | API Key incorrecta          | 401        | AAUxYmQ4ZWEtODk3Mi00YWI2LTk3MDktM2M1ODRiYWI3NWZZ | /workspaces/{{workspaceId}}/user/{{userId}}/time-entries  |
      | Id de Workspace incorrecta  | 403        | YTUxYmQ4ZWEtODk3Mi00YWI2LTk3MDktM2M1ODRiYWI3NWRl | /workspaces/wrongWorkspaceId/user/{{userId}}/time-entries |
      | URL endpoint incorrecta     | 404        | YTUxYmQ4ZWEtODk3Mi00YWI2LTk3MDktM2M1ODRiYWI3NWRl | /workspaces/{{workspaceId}}/user/{{userId}}/wrong-url     |


  @AddNewTimeEntry @Fallido
  Scenario Outline: Add new time entry fallido por <motivo>
    Given header x-api-key = <apyKeyValue>
    And call Workspace.feature@GetWorkspaceId
    And endpoint <endpoint>
    And header Content-Type = application/json
    And set value <start> of key start in body jsons/bodies/addNewTimeEntry.json
    And set value <end> of key end in body jsons/bodies/addNewTimeEntry.json
    When execute method POST
    Then the status code should be <statusCode>

    Examples:
      | motivo                                | statusCode | apyKeyValue                                       | endpoint                                   | start                     | end                        |
      | Formato Json incorrecto               | 400        | YTUxYmQ4ZWEtODk3Mi00YWI2LTk3MDktM2M1ODRiYWI3NWRl  | /workspaces/{{workspaceId}}/time-entries   | 2024-01-01T08:00:0Z       | 2024-01-01T10:00:0Z        |
      | Tiempo de trabajo mayor a 999 horas   | 400        | YTUxYmQ4ZWEtODk3Mi00YWI2LTk3MDktM2M1ODRiYWI3NWRl  | /workspaces/{{workspaceId}}/time-entries   | 2020-01-01T08:00:00Z      | 2024-01-01T08:00:00Z       |
      | API Key incorrecta                    | 401        | AAUxYmQ4ZWEtODk3Mi00YWI2LTk3MDktM2M1ODRiYWI3NWZZ  | /workspaces/{{workspaceId}}/time-entries   | 2024-05-02T08:00:00Z      | 2024-05-02T12:15:00Z       |
      | Id de Workspace incorrecta            | 403        | YTUxYmQ4ZWEtODk3Mi00YWI2LTk3MDktM2M1ODRiYWI3NWRl  | /workspaces/wrongWorkspaceId/time-entries  | 2024-05-02T08:00:00Z      | 2024-05-02T12:15:00Z       |
      | URL endpoint incorrecta               | 404        | YTUxYmQ4ZWEtODk3Mi00YWI2LTk3MDktM2M1ODRiYWI3NWRl  | /workspaces/{{workspaceId}}/time           | 2024-05-02T08:00:00Z      | 2024-05-02T12:15:00Z       |


  @UpdateTimeEntry @Fallido
  Scenario Outline: Update time entry fallido por <motivo>
    Given header x-api-key = <apyKeyValue>
    And call Workspace.feature@GetWorkspaceId
    And call TimeEntry.feature@GetTimeEntry
    And endpoint <endpoint>
    And header Content-Type = application/json
    And set value <start> of key start in body jsons/bodies/updateTimeEntry.json
    And set value <end> of key end in body jsons/bodies/updateTimeEntry.json
    When execute method PUT
    Then the status code should be <statusCode>

    Examples:
      | motivo                              | statusCode | apyKeyValue                                       | endpoint                                                  | start                     | end                        |
      | Formato Json incorrecto             | 400        | YTUxYmQ4ZWEtODk3Mi00YWI2LTk3MDktM2M1ODRiYWI3NWRl  | /workspaces/{{workspaceId}}/time-entries/{{timeEntryId}}  | 2024-01-01T08:00:0Z       | 2024-01-01T10:00:00Z       |
      | Tiempo de trabajo mayor a 999 horas | 400        | YTUxYmQ4ZWEtODk3Mi00YWI2LTk3MDktM2M1ODRiYWI3NWRl  | /workspaces/{{workspaceId}}/time-entries/{{timeEntryId}}  | 2022-01-01T08:00:00Z      | 2024-01-01T08:00:00Z       |
      | Id de TimeEntry incorrecta          | 400        | YTUxYmQ4ZWEtODk3Mi00YWI2LTk3MDktM2M1ODRiYWI3NWRl  | /workspaces/{{workspaceId}}/time-entries/wrongTimeEntryId | 2024-01-01T08:00:00Z      | 2024-01-01T10:00:00Z       |
      | API Key incorrecta                  | 401        | AAUxYmQ4ZWEtODk3Mi00YWI2LTk3MDktM2M1ODRiYWI3NWZZ  | /workspaces/{{workspaceId}}/time-entries/{{timeEntryId}}  | 2024-01-01T08:00:00Z      | 2024-01-01T10:00:00Z       |
      | Id de Workspace incorrecta          | 403        | YTUxYmQ4ZWEtODk3Mi00YWI2LTk3MDktM2M1ODRiYWI3NWRl  | /workspaces/wrongWorkspaceId/time-entries/{{timeEntryId}} | 2024-01-01T08:00:00Z      | 2024-01-01T10:00:00Z       |
      | URL endpoint incorrecta             | 404        | YTUxYmQ4ZWEtODk3Mi00YWI2LTk3MDktM2M1ODRiYWI3NWRl  | /workspaces/{{workspaceId}}/wrong-url/{{timeEntryId}}     | 2024-01-01T08:00:00Z      | 2024-01-01T10:00:00Z       |


  @DeleteTimeEntry @Fallido
  Scenario Outline: Delete time entry fallido por <motivo>
    Given header x-api-key = <apyKeyValue>
    And call Workspace.feature@GetWorkspaceId
    And call TimeEntry.feature@GetTimeEntry
    And endpoint <endpoint>
    When execute method DELETE
    Then the status code should be <statusCode>

    Examples:
      | motivo                      | statusCode | apyKeyValue                                      | endpoint                                                  |
      | Id de TimeEntry incorrecta  | 400        | YTUxYmQ4ZWEtODk3Mi00YWI2LTk3MDktM2M1ODRiYWI3NWRl | /workspaces/{{workspaceId}}/time-entries/wrongTimeEntryId |
      | API Key incorrecta          | 401        | AAUxYmQ4ZWEtODk3Mi00YWI2LTk3MDktM2M1ODRiYWI3NWZZ | /workspaces/{{workspaceId}}/time-entries/{{timeEntryId}}  |
      | Id de Workspace incorrecta  | 403        | YTUxYmQ4ZWEtODk3Mi00YWI2LTk3MDktM2M1ODRiYWI3NWRl | /workspaces/wrongWorkspaceId/time-entries/{{timeEntryId}} |
      | URL endpoint incorrecta     | 404        | YTUxYmQ4ZWEtODk3Mi00YWI2LTk3MDktM2M1ODRiYWI3NWRl | /workspaces/{{workspaceId}}/wrong-url/{{timeEntryId}}     |

