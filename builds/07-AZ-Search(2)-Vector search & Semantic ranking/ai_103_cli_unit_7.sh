# AI-103 Unit 7 - Azure CLI Commands
# Build 07: Azure AI Search Vector Search & Semantic Ranking

# 1. Create a resource group
# Purpose: Creates a container in Azure to hold all Build 07 resources.
# Note: eastus was used because eastus2 had temporary capacity issues.

az group create --name aiagent-course-rg --location eastus


# 2. Deploy the Bicep file
# Purpose: Deploys Azure AI Services, Azure AI Search, and related Build 07 resources.

az deployment group create \
  --resource-group aiagent-course-rg \
  --name ai_103_bicep_unit_7 \
  --template-file ai_103_bicep_unit_7.bicep \
  --parameters coursePrefix=anish0703build7 location=eastus


# 3. Get deployment outputs
# Purpose: Retrieves endpoints and resource names created by the deployment.

az deployment group show \
  --resource-group aiagent-course-rg \
  --name ai_103_bicep_unit_7 \
  --query properties.outputs


# 4. Get subscription ID
# Purpose: Needed for RBAC scope paths.

az account show --query id --output tsv


# 5. Get signed-in user object ID
# Purpose: Used as the assignee object ID in role assignments.

az ad signed-in-user show --query id -o tsv


# 6. Verify signed-in user
# Purpose: Confirms the correct user is logged in.

az ad signed-in-user show \
  --query "{displayName:displayName, objectId:id, userPrincipalName:userPrincipalName}" \
  --output table


# 7. List Azure AI Search services
# Purpose: Confirms the deployed Search service name.

az search service list \
  --resource-group aiagent-course-rg \
  --query "[].{name:name, location:location}" \
  --output table


# 8. List Azure AI Services accounts
# Purpose: Confirms the deployed Azure AI Services account name.

az cognitiveservices account list \
  --resource-group aiagent-course-rg \
  --query "[].{name:name, kind:kind, location:location}" \
  --output table


# 9. List Azure OpenAI model deployments
# Purpose: Finds the embedding deployment name required by the Python SDK.

az cognitiveservices account deployment list \
  --resource-group aiagent-course-rg \
  --name anish0703build7 \
  --output table


# 10. Assign Search Service Contributor
# Purpose: Allows management of the Azure AI Search service.

az role assignment create \
  --assignee-object-id "04ba9bfe-a1a4-433d-b123-b49c3e95f3c8" \
  --assignee-principal-type User \
  --role "Search Service Contributor" \
  --scope "/subscriptions/1ac0dfa8-d5f0-4156-a7d8-560c17c89da8/resourceGroups/aiagent-course-rg/providers/Microsoft.Search/searchServices/anish0703build7-aisearch"


# 11. Assign Search Index Data Contributor
# Purpose: Allows creating indexes and uploading documents.

az role assignment create \
  --assignee-object-id "04ba9bfe-a1a4-433d-b123-b49c3e95f3c8" \
  --assignee-principal-type User \
  --role "Search Index Data Contributor" \
  --scope "/subscriptions/1ac0dfa8-d5f0-4156-a7d8-560c17c89da8/resourceGroups/aiagent-course-rg/providers/Microsoft.Search/searchServices/anish0703build7-aisearch"


# 12. Assign Search Index Data Reader
# Purpose: Allows querying and reading search index data.

az role assignment create \
  --assignee-object-id "04ba9bfe-a1a4-433d-b123-b49c3e95f3c8" \
  --assignee-principal-type User \
  --role "Search Index Data Reader" \
  --scope "/subscriptions/1ac0dfa8-d5f0-4156-a7d8-560c17c89da8/resourceGroups/aiagent-course-rg/providers/Microsoft.Search/searchServices/anish0703build7-aisearch"


# 13. Assign Cognitive Services OpenAI User
# Purpose: Allows calling Azure OpenAI embeddings.

az role assignment create \
  --assignee-object-id "04ba9bfe-a1a4-433d-b123-b49c3e95f3c8" \
  --assignee-principal-type User \
  --role "Cognitive Services OpenAI User" \
  --scope "/subscriptions/1ac0dfa8-d5f0-4156-a7d8-560c17c89da8/resourceGroups/aiagent-course-rg/providers/Microsoft.CognitiveServices/accounts/anish0703build7"


# 14. Refresh Azure login token
# Purpose: Ensures new RBAC permissions are picked up locally.

az logout
az login


# 15. Delete the resource group
# Purpose: Deletes all Build 07 resources to avoid costs.

az group delete --name aiagent-course-rg --yes --no-wait


# 16. Verify resource group deletion

az group list --output table


# 17. List soft-deleted Cognitive Services accounts

az cognitiveservices account list-deleted --output table


# 18. Purge soft-deleted Azure AI Services account
# Purpose: Permanently deletes the soft-deleted account so the name can be reused.

az cognitiveservices account purge \
  --location eastus \
  --resource-group aiagent-course-rg \
  --name anish0703build7