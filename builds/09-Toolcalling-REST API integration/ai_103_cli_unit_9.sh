#!/bin/bash

# AI-103 Unit 9 - Azure CLI Commands
# Build 09: Tool Calling & REST API Integration
# Purpose:
# Deploy Azure AI Foundry, model deployments, Azure AI Content Safety,
# and required RBAC permissions for REST API tool calling.

# ------------------------------------------------------------
# Configuration
# ------------------------------------------------------------
RESOURCE_GROUP="aiagent-course-rg"
LOCATION="eastus"
COURSE_PREFIX="anish0703build9"
DEPLOYMENT_NAME="ai_103_build_09"
BICEP_FILE="ai_103_build_09.bicep"

AI_FOUNDRY_NAME="$COURSE_PREFIX"
CONTENT_SAFETY_NAME="${COURSE_PREFIX}-csafety"

# ------------------------------------------------------------
# 1. Create a resource group
# Purpose: Creates the Azure container that holds all Build 09 resources.
# Note: Using eastus because previous builds had region/capacity issues.
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
# Purpose:
# Creates Azure AI Foundry, AI Project, GPT-4.1 Mini,
# GPT-4.1 Nano, Content Safety, and RBAC permissions.
# ------------------------------------------------------------

az deployment group create \
  --resource-group $RESOURCE_GROUP \
  --name $DEPLOYMENT_NAME \
  --template-file $BICEP_FILE \
  --parameters coursePrefix=$COURSE_PREFIX userObjectId=$USER_OBJECT_ID

# ------------------------------------------------------------
# 6. Get deployment outputs
# Purpose:
# Displays endpoints and deployment names needed in Python/launch.json.
# ------------------------------------------------------------

az deployment group show \
  --resource-group $RESOURCE_GROUP \
  --name $DEPLOYMENT_NAME \
  --query properties.outputs \
  --output json

# ------------------------------------------------------------
# 7. List deployed Azure resources
# Purpose: Verifies all Build 09 resources were created.
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
# Purpose:
# Confirms GPT-4.1 Mini and GPT-4.1 Nano deployments exist.
# Important: Azure OpenAI SDK uses deployment names, not base model names.
# ------------------------------------------------------------

az cognitiveservices account deployment list \
  --resource-group $RESOURCE_GROUP \
  --name $AI_FOUNDRY_NAME \
  --output table

# ------------------------------------------------------------
# 10. Validate Azure Content Safety account
# Purpose: Confirms Content Safety resource exists.
# ------------------------------------------------------------

az cognitiveservices account show \
  --resource-group $RESOURCE_GROUP \
  --name $CONTENT_SAFETY_NAME \
  --output table

# ------------------------------------------------------------
# 11. Assign RBAC roles manually if needed
# Purpose:
# These are fallback commands if Bicep RBAC fails or propagation is delayed.
#
# Cognitive Services User:
# Allows calling Azure AI Foundry / Azure OpenAI APIs.
#
# Note:
# Build 09 does NOT use Azure AI Search.
# Search RBAC roles are intentionally not included.
# ------------------------------------------------------------

AI_FOUNDRY_ID=$(az cognitiveservices account show \
  --resource-group $RESOURCE_GROUP \
  --name $AI_FOUNDRY_NAME \
  --query id -o tsv)

CONTENT_SAFETY_ID=$(az cognitiveservices account show \
  --resource-group $RESOURCE_GROUP \
  --name $CONTENT_SAFETY_NAME \
  --query id -o tsv)

az role assignment create \
  --assignee $USER_OBJECT_ID \
  --role "Cognitive Services User" \
  --scope $AI_FOUNDRY_ID

az role assignment create \
  --assignee $USER_OBJECT_ID \
  --role "Cognitive Services User" \
  --scope $CONTENT_SAFETY_ID

# ------------------------------------------------------------
# 12. Refresh Azure login after RBAC assignment
# Purpose: Forces token refresh after role assignments.
# RBAC propagation can take 2-5 minutes.
# ------------------------------------------------------------

echo "Wait 2-5 minutes for RBAC propagation, then run:"
echo "az logout"
echo "az login"

# ------------------------------------------------------------
# 13. Verify role assignments
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

# ------------------------------------------------------------
# 14. Cleanup command
# Purpose:
# Deletes the resource group and all Build 09 resources.
# WARNING: This removes deployed resources.
# ------------------------------------------------------------

# az group delete \
#   --name $RESOURCE_GROUP \
#   --yes \
#   --no-wait

# ------------------------------------------------------------
# 15. Verify resource group deletion
# Purpose: Lists remaining resource groups after cleanup.
# ------------------------------------------------------------

# az group list \
#   --output table

# ------------------------------------------------------------
# 16. List soft-deleted Cognitive Services accounts
# Purpose:
# Finds deleted AI Services accounts that may block name reuse.
# ------------------------------------------------------------

# az cognitiveservices account list-deleted \
#   --output table

# ------------------------------------------------------------
# 17. Purge soft-deleted AI Foundry account if needed
# Purpose:
# Permanently deletes the soft-deleted AI Foundry resource.
# Only run if the deleted account appears in list-deleted output.
# ------------------------------------------------------------

# az cognitiveservices account purge \
#   --location $LOCATION \
#   --resource-group $RESOURCE_GROUP \
#   --name $AI_FOUNDRY_NAME

# ------------------------------------------------------------
# 18. Purge soft-deleted Content Safety account if needed
# Purpose:
# Permanently deletes the soft-deleted Content Safety resource.
# Only run if the deleted account appears in list-deleted output.
# ------------------------------------------------------------

# az cognitiveservices account purge \
#   --location $LOCATION \
#   --resource-group $RESOURCE_GROUP \
#   --name $CONTENT_SAFETY_NAME