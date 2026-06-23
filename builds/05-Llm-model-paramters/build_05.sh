# AI-103 Build 05 - Azure CLI Commands
# Build: Unit 5 - LLM-modelparamters

# 1. Create a resource group in East US 2
az group create --name aiagent-course-rg --location eastus2

# 2. Get signed-in user's Azure Principal ID
PRINCIPAL_ID=$(az ad signed-in-user show --query id -o tsv)
echo $PRINCIPAL_ID

# 3. Deploy the Bicep file
az deployment group create \
  --resource-group aiagent-course-rg \
  --name ai_103_build_05 \
  --template-file build_05.bicep \
  --parameters coursePrefix=anish0703build5 principalId=$PRINCIPAL_ID

# 4. Get deployment outputs
az deployment group show \
  --resource-group aiagent-course-rg \
  --name ai_103_build_05 \
  --query properties.outputs

# 5. View created resources
az resource list \
  --resource-group aiagent-course-rg \
  --output table

# 6. Verify Azure login
az account show --output table

# 7. Verify RBAC role assignments
az role assignment list \
  --assignee $PRINCIPAL_ID \
  --all \
  --output table

# 8. Wait for RBAC propagation
echo "Wait 2-5 minutes before running Python."

# 9. Delete resource group AFTER completing the build
az group delete --name aiagent-course-rg --yes --no-wait

# 10. Verify deletion
az group list --output table

# 11. View soft-deleted Cognitive Services accounts
az cognitiveservices account list-deleted --output table

# 12. Purge AI Foundry account if needed
az cognitiveservices account purge \
  --location eastus2 \
  --resource-group aiagent-course-rg \
  --name anish0703build5

# 13. Purge Content Safety account if needed
az cognitiveservices account purge \
  --location eastus2 \
  --resource-group aiagent-course-rg \
  --name anish0703build5-csafety