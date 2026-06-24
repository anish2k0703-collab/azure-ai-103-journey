# First, create a resource group (if you haven't already)
az group create --name aiagent-course-rg --location eastus

# Deploy the Bicep file
az deployment group create --resource-group aiagent-course-rg --template-file ai_103_bicep_unit_6.bicep --parameters coursePrefix=unit6course

# Get your deployment outputs
az deployment group show --resource-group aiagent-course-rg --name ai_103_bicep_unit_6 --query properties.outputs

# Get the object ID of the currently signed-in user
az ad signed-in-user show --query id -o tsv

# 1. Assign "Search Service Contributor"
# Purpose: Allows management of the Azure AI Search service
# itself (service settings, indexes, and configurations).

az role assignment create \
  --assignee-object-id "04ba9bfe-a1a4-433d-b123-b49c3e95f3c8" \
  --assignee-principal-type User \
  --role "Search Service Contributor" \
  --scope "/subscriptions/1ac0dfa8-d5f0-4156-a7d8-560c17c89da8/resourceGroups/aiagent-course-rg/providers/Microsoft.Search/searchServices/anish0703build6-aisearch"


# 2. Assign "Search Index Data Contributor"
# Purpose: Allows creating, updating, deleting, and managing
# documents inside Azure AI Search indexes.

az role assignment create \
  --assignee-object-id "04ba9bfe-a1a4-433d-b123-b49c3e95f3c8" \
  --assignee-principal-type User \
  --role "Search Index Data Contributor" \
  --scope "/subscriptions/1ac0dfa8-d5f0-4156-a7d8-560c17c89da8/resourceGroups/aiagent-course-rg/providers/Microsoft.Search/searchServices/anish0703build6-aisearch"


# 3. Assign "Search Index Data Reader"
# Purpose: Allows querying and reading data stored inside
# Azure AI Search indexes without modifying them.

az role assignment create \
  --assignee-object-id "04ba9bfe-a1a4-433d-b123-b49c3e95f3c8" \
  --assignee-principal-type User \
  --role "Search Index Data Reader" \
  --scope "/subscriptions/1ac0dfa8-d5f0-4156-a7d8-560c17c89da8/resourceGroups/aiagent-course-rg/providers/Microsoft.Search/searchServices/anish0703build6-aisearch"

# Delete the entire deployment (So no more costs)
az group delete --name aiagent-course-rg --yes --no-wait

# Verify deletion of deployed resources
az group list --output table

# View recently deleted Cognitive Services accounts in the region (to confirm deletion)
az cognitiveservices account list-deleted --output table

# The following commands permanently delete the soft-deleted accounts.
az cognitiveservices account purge --location australiaeast --resource-group aiagent-course-rg --name unit6course