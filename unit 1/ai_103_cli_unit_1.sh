# AI-103 Unit 1 - Azure CLI Commands

# 1. Create a resource group in East US 2
# Purpose: Creates a container in Azure to hold all Unit 1 resources.
az group create --name aiagent-course-rg --location eastus2

# 2. Deploy the Bicep file
# Purpose: Creates the Azure AI Foundry resource and project from the Bicep blueprint.
az deployment group create --resource-group aiagent-course-rg --name ai_103_bicep_unit_1 --template-file ai_103_bicep_unit_1.bicep --parameters coursePrefix=anish0703unit1

# 3. Get deployment outputs
# Purpose: Shows endpoint, AI Foundry name, and project name created by Bicep.
az deployment group show --resource-group aiagent-course-rg --name ai_103_bicep_unit_1 --query properties.outputs

# 4. View resources created
# Purpose: Lists all resources inside the Unit 1 resource group.
az resource list --resource-group aiagent-course-rg --output table

# 5. Delete the entire resource group AFTER the lab is complete
# Purpose: Deletes all Unit 1 resources to stop future Azure charges.
az group delete --name aiagent-course-rg --yes --no-wait

# 6. Verify deletion of deployed resources
# Purpose: Confirms whether the resource group still exists.
az group list --output table

# 7. View recently deleted Cognitive Services accounts
# Purpose: Checks if deleted AI services are still in soft-delete.
az cognitiveservices account list-deleted --output table

# 8. Permanently purge the soft-deleted AI Foundry account if needed
# Purpose: Fully removes the deleted AI service name so it can be reused.
az cognitiveservices account purge --location eastus2 --resource-group aiagent-course-rg --name anish0703unit1