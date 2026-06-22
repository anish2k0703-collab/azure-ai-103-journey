# Build 03 Setup Guide (Mac)

## 🎯 Goal

Build an AI customer support assistant using dynamic system instructions and Azure AI services.

---

## 1. Activate Virtual Environment

```bash
source tutorials/bin/activate
```

Expected:

```text
(tutorials)
```

---

## 2. Verify Python

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

Verify:

```bash
pip show openai

pip show tiktoken
```

---

## 4. Login to Azure

```bash
az login
```

Verify:

```bash
az account show
```

---

## 5. Create Resource Group

```bash
az group create \
--name aiagent-course-rg \
--location eastus2
```

---

## 6. Deploy Infrastructure

```bash
az deployment group create \
--resource-group aiagent-course-rg \
--name ai_103_bicep_unit_3 \
--template-file build_03.bicep \
--parameters coursePrefix=anish0703unit3
```

---

## 7. Retrieve Outputs

```bash
az deployment group show \
--resource-group aiagent-course-rg \
--name ai_103_bicep_unit_3 \
--query properties.outputs
```

Collect:

* Azure OpenAI Endpoint
* Deployment Name
* Content Safety Endpoint

---

## 8. Configure launch.json

Important:

Mac uses:

```text
tutorials/bin/python
```

NOT

```text
tutorials/Scripts/python.exe
```

---

## 9. Post Deployment RBAC Configuration ⭐

Assign permissions to BOTH resources.

### Azure OpenAI

Assign:

```text
Cognitive Services User
```

### Azure Content Safety

Assign:

```text
Cognitive Services User
```

Wait 2-5 minutes for RBAC propagation.

---

## 10. Run Debugger

Use:

```text
Python Debugger: AI-103 Walkthrough
```

Do NOT use:

```text
Run Python File
```

---

## 🧠 Mental Model

```text
VS Code

 ↓

launch.json

 ↓

Python Environment

 ↓

Azure Identity

 ↓

Azure Content Safety

 ↓

Azure OpenAI

 ↓

User
```

---

## 🚀 Build Improvements Over Previous Builds

Added:

* Proper .vscode structure
* Correct Mac Python path
* RBAC verification process
* Standardized debugging workflow
* Dynamic prompt construction
* Stronger AI boundaries
