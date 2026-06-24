# ⚙️ Setup Guide - AI-103 Build 06

## 🖥️ Environment Setup

### Step 1: Navigate to Build 6

```bash
cd "builds/06-AZ-Search(1)-Basic Search and retrival"
```

---

### Step 2: Create Virtual Environment

```bash
python3 -m venv tutorials
```

---

### Step 3: Activate Virtual Environment

```bash
source tutorials/bin/activate
```

Verify:

```bash
which python
```

Expected:

```text
.../tutorials/bin/python
```

---

### Step 4: Install Dependencies

```bash
pip install -r requirements.txt
```

---

### Step 5: Login to Azure

```bash
az login
```

---

### Step 6: Create Resource Group

```bash
az group create --name aiagent-course-rg --location eastus2
```

---

### Step 7: Deploy Bicep File

```bash
az deployment group create \
--resource-group aiagent-course-rg \
--template-file ai_103_bicep_unit_6.bicep \
--parameters coursePrefix=anish0703build6
```

---

### Step 8: Assign RBAC Roles

Assign:

* Search Service Contributor
* Search Index Data Contributor
* Search Index Data Reader

---

### Step 9: Configure launch.json

Configure:

```json
AI_SEARCH_SERVICE_ENDPOINT
```

---

### Step 10: Execute Python Script

```bash
python ai_103_python_unit_6.py
```
