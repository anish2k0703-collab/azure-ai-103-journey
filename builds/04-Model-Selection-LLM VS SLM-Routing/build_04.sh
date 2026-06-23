```bash
# AI-103 Build 04 - Azure CLI Commands
# Build: Model Selection - LLM vs SLM Routing

# 1. Create a resource group in East US 2
# Purpose: Creates a container in Azure to hold all Build 04 resources.
az group create --name aiagent-course-rg --location eastus2

# 2. Get the signed-in user's Azure Principal ID
# Purpose: Captures the current Azure user's identity so Bicep can assign RBAC permissions automatically.
PRINCIPAL_ID=$(az ad signed-in-user show --query id -o tsv)
echo $PRINCIPAL_ID

# 3. Deploy the Bicep file
# Purpose: Creates Azure AI Foundry, AI Project, LLM deployment, SLM deployment, Content Safety, and RBAC role assignments.
az deployment group create --resource-group aiagent-course-rg --name ai_103_build_04 --template-file build_04.bicep --parameters coursePrefix=anish0703build4 principalId=$PRINCIPAL_ID

# 4. Get deployment outputs
# Purpose: Shows Azure OpenAI endpoint, LLM deployment name, SLM deployment name, Content Safety endpoint, AI Foundry name, and project name.
az deployment group show --resource-group aiagent-course-rg --name ai_103_build_04 --query properties.outputs

# 5. View resources created
# Purpose: Lists all resources inside the Build 04 resource group.
az resource list --resource-group aiagent-course-rg --output table

# 6. Verify Azure login
# Purpose: Confirms which Azure subscription and tenant are currently active.
az account show --output table

# 7. Verify RBAC assignments
# Purpose: Confirms that the signed-in user has runtime permissions for Azure OpenAI and Content Safety.
az role assignment list --assignee $PRINCIPAL_ID --all --output table

# 8. Wait for RBAC propagation
# Purpose: Azure role assignments can take 2-5 minutes before Python can successfully use the services.
echo "Wait 2-5 minutes before running the Python debugger."

# 9. Delete the entire resource group AFTER the build is complete
# Purpose: Deletes all Build 04 resources to stop future Azure charges.
az group delete --name aiagent-course-rg --yes --no-wait

# 10. Verify deletion of deployed resources
# Purpose: Confirms whether the resource group still exists.
az group list --output table

# 11. View recently deleted Cognitive Services accounts
# Purpose: Checks if deleted AI services are still in soft-delete.
az cognitiveservices account list-deleted --output table

# 12. Permanently purge the soft-deleted AI Foundry account if needed
# Purpose: Fully removes the deleted AI Foundry service name so it can be reused.
az cognitiveservices account purge --location eastus2 --resource-group aiagent-course-rg --name anish0703build4

# 13. Permanently purge the soft-deleted Content Safety account if needed
# Purpose: Fully removes the deleted Content Safety service name so it can be reused.
az cognitiveservices account purge --location eastus2 --resource-group aiagent-course-rg --name anish0703build4-csafety
```
