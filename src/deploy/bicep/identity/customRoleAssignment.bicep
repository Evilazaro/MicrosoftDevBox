param customRoleName string
param identityId string

resource customRoleAssignment 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
  name: guid(subscription().subscriptionId, customRoleName)
  properties: {
    roleDefinitionId: resourceId('Microsoft.Authorization/roleDefinitions', customRoleName)
    principalId: identityId
    scope: format('/subscriptions/{0}/resourcegroups/{1}', subscription().subscriptionId, resourceGroup().name)
  } 
}

output customRoleAssignmentName string = customRoleAssignment.name
output customRoleAssignmentId string = customRoleAssignment.id
output customRoleAssignmentScope string = customRoleAssignment.properties.scope
output customRoleAssignmentPrincipalId string = customRoleAssignment.properties.principalId
output customRoleAssignmentRoleDefinitionId string = customRoleAssignment.properties.roleDefinitionId
