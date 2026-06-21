# 🍎 Build 02 Setup Guide

## 🎯 Goal

Set up the environment required to implement Azure AI Content Safety input and output filtering.

---

## 1. Activate the Virtual Environment

```bash
source tutorials/bin/activate
```

Expected:

```text
(tutorials)
```

---

## 2. Verify Python Installation

```bash
which python

python --version
```

Expected:

```text
.../tutorials/bin/python

Python 3.11.x
```

---

## 3. Install Dependencies

```bash
pip install -r requirements.txt
```

Purpose:

Install all required Python packages.

---

## 4. Login to Azure

```bash
az login
```

Purpose:

Authenticate with Azure.

---

## 5. Create Resource Group

```bash
az group create \
--name aiagent-course-rg \
--location eastus2
```

Purpose:

Create a container to hold all Build 02 resources.

---

## 6. Deploy Infrastructure

```bash
az deployment group create \
--resource-group aiagent-course-rg \
--name ai_103_bicep_unit_2 \
--template-file ai_103_bicep_unit_2.bicep \
--parameters coursePrefix=anish0703unit2
```

Purpose:

Deploy:

- Azure AI Foundry
- AI Project
- GPT-4.1-mini deployment
- Azure AI Content Safety

---

## 7. Retrieve Deployment Outputs

```bash
az deployment group show \
--resource-group aiagent-course-rg \
--name ai_103_bicep_unit_2 \
--query properties.outputs
```

Collect:

- OpenAI Endpoint
- Deployment Name
- Content Safety Endpoint

---

## 8. Configure launch.json

Add:

```json
{
 "AZURE_OPENAI_ENDPOINT":"",
 "AZURE_OPENAI_DEPLOYMENT_NAME":"",
 "CONTENT_SAFETY_ENDPOINT":"",
 "AZURE_OPENAI_API_KEY":""
}
```

---

## 9. Run the Application

Use:

```text
Python Debugger: AI-103 Walkthrough
```

Do NOT use:

```text
Python Debugger: Current File
```

because environment variables from `launch.json` will not load.

---

## 🧠 Mental Model

```text
Mac
↓
Python
↓
Virtual Environment
↓
VS Code
↓
launch.json
↓
Python Code
↓
Azure AI Content Safety
↓
Azure OpenAI
↓
User
```

---

## 📝 One-Line Summary

I am building a Responsible AI application that filters unsafe content before and after interactions with an AI model.