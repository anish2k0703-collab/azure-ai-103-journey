# ⚙️ Setup Guide

## Prerequisites

* Azure Subscription
* Azure CLI
* Python 3.11+
* Visual Studio Code
* Git

---

# Python Environment

Create virtual environment

```bash
python3.11 -m venv tutorials
```

Activate

```bash
source tutorials/bin/activate
```

Install dependencies

```bash
pip install -r requirements.txt
```

---

# Azure Login

```bash
az login
```

Verify subscription

```bash
az account show
```

---

# Resource Group

```bash
az group create \
  --name aiagent-course-rg \
  --location eastus
```

---

# Deploy Infrastructure

```bash
USER_OBJECT_ID=$(az ad signed-in-user show --query id -o tsv)

az deployment group create \
  --resource-group aiagent-course-rg \
  --name ai_103_bicep_build_8 \
  --template-file ai_103_bicep_build_8.bicep \
  --parameters \
      coursePrefix=anish0703build8 \
      userObjectId=$USER_OBJECT_ID
```

---

# Verify Deployments

```bash
az cognitiveservices account deployment list \
  --resource-group aiagent-course-rg \
  --name anish0703build8 \
  --output table
```

---

# Verify Search Service

```bash
az search service show \
  --name anish0703build8-aisearch \
  --resource-group aiagent-course-rg
```

---

# Configure launch.json

Update:

* Azure OpenAI Endpoint
* Deployment Names
* Search Endpoint
* Content Safety Endpoint

---

# Required RBAC Roles

Automatically assigned by the Bicep template:

* Cognitive Services User
* Search Service Contributor
* Search Index Data Contributor
* Search Index Data Reader

---

# Run the Project

```bash
python ai_103_python_build_8.py
```

or launch using VS Code Debugger.
