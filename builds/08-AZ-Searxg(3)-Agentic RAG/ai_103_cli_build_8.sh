#!/bin/bash

# AI-103 Unit 8 - Azure CLI Commands
# Build 08: Agentic RAG with Azure AI Search
# Purpose:
# Deploy Azure AI Foundry, model deployments, Azure AI Search,
# Azure AI Content Safety, and required RBAC permissions.

# ------------------------------------------------------------
# Configuration
# ------------------------------------------------------------

RESOURCE_GROUP="aiagent-course-rg"
LOCATION="eastus"
COURSE_PREFIX="anish0703build8"
DEPLOYMENT_NAME="ai_103_bicep_unit_8"
BICEP_FILE="ai_103_bicep_unit_8.bicep"

AI_FOUNDRY_NAME="$COURSE_PREFIX"
AI_SEARCH_NAME="${COURSE_PREFIX}-aisearch"
CONTENT_SAFETY_NAME="${COURSE_PREFIX}-csafety"

# ------------------------------------------------------------
# 1. Create a resource group
# Purpose: Creates the Azure container that holds all Build 08 resources.
# Note: Using eastus because eastus2 caused capacity issues in previous builds.
# ------------------------------------------------------------

az group create \
  --name $RESOURCE_GROUP \
  --location $LOCATION \
  --output table

# ------------------------------------------------------------
# 2. Get subscription ID
# Purpose: Confirms which Azure subscription is being used.
# ------------------------------------------------------------

SUBSCRIPTION_ID=$(az account show --query id -o tsv)
echo "Subscription ID: $SUBSCRIPTION_ID"

# ------------------------------------------------------------
# 3. Verify signed-in user
# Purpose: Confirms the active Azure identity before deployment/RBAC.
# ------------------------------------------------------------

az account show --output table

# ------------------------------------------------------------
# 4. Get signed-in user object ID
# Purpose: Required for Bicep RBAC role assignments.
# ------------------------------------------------------------

USER_OBJECT_ID=$(az ad signed-in-user show --query id -o tsv)
echo "Signed-in User Object ID: $USER_OBJECT_ID"

# ------------------------------------------------------------
# 5. Deploy the Bicep file
# Purpose: Creates AI Foundry, project, model deployments,
# Azure AI Search, Content Safety, and RBAC permissions.
# ------------------------------------------------------------

az deployment group create \
  --resource-group $RESOURCE_GROUP \
  --name $DEPLOYMENT_NAME \
  --template-file $BICEP_FILE \
  --parameters coursePrefix=$COURSE_PREFIX userObjectId=$USER_OBJECT_ID \
  --output table

# ------------------------------------------------------------
# 6. Get deployment outputs
# Purpose: Displays endpoints and deployment names needed in Python/launch.json.
# ------------------------------------------------------------

az deployment group show \
  --resource-group $RESOURCE_GROUP \
  --name $DEPLOYMENT_NAME \
  --query properties.outputs \
  --output json

# ------------------------------------------------------------
# 7. List deployed Azure resources
# Purpose: Verifies all Build 08 resources were created.
# ------------------------------------------------------------

az resource list \
  --resource-group $RESOURCE_GROUP \
  --output table

# ------------------------------------------------------------
# 8. Validate Azure AI Foundry / AI Services account
# Purpose: Confirms the AI Foundry resource exists and is available.
# ------------------------------------------------------------

az cognitiveservices account show \
  --resource-group $RESOURCE_GROUP \
  --name $AI_FOUNDRY_NAME \
  --output table

# ------------------------------------------------------------
# 9. Validate Azure OpenAI model deployments
# Purpose: Confirms LLM, SLM, and embedding deployments exist.
# Important: Azure OpenAI SDK uses deployment names, not base model names.
# ------------------------------------------------------------

az cognitiveservices account deployment list \
  --resource-group $RESOURCE_GROUP \
  --name $AI_FOUNDRY_NAME \
  --output table

# ------------------------------------------------------------
# 10. Validate Azure AI Search service
# Purpose: Confirms the search service exists and is running.
# ------------------------------------------------------------

az search service show \
  --resource-group $RESOURCE_GROUP \
  --name $AI_SEARCH_NAME \
  --output table

# ------------------------------------------------------------
# 11. Validate Azure Content Safety account
# Purpose: Confirms Content Safety resource exists.
# ------------------------------------------------------------

az cognitiveservices account show \
  --resource-group $RESOURCE_GROUP \
  --name $CONTENT_SAFETY_NAME \
  --output table

# ------------------------------------------------------------
# 12. Assign RBAC roles manually if needed
# Purpose:
# These are fallback commands if Bicep RBAC fails or propagation is delayed.
#
# Cognitive Services User:
# Allows calling Azure AI Foundry / Azure OpenAI APIs.
#
# Search Service Contributor:
# Allows managing Azure AI Search objects such as indexes.
#
# Search Index Data Contributor:
# Allows uploading/updating documents in search indexes.
#
# Search Index Data Reader:
# Allows querying documents from search indexes.
# ------------------------------------------------------------

AI_FOUNDRY_ID=$(az cognitiveservices account show \
  --resource-group $RESOURCE_GROUP \
  --name $AI_FOUNDRY_NAME \
  --query id -o tsv)

CONTENT_SAFETY_ID=$(az cognitiveservices account show \
  --resource-group $RESOURCE_GROUP \
  --name $CONTENT_SAFETY_NAME \
  --query id -o tsv)

AI_SEARCH_ID=$(az search service show \
  --resource-group $RESOURCE_GROUP \
  --name $AI_SEARCH_NAME \
  --query id -o tsv)

az role assignment create \
  --assignee $USER_OBJECT_ID \
  --role "Cognitive Services User" \
  --scope $AI_FOUNDRY_ID

az role assignment create \
  --assignee $USER_OBJECT_ID \
  --role "Cognitive Services User" \
  --scope $CONTENT_SAFETY_ID

az role assignment create \
  --assignee $USER_OBJECT_ID \
  --role "Search Service Contributor" \
  --scope $AI_SEARCH_ID

az role assignment create \
  --assignee $USER_OBJECT_ID \
  --role "Search Index Data Contributor" \
  --scope $AI_SEARCH_ID

az role assignment create \
  --assignee $USER_OBJECT_ID \
  --role "Search Index Data Reader" \
  --scope $AI_SEARCH_ID

# ------------------------------------------------------------
# 13. Refresh Azure login after RBAC assignment
# Purpose: Forces token refresh after role assignments.
# RBAC propagation can take 2-5 minutes.
# ------------------------------------------------------------

echo "Wait 2-5 minutes for RBAC propagation, then run:"
echo "az logout"
echo "az login"

# ------------------------------------------------------------
# 14. Verify role assignments
# Purpose: Confirms required permissions are assigned to signed-in user.
# ------------------------------------------------------------

az role assignment list \
  --assignee $USER_OBJECT_ID \
  --scope $AI_FOUNDRY_ID \
  --output table

az role assignment list \
  --assignee $USER_OBJECT_ID \
  --scope $CONTENT_SAFETY_ID \
  --output table

az role assignment list \
  --assignee $USER_OBJECT_ID \
  --scope $AI_SEARCH_ID \
  --output table

# ------------------------------------------------------------
# 15. Verify Azure AI Search indexes using REST if CLI extension is missing
# Purpose: Useful when 'az search index' is not recognized.
# ------------------------------------------------------------

TOKEN=$(az account get-access-token \
  --resource https://search.azure.com \
  --query accessToken -o tsv)

curl -X GET \
  "https://${AI_SEARCH_NAME}.search.windows.net/indexes?api-version=2024-07-01" \
  -H "Authorization: Bearer $TOKEN"

# ------------------------------------------------------------
# 16. Cleanup command
# Purpose: Deletes the resource group and all Build 08 resources.
# WARNING: This removes deployed resources.
# ------------------------------------------------------------

# az group delete \
#   --name $RESOURCE_GROUP \
#   --yes \
#   --no-wait

# ------------------------------------------------------------
# 17. List soft-deleted Cognitive Services accounts
# Purpose: Finds deleted AI Services accounts that may block name reuse.
# ------------------------------------------------------------

# az cognitiveservices account list-deleted \
#   --output table

# ------------------------------------------------------------
# 18. Purge soft-deleted accounts if needed
# Purpose:
# Fixes CustomDomainInUse / name reuse issues after deleting resources.
# Only run if the deleted account appears in list-deleted output.
# ------------------------------------------------------------

# az cognitiveservices account purge \
#   --location $LOCATION \
#   --resource-group $RESOURCE_GROUP \
#   --name $AI_FOUNDRY_NAME

# az cognitiveservices account purge \
#   --location $LOCATION \
#   --resource-group $RESOURCE_GROUP \
#   --name $CONTENT_SAFETY_NAME