@TP8
Feature: Project

  Background:
    Given base url https://api.clockify.me/api/v1

    @AddNewProject @Exitoso
    Scenario: Add New Project
      * define random projectName = ProjectLippiaLowCode
      Given header x-api-key = $(env.x-api-key)
      And call Workspace.feature@GetWorkspaceId
      And endpoint /workspaces/{{workspaceId}}/projects
      And header Content-Type = application/json
      And set value {{projectName}} of key name in body jsons/bodies/addNewProject.json
      When execute method POST
      Then the status code should be 201


  @GetProjectId @Exitoso
  Scenario: Get all projects on Workspace
    Given header x-api-key = $(env.x-api-key)
    And call Workspace.feature@GetWorkspaceId
    And endpoint /workspaces/{{workspaceId}}/projects
    When execute method GET
    Then the status code should be 200
    * define projectId = response[0].id


  @GetProjectInfoById @Exitoso
  Scenario: Get project info by ID
    Given header x-api-key = $(env.x-api-key)
    And call Project.feature@GetProjectId
    And endpoint /workspaces/{{workspaceId}}/projects/{{projectId}}
    When execute method GET
    Then the status code should be 200


  @UpdateProjectOnWorkspace @Exitoso
  Scenario: Update project
    * define color = "#0000FF"
    Given header x-api-key = $(env.x-api-key)
    And call Project.feature@GetProjectId
    And endpoint /workspaces/{{workspaceId}}/projects/{{projectId}}
    And header Content-Type = application/json
    And set value {{color}} of key color in body jsons/bodies/updateProjectOnWorkspace.json
    When execute method PUT
    Then the status code should be 200
    And response should be color = {{color}}


  @AddNewProjectFallido @Fallido
  Scenario Outline: Add New Project fallido por <motivo>
    Given header x-api-key = <apyKeyValue>
    And call Workspace.feature@GetWorkspaceId
    And endpoint <endpoint>
    And header Content-Type = application/json
    And set value <isPublic> of key isPublic in body jsons/bodies/addNewProject.json
    When execute method POST
    Then the status code should be <statusCode>

    Examples:
    | motivo                    | statusCode | apyKeyValue                                      | isPublic | endpoint |
    | No autorizado             | 401        | AAU5NzYwZTMtNDdjMy00ZDgyLThmNmYtMTc0YmViYWJjNjZZ | true     | /workspaces/{{workspaceId}}/projects |
    | Proyecto no encontrado    | 404        | $(env.x-api-key)                                 | true     | /workspaces/{{workspaceId}}/project  |
    | Bad Request               | 400        | $(env.x-api-key)                                 | Crowdar  | /workspaces/{{workspaceId}}/projects |


  @GetProjectIdFallido @Fallido
  Scenario Outline: Get project Id fallido por <motivo>
    Given header x-api-key = <apyKeyValue>
    And call Workspace.feature@GetWorkspaceId
    And endpoint <endpoint>
    When execute method GET
    Then the status code should be <statusCode>

    Examples:
      | motivo                    | statusCode | apyKeyValue                                      | endpoint                                |
      | No autorizado             | 401        | AAU5NzYwZTMtNDdjMy00ZDgyLThmNmYtMTc0YmViYWJjNjZZ | /workspaces/{{workspaceId}}/projects    |
      | Proyecto no encontrado    | 404        | $(env.x-api-key)                                 | /workspaces/{{workspaceId}}/project     |
      | Bad Request               | 400        | $(env.x-api-key)                                 | /workspaces/{{workspaceId}}/projects/;  |


  @GetProjectInfoByIdFallido @Fallido
  Scenario Outline: Get project info by ID fallido por <motivo>
    Given header x-api-key = <apyKeyValue>
    And call Project.feature@GetProjectId
    And endpoint <endpoint>
    When execute method GET
    Then the status code should be <statusCode>

    Examples:
      | motivo                    | statusCode | apyKeyValue                                      | endpoint                                              |
      | No autorizado             | 401        | AAU5NzYwZTMtNDdjMy00ZDgyLThmNmYtMTc0YmViYWJjNjZZ | /workspaces/{{workspaceId}}/projects/{{projectId}}    |
      | Proyecto no encontrado    | 404        | $(env.x-api-key)                                 | /workspaces/{{workspaceId}}/project/{{projectId}}     |
      | Bad Request               | 400        | $(env.x-api-key)                                 | /workspaces/{{workspaceId}}/projects/;                |


  @UpdateProjectOnWorkspace @Fallido
  Scenario Outline: Update project fallido por <motivo>
    Given header x-api-key = <apyKeyValue>
    And call Project.feature@GetProjectId
    And endpoint <endpoint>
    And header Content-Type = application/json
    When execute method PUT
    Then the status code should be <statusCode>

    Examples:
      | motivo                    | statusCode | apyKeyValue                                      | endpoint                                              |
      | No autorizado             | 401        | AAU5NzYwZTMtNDdjMy00ZDgyLThmNmYtMTc0YmViYWJjNjZZ | /workspaces/{{workspaceId}}/projects/{{projectId}}    |
      | Proyecto no encontrado    | 404        | $(env.x-api-key)                                 | /workspaces/{{workspaceId}}/project/{{projectId}}     |
      | Bad Request               | 400        | $(env.x-api-key)                                 | /workspaces/{{workspaceId}}/projects/;                |
