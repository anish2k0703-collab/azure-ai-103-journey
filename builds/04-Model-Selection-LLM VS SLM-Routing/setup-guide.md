# ⚙️ Build 04 Setup Guide

# 🖥️ Step 1 - Verify Python

```bash
which python

python --version
```

If Python is not found:

```bash
python3 --version
```

---

# 🐍 Step 2 - Create Virtual Environment

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

which pip
```

---

# 📦 Step 3 - Install Dependencies

Upgrade pip:

```bash
python -m pip install --upgrade pip
```

Install packages:

```bash
pip install openai azure-identity python-dotenv tiktoken
```

Verify:

```bash
pip show openai

pip show azure-identity

pip show python-dotenv

pip show tiktoken
```

---

# ☁️ Step 4 - Azure Login

```bash
az login

az account show --output table
```

---

# 🏗️ Step 5 - Modify Bicep File

Added:

* AI Foundry
* AI Project
* GPT-4.1-Mini deployment
* Phi-4 deployment
* Content Safety
* Automatic RBAC support

Standardized:

```text
eastus2

anish0703build4
```

---

# 🚀 Step 6 - Deploy Infrastructure

Create Resource Group:

```bash
az group create --name aiagent-course-rg --location eastus2
```

Get Principal ID:

```bash
PRINCIPAL_ID=$(az ad signed-in-user show --query id -o tsv)
```

Deploy:

```bash
az deployment group create \
--resource-group aiagent-course-rg \
--name ai_103_build_04 \
--template-file build_04.bicep \
--parameters coursePrefix=anish0703build4 principalId=$PRINCIPAL_ID
```

Retrieve outputs:

```bash
az deployment group show \
--resource-group aiagent-course-rg \
--name ai_103_build_04 \
--query properties.outputs
```

---

# 🔐 Step 7 - Verify RBAC

```bash
az role assignment list \
--assignee $PRINCIPAL_ID \
--all \
--output table
```

Wait:

```text
2-5 minutes
```

---

# ⚙️ Step 8 - Configure launch.json

Create:

```text
.vscode/launch.json
```

Mac Python path:

```json
"${workspaceFolder}/tutorials/bin/python"
```

Never use:

```text
tutorials/Scripts/python.exe
```

---

# ▶️ Step 9 - Run Debugger

Open:

```text
Run and Debug

↓

Python Debugger: AI-103 Walkthrough
```

Run application.

---

# 🧠 Engineering Lessons Learned

Always:

```text
Use eastus2

Use unique names

Verify Python

Verify packages

Verify RBAC

Wait 2-5 minutes

Deployment ≠ Permission
```
