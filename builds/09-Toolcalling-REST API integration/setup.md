# 🛠️ Build 09 Setup Guide

## 🎯 Objective

This build demonstrates how Azure AI Foundry Agents can use external tools through REST APIs to retrieve real-time information.

The agent was configured to:

* 🌤️ Call a Weather API
* 💱 Call a Currency Exchange API
* 📋 Answer refund policy questions without calling any external tool

---

# 📦 Prerequisites

Before starting, ensure the following are installed:

✅ Python 3.11+

✅ Visual Studio Code

✅ Azure CLI

✅ Git

✅ Azure Subscription

---

# 🐍 Create Virtual Environment

Create a virtual environment:

```bash
python3 -m venv tutorials
```

Activate:

```bash
source tutorials/bin/activate
```

Verify:

```bash
which python
```

Expected output:

```text
.../tutorials/bin/python
```

---

# 📥 Install Dependencies

Install required packages:

```bash
pip install -r requirements.txt
```

Verify:

```bash
pip list
```

---

# ☁️ Azure Authentication

Login to Azure:

```bash
az login
```

Verify subscription:

```bash
az account show
```

---

# 🏗️ Create Resource Group

```bash
az group create \
  --name aiagent-course-rg \
  --location eastus
```

---

# 🔑 Retrieve User Object ID

Required for automatic RBAC assignment.

```bash
USER_OBJECT_ID=$(az ad signed-in-user show --query id -o tsv)
```

Verify:

```bash
echo $USER_OBJECT_ID
```

---

# 🚀 Deploy Infrastructure

Deploy the Bicep template:

```bash
az deployment group create \
  --resource-group aiagent-course-rg \
  --name ai_103_bicep_build_9 \
  --template-file ai_103_bicep_unit_9.bicep \
  --parameters \
      coursePrefix=anish0703build9 \
      userObjectId=$USER_OBJECT_ID
```

---

# ✅ Verify Deployment

Retrieve deployment outputs:

```bash
az deployment group show \
  --resource-group aiagent-course-rg \
  --name ai_103_bicep_build_9 \
  --query properties.outputs
```

Verify:

* ☁️ Azure AI Foundry
* 📁 Azure AI Project
* 🧠 GPT-4.1 Mini Deployment
* ⚡ GPT-4.1 Nano Deployment
* 🛡️ Content Safety Resource

---

# 🔐 RBAC Propagation

Wait approximately:

```text
2–5 minutes
```

Refresh authentication:

```bash
az logout
az login
```

---

# ⚙️ VS Code Configuration

Create:

```text
.vscode/launch.json
```

Mac Python path:

```json
"python": "${workspaceFolder}/tutorials/bin/python"
```

Do NOT use:

```json
tutorials/Scripts/python.exe
```

This is a Windows path.

---

# 🌐 API Configuration

The following environment variables were configured:

## 🌤️ Weather API

```text
WEATHER_API_ENDPOINT
WEATHER_API_KEY
```

Example endpoint:

```text
https://api.openweathermap.org/data/2.5/weather
```

---

## 💱 Currency Exchange API

```text
EXCHANGE_RATE_API_ENDPOINT
EXCHANGE_RATE_API_KEY
```

---

# ▶️ Run the Application

From terminal:

```bash
python ai_103_python_unit_9.py
```

Or execute through the VS Code debugger.

---

# 📸 Screenshots to Capture

* 📷 Resource Group Creation
* 📷 Successful Bicep Deployment
* 📷 AI Foundry Resource
* 📷 GPT-4.1 Mini Deployment
* 📷 GPT-4.1 Nano Deployment
* 📷 Weather Tool Execution
* 📷 Currency Tool Execution
* 📷 Multiple Tool Call Example
* 📷 Refund Agent Example
* 📷 Successful Terminal Execution

---

# 🎓 AI-103 Concepts Covered

* Tool Calling
* Function Calling
* REST API Integration
* Azure AI Foundry Agents
* Agent Instructions
* External Tool Invocation
* Real-Time Data Retrieval
