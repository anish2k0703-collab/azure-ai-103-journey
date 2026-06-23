param coursePrefix string
param principalId string

param aiFoundryName string = coursePrefix
param aiProjectName string = '${aiFoundryName}-proj'
param contentSafetyName string = '${coursePrefix}-csafety'
param location string = resourceGroup().location

param llmModelDeploymentName string = '${coursePrefix}-llm-deploy'
param slmModelDeploymentName string = '${coursePrefix}-slm-deploy'

// RBAC role IDs
var cognitiveServicesOpenAIUserRoleId = '5e0bd9bd-7b93-4f28-af87-19fc36ad61bd'
var cognitiveServicesUserRoleId = 'a97b65f3-24c7-4388-baec-2e87135dc908'

resource aiFoundry 'Microsoft.CognitiveServices/accounts@2025-06-01' = {
  name: aiFoundryName
  location: location
  identity: {
    type: 'SystemAssigned'
  }
  sku: {
    name: 'S0'
  }
  kind: 'AIServices'
  properties: {
    allowProjectManagement: true
    customSubDomainName: aiFoundryName
    disableLocalAuth: true
  }
}

resource aiProject 'Microsoft.CognitiveServices/accounts/projects@2025-06-01' = {
  name: aiProjectName
  parent: aiFoundry
  location: location
  identity: {
    type: 'SystemAssigned'
  }
  properties: {}
}

resource llmModelDeployment 'Microsoft.CognitiveServices/accounts/deployments@2025-06-01' = {
  parent: aiFoundry
  name: llmModelDeploymentName
  sku: {
    name: 'GlobalStandard'
    capacity: 1
  }
  properties: {
    model: {
      name: 'gpt-4.1-mini'
      format: 'OpenAI'
      version: '2025-04-14'
    }
  }
}

/* resource slmModelDeployment 'Microsoft.CognitiveServices/accounts/deployments@2025-06-01' = {
  parent: aiFoundry
  name: slmModelDeploymentName
  dependsOn: [
    llmModelDeployment
  ]
  sku: {
    name: 'GlobalStandard'
    capacity: 1
  }
  properties: {
    model: {
      name: 'gpt-4o-mini'
      format: 'OpenAI'
      version: '2024-07-18'
    }
  }
}*/

resource contentSafety 'Microsoft.CognitiveServices/accounts@2025-06-01' = {
  name: contentSafetyName
  location: location
  identity: {
    type: 'SystemAssigned'
  }
  sku: {
    name: 'S0'
  }
  kind: 'ContentSafety'
  properties: {
    customSubDomainName: contentSafetyName
    disableLocalAuth: true
  }
}

// Gives signed-in user permission to call Azure OpenAI model deployments
resource openAIRoleAssignment 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
  name: guid(aiFoundry.id, principalId, cognitiveServicesOpenAIUserRoleId)
  scope: aiFoundry
  properties: {
    principalId: principalId
    principalType: 'User'
    roleDefinitionId: subscriptionResourceId(
      'Microsoft.Authorization/roleDefinitions',
      cognitiveServicesOpenAIUserRoleId
    )
  }
}

// Gives signed-in user permission to call Content Safety
resource contentSafetyRoleAssignment 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
  name: guid(contentSafety.id, principalId, cognitiveServicesUserRoleId)
  scope: contentSafety
  properties: {
    principalId: principalId
    principalType: 'User'
    roleDefinitionId: subscriptionResourceId(
      'Microsoft.Authorization/roleDefinitions',
      cognitiveServicesUserRoleId
    )
  }
}

output AI_FOUNDRY_NAME string = aiFoundry.name
output AI_PROJECT_NAME string = aiProject.name
output OPENAI_ENDPOINT string = 'https://${aiFoundry.properties.customSubDomainName}.services.ai.azure.com/openai/v1'
output LLM_MODEL_DEPLOYMENT_NAME string = llmModelDeployment.name
//output SLM_MODEL_DEPLOYMENT_NAME string = slmModelDeployment.name
output AI_FOUNDRY_RESOURCE_ID string = aiFoundry.id

output CONTENT_SAFETY_NAME string = contentSafety.name
output CONTENT_SAFETY_ENDPOINT string = 'https://${contentSafety.properties.customSubDomainName}.cognitiveservices.azure.com/'
output CONTENT_SAFETY_RESOURCE_ID string = contentSafety.id
