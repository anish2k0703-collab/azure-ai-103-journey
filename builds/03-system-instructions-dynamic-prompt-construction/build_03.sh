```bash
# AI-103 Build 03 - Azure CLI Commands
# Build: System Instructions & Dynamic Prompt Construction

# 1. Create a resource group in East US 2
# Purpose: Creates a container in Azure to hold all Build 03 resources.
az group create --name aiagent-course-rg --location eastus2

# 2. Deploy the Bicep file
# Purpose: Creates the Azure AI Foundry resource, project, model deployment, and Content Safety resource from the Bicep blueprint.
az deployment group create --resource-group aiagent-course-rg --name ai_103_build_03 --template-file build_03.bicep --parameters coursePrefix=anish0703build3

# 3. Get deployment outputs
# Purpose: Shows endpoint, model deployment name, Content Safety endpoint, AI Foundry name, and project name created by Bicep.
az deployment group show --resource-group aiagent-course-rg --name ai_103_build_03 --query properties.outputs

# 4. View resources created
# Purpose: Lists all resources inside the Build 03 resource group.
az resource list --resource-group aiagent-course-rg --output table

# 5. Verify Azure login
# Purpose: Confirms which Azure subscription and tenant are currently active.
az account show --output table

# 6. Verify RBAC assignments
# Purpose: Confirms whether the signed-in user has access to Azure AI resources.
PRINCIPAL_ID=$(az ad signed-in-user show --query id -o tsv)
az role assignment list --assignee $PRINCIPAL_ID --all --output table

# 7. Delete the entire resource group AFTER the build is complete
# Purpose: Deletes all Build 03 resources to stop future Azure charges.
az group delete --name aiagent-course-rg --yes --no-wait

# 8. Verify deletion of deployed resources
# Purpose: Confirms whether the resource group still exists.
az group list --output table

# 9. View recently deleted Cognitive Services accounts
# Purpose: Checks if deleted AI services are still in soft-delete.
az cognitiveservices account list-deleted --output table

# 10. Permanently purge the soft-deleted AI Foundry account if needed
# Purpose: Fully removes the deleted AI service name so it can be reused.
az cognitiveservices account purge --location eastus2 --resource-group aiagent-course-rg --name anish0703build3

# 11. Permanently purge the soft-deleted Content Safety account if needed
# Purpose: Fully removes the deleted Content Safety name so it can be reused.
az cognitiveservices account purge --location eastus2 --resource-group aiagent-course-rg --name anish0703build3-csafety
```
