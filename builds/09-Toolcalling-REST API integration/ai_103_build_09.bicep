// AI-103 Build 09 - Multi-Agent Orchestration
// Azure AI Foundry + Project + Model Deployments + Content Safety + RBAC

param coursePrefix string
param userObjectId string

param aiFoundryName string = coursePrefix
param aiProjectName string = '${aiFoundryName}-proj'
param contentSafetyName string = '${coursePrefix}-csafety'
param location string = resourceGroup().location

param llmModelDeploymentName string = '${coursePrefix}-llm-deploy'
param slmModelDeploymentName string = '${coursePrefix}-slm-deploy'

// Built-in Azure RBAC Role Definition IDs
var cognitiveServicesUserRoleId = 'a97b65f3-24c7-4388-baec-2e87135dc908'
var cognitiveServicesOpenAIUserRoleId = '5e0bd9bd-7b93-4f28-af87-19fc36ad61bd'

// Azure AI Foundry resource
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
    disableLocalAuth: false
  }
}

// Azure AI Foundry Project
resource aiProject 'Microsoft.CognitiveServices/accounts/projects@2025-06-01' = {
  name: aiProjectName
  parent: aiFoundry
  location: location
  identity: {
    type: 'SystemAssigned'
  }
  properties: {}
}

// LLM deployment
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

// GPT-4.1 Nano Deployment (Small Language Model)
resource slmModelDeployment 'Microsoft.CognitiveServices/accounts/deployments@2025-06-01' = {
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
      name: 'gpt-4.1-nano'
      format: 'OpenAI'
      version: '2025-04-14'
    }
  }
}

// Content Safety resource
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
    disableLocalAuth: false
  }
}

// RBAC: Give signed-in user access to Azure AI Foundry
resource aiFoundryCognitiveUserRole 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
  name: guid(aiFoundry.id, userObjectId, cognitiveServicesUserRoleId)
  scope: aiFoundry
  properties: {
    roleDefinitionId: subscriptionResourceId('Microsoft.Authorization/roleDefinitions', cognitiveServicesUserRoleId)
    principalId: userObjectId
    principalType: 'User'
  }
}

// RBAC: Give signed-in user Azure OpenAI access
resource aiFoundryOpenAIUserRole 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
  name: guid(aiFoundry.id, userObjectId, cognitiveServicesOpenAIUserRoleId)
  scope: aiFoundry
  properties: {
    roleDefinitionId: subscriptionResourceId('Microsoft.Authorization/roleDefinitions', cognitiveServicesOpenAIUserRoleId)
    principalId: userObjectId
    principalType: 'User'
  }
}

// RBAC: Give signed-in user Content Safety access
resource contentSafetyUserRole 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
  name: guid(contentSafety.id, userObjectId, cognitiveServicesUserRoleId)
  scope: contentSafety
  properties: {
    roleDefinitionId: subscriptionResourceId('Microsoft.Authorization/roleDefinitions', cognitiveServicesUserRoleId)
    principalId: userObjectId
    principalType: 'User'
  }
}

// Outputs
output AI_FOUNDRY_NAME string = aiFoundry.name
output AI_PROJECT_NAME string = aiProject.name

output OPENAI_ENDPOINT string = 'https://${aiFoundry.properties.customSubDomainName}.services.ai.azure.com/openai/v1'
output LLM_MODEL_DEPLOYMENT_NAME string = llmModelDeployment.name
output SLM_MODEL_DEPLOYMENT_NAME string = slmModelDeployment.name

output CONTENT_SAFETY_NAME string = contentSafety.name
output CONTENT_SAFETY_ENDPOINT string = 'https://${contentSafety.properties.customSubDomainName}.cognitiveservices.azure.com/'
