# Setup Guide – AI-103 Build 07

## 📌 Overview

This guide walks through the complete setup process for **AI-103 Build 07 – Azure AI Search: Vector Search & Semantic Ranking**.

The build provisions Azure AI Search and Azure AI Services, configures the required RBAC permissions, deploys an embedding model, creates a vector-enabled search index, uploads vectorized documents, and performs semantic search using Python.

---

# 💻 Prerequisites

Before starting, ensure the following tools are installed:

* Python 3.10+
* Visual Studio Code
* Azure CLI
* Git
* Azure Subscription
* Azure AI Foundry enabled
* Azure AI Search available in your chosen region

---

# 📁 Project Structure

```text
07-AZ-Search(2)-Vector search & Semantic ranking/
│
├── README.md
├── setup.md
├── troubleshoot.md
├── notes.md
├── requirements.txt
├── ai_103_python_unit_7.py
├── ai_103_bicep_unit_7.bicep
├── ai_103_cli_unit_7.sh
├── screenshots/
└── .vscode/
    └── launch.json
```

---

# 🐍 Create Python Virtual Environment

Create a virtual environment:

```bash
python3 -m venv tutorials
```

Activate it:

```bash
source tutorials/bin/activate
```

Verify that the virtual environment is active:

```bash
which python
```

Expected output:

```text
.../tutorials/bin/python
```

---

# 📦 Install Python Packages

Install all dependencies:

```bash
pip install -r requirements.txt
```

If additional packages are installed, update the requirements file:

```bash
pip freeze > requirements.txt
```

---

# ☁ Azure Login

Authenticate with Azure:

```bash
az login
```

Verify the active subscription:

```bash
az account show --query "{SubscriptionName:name, SubscriptionID:id}" --output table
```

Retrieve your signed-in user object ID:

```bash
az ad signed-in-user show --query id -o tsv
```

---

# 🚀 Deploy Azure Resources

Create the resource group:

```bash
az group create \
    --name aiagent-course-rg \
    --location eastus
```

Deploy the Bicep template:

```bash
az deployment group create \
    --resource-group aiagent-course-rg \
    --name ai_103_bicep_unit_7 \
    --template-file ai_103_bicep_unit_7.bicep \
    --parameters coursePrefix=anish0703build7 location=eastus
```

Retrieve deployment outputs:

```bash
az deployment group show \
    --resource-group aiagent-course-rg \
    --name ai_103_bicep_unit_7 \
    --query properties.outputs
```

---

# 🔐 Configure RBAC Permissions

Assign the following Azure AI Search roles:

* Search Service Contributor
* Search Index Data Contributor
* Search Index Data Reader

Assign Azure OpenAI permission:

* Cognitive Services OpenAI User

After assigning permissions:

```bash
az logout
az login
```

Wait approximately **2–5 minutes** for RBAC propagation before running the Python script.

---

# 🤖 Deploy an Embedding Model

Deploy an embedding model through Azure AI Foundry.

During this build, the deployment name was:

```text
anish0703build7-embedding-deploy
```

**Important**

The Azure OpenAI SDK requires the **deployment name**, **not** the base model name.

For example:

❌ Incorrect

```text
text-embedding-3-small
```

✅ Correct

```text
anish0703build7-embedding-deploy
```

---

# 💳 Azure Subscription Requirement

This build uses the **text-embedding-3-small** embedding model.

To use this model:

* A **Pay-As-You-Go Azure subscription** is recommended.
* The **Free Trial subscription may not provide sufficient quota**.
* You may need to request quota approval before the embedding deployment becomes available.

Without sufficient quota, embedding requests will fail even if the deployment exists.

---

# ⚙ VS Code Configuration

Place the following file inside:

```text
.vscode/launch.json
```

Use the macOS Python interpreter:

```text
${workspaceFolder}/tutorials/bin/python
```

Environment variables should include:

* AZURE_OPENAI_ENDPOINT
* AI_SEARCH_SERVICE_ENDPOINT
* EMBEDDING_MODEL_DEPLOYMENT_NAME

Example:

```json
{
    "env": {
        "AZURE_OPENAI_ENDPOINT": "https://anish0703build7.services.ai.azure.com/openai/v1",
        "AI_SEARCH_SERVICE_ENDPOINT": "https://anish0703build7-aisearch.search.windows.net",
        "EMBEDDING_MODEL_DEPLOYMENT_NAME": "anish0703build7-embedding-deploy"
    }
}
```

---

# ▶ Running the Project

Run the application from VS Code or the terminal:

```bash
python ai_103_python_unit_7.py
```

Expected workflow:

1. Connect to Azure AI Search
2. Connect to Azure OpenAI
3. Create the vector search index
4. Generate embeddings
5. Upload vectorized documents
6. Execute semantic search
7. Display the most relevant search results



# ✅ Build Outcome

By completing this build, you will understand:

* Azure OpenAI embeddings
* Vector search
* Semantic retrieval
* Azure AI Search vector indexes
* Enterprise Retrieval-Augmented Generation (RAG)
* Azure RBAC for AI services
* Deployment names vs. model names
* Azure quota requirements for embedding models

This build serves as the foundation for building intelligent enterprise AI applications that retrieve relevant information based on semantic meaning rather than exact keyword matches.
