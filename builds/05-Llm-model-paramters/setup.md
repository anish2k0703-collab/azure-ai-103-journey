# ⚙️ Build 05 Setup Guide

## 📁 Step 1: Open Build 05 Folder

```bash
pwd
```

Verify you are inside:

```text
builds/05-Llm-model-paramters
```

---

## 🐍 Step 2: Create Virtual Environment

```bash
python3 -m venv tutorials
```

Activate:

```bash
source tutorials/bin/activate
```

---

## ✅ Step 3: Verify Python Environment

```bash
which python

python --version

which pip

pip --version
```

---

## 📦 Step 4: Install Dependencies

```bash
python -m pip install --upgrade pip

pip install openai azure-identity azure-ai-contentsafety python-dotenv PyYAML tiktoken
```

Freeze requirements:

```bash
pip freeze > requirements.txt
```

Verify:

```bash
pip show openai

pip show azure-identity

pip show azure-ai-contentsafety

pip show PyYAML

pip show tiktoken
```

---

## ☁️ Step 5: Azure Login

```bash
az login

az account show --output table
```

---

## 🏗️ Step 6: Deploy Bicep

```bash
PRINCIPAL_ID=$(az ad signed-in-user show --query id -o tsv)

az deployment group create \
--resource-group aiagent-course-rg \
--name ai_103_build_05 \
--template-file build_05.bicep \
--parameters coursePrefix=anish0703build5 principalId=$PRINCIPAL_ID
```

---

## 🧠 Step 7: Configure launch.json

Use:

```text
tutorials/bin/python
```

Never use:

```text
tutorials/Scripts/python.exe
```

---

## 🔐 Step 8: Verify RBAC

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

for RBAC propagation.

---

## ▶️ Step 9: Run Python Debugger

```bash
python ai_103_build_05.py
```

or press:

```text
F5
```

inside VS Code.

---

## 🗑️ Step 10: Cleanup Resources

```bash
az group delete \
--name aiagent-course-rg \
--yes \
--no-wait
```
