// AI-103 Build 08 - Agentic RAG Infrastructure
// Purpose:
// Deploy Azure AI Foundry, Azure AI Foundry Project, model deployments,
// Azure AI Search, Azure AI Content Safety, and automatic RBAC permissions.
//
// Based on:
// https://github.com/microsoft-foundry/foundry-samples/blob/main/infrastructure/infrastructure-setup-bicep/00-basic/main.bicep
//
// Build Focus:
// Agentic RAG = an AI agent that can reason, search enterprise data,
// retrieve grounding context, and produce safer, better answers.

// =============================
// Parameters
// =============================

param coursePrefix string

// Used for automatic RBAC role assignments.
// Pass from CLI:
// userObjectId=$(az ad signed-in-user show --query id -o tsv)
param userObjectId string

param aiFoundryName string = coursePrefix
param aiProjectName string = '${aiFoundryName}-proj'
param contentSafetyName string = '${coursePrefix}-csafety'
param aiSearchName string = '${coursePrefix}-aisearch'
param location string = resourceGroup().location

param llmModelDeploymentName string = '${coursePrefix}-llm-deploy'
param slmModelDeploymentName string = '${coursePrefix}-slm-deploy'
param embeddingModelDeploymentName string = '${coursePrefix}-embedding-deploy'

// =============================
// Built-in RBAC Role IDs
// =============================

// Allows user/app to call Azure AI Foundry and Content Safety APIs.
var cognitiveServicesUserRoleId = subscriptionResourceId(
  'Microsoft.Authorization/roleDefinitions',
  'a97b65f3-24c7-4388-baec-2e87135dc908'
)

// Allows management of Azure AI Search service objects like indexes.
var searchServiceContributorRoleId = subscriptionResourceId(
  'Microsoft.Authorization/roleDefinitions',
  '7ca78c08-252a-4471-8644-bb5ff32d4ba0'
)

// Allows uploading, updating, and deleting documents in search indexes.
var searchIndexDataContributorRoleId = subscriptionResourceId(
  'Microsoft.Authorization/roleDefinitions',
  '8ebe5a00-799e-43f5-93ac-243d3dce84a7'
)

// Allows reading/querying documents from search indexes.
var searchIndexDataReaderRoleId = subscriptionResourceId(
  'Microsoft.Authorization/roleDefinitions',
  '1407120a-92aa-4202-b7e9-c0e197c71c8f'
)

// =============================
// Azure AI Foundry Resource
// =============================

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

// =============================
// Azure AI Foundry Project
// =============================

resource aiProject 'Microsoft.CognitiveServices/accounts/projects@2025-06-01' = {
  name: aiProjectName
  parent: aiFoundry
  location: location
  identity: {
    type: 'SystemAssigned'
  }
  properties: {}
}

// =============================
// LLM Model Deployment
// =============================

resource llmModelDeployment 'Microsoft.CognitiveServices/accounts/deployments@2025-06-01' = {
  parent: aiFoundry
  name: llmModelDeploymentName
  sku: {
    capacity: 1
    name: 'GlobalStandard'
  }
  properties: {
    model: {
      name: 'gpt-4.1-mini'
      format: 'OpenAI'
      version: '2025-04-14'
    }
  }
}

// =============================
// SLM Model Deployment
// =============================

resource slmModelDeployment 'Microsoft.CognitiveServices/accounts/deployments@2025-06-01' = {
  parent: aiFoundry
  name: slmModelDeploymentName
  dependsOn: [
    llmModelDeployment
  ]
  sku: {
    capacity: 1
    name: 'GlobalStandard'
  }
  properties: {
    model: {
      name: 'gpt-4o-mini'
      format: 'OpenAI'
      version: '2024-07-18'
    }
  }
}

// =============================
// Embedding Model Deployment
// =============================

resource embeddingModelDeployment 'Microsoft.CognitiveServices/accounts/deployments@2025-06-01' = {
  parent: aiFoundry
  name: embeddingModelDeploymentName
  dependsOn: [
    slmModelDeployment
  ]
  sku: {
    capacity: 1
    name: 'GlobalStandard'
  }
  properties: {
    model: {
      name: 'text-embedding-3-small'
      format: 'OpenAI'
      version: '1'
    }
  }
}

// =============================
// Azure AI Search
// =============================

resource searchService 'Microsoft.Search/searchServices@2023-11-01' = {
  name: aiSearchName
  location: location
  sku: {
    name: 'standard'
  }
  properties: {
    replicaCount: 1
    partitionCount: 1
    hostingMode: 'default'
    disableLocalAuth: true
  }
}

// =============================
// Azure AI Content Safety
// =============================

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

// =============================
// RBAC - Azure AI Foundry
// =============================

resource aiFoundryCognitiveServicesUserRole 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
  name: guid(aiFoundry.id, userObjectId, 'ai-foundry-cognitive-services-user')
  scope: aiFoundry
  properties: {
    roleDefinitionId: cognitiveServicesUserRoleId
    principalId: userObjectId
    principalType: 'User'
  }
}

// =============================
// RBAC - Content Safety
// =============================

resource contentSafetyCognitiveServicesUserRole 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
  name: guid(contentSafety.id, userObjectId, 'content-safety-cognitive-services-user')
  scope: contentSafety
  properties: {
    roleDefinitionId: cognitiveServicesUserRoleId
    principalId: userObjectId
    principalType: 'User'
  }
}

// =============================
// RBAC - Azure AI Search
// =============================

resource searchServiceContributorRole 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
  name: guid(searchService.id, userObjectId, 'search-service-contributor')
  scope: searchService
  properties: {
    roleDefinitionId: searchServiceContributorRoleId
    principalId: userObjectId
    principalType: 'User'
  }
}

resource searchIndexDataContributorRole 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
  name: guid(searchService.id, userObjectId, 'search-index-data-contributor')
  scope: searchService
  properties: {
    roleDefinitionId: searchIndexDataContributorRoleId
    principalId: userObjectId
    principalType: 'User'
  }
}

resource searchIndexDataReaderRole 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
  name: guid(searchService.id, userObjectId, 'search-index-data-reader')
  scope: searchService
  properties: {
    roleDefinitionId: searchIndexDataReaderRoleId
    principalId: userObjectId
    principalType: 'User'
  }
}

// =============================
// Outputs
// =============================

output AI_FOUNDRY_NAME string = aiFoundry.name
output AI_PROJECT_NAME string = aiProject.name

output OPENAI_ENDPOINT string = 'https://${aiFoundry.properties.customSubDomainName}.services.ai.azure.com/openai/v1'

output LLM_MODEL_DEPLOYMENT_NAME string = llmModelDeployment.name
output SLM_MODEL_DEPLOYMENT_NAME string = slmModelDeployment.name
output EMBEDDING_MODEL_DEPLOYMENT_NAME string = embeddingModelDeployment.name

output AI_SEARCH_SERVICE_ENDPOINT string = 'https://${searchService.name}.search.windows.net'
output AI_SEARCH_SERVICE_NAME string = searchService.name

output CONTENT_SAFETY_ENDPOINT string = 'https://${contentSafety.properties.customSubDomainName}.cognitiveservices.azure.com/'
output CONTENT_SAFETY_NAME string = contentSafety.name
