# 🛠️ Troubleshooting Guide - AI-103 Build 06

## ❌ Problem 1: East US 2 Capacity Error

### Error

```text
InsufficientResourcesAvailable
```

### Cause

Azure East US 2 temporarily ran out of capacity for Azure AI Search resources.

### Solution

Deploy to another supported region.

Example:

```text
eastus
```

This was an Azure infrastructure limitation, not a code issue.

---

## ❌ Problem 2: Search Service Name Already Exists

### Error

```text
A service with the name 'unit6course-aisearch' already exists.
```

### Cause

Azure AI Search service names are globally unique.

### Solution

Use a unique prefix.

Example:

```text
anish0703build6
```

---

## ❌ Problem 3: principalId Warning

### Error

```text
Parameter "principalId" is declared but never used.
```

### Cause

The Bicep file declared principalId but never referenced it.

### Solution

Remove:

```bicep
param principalId string
```

---

## ❌ Problem 4: ModuleNotFoundError

### Error

```text
ModuleNotFoundError: No module named 'azure'
```

### Cause

VS Code used the global Homebrew Python instead of the virtual environment.

### Solution

Activate:

```bash
source tutorials/bin/activate
```

Verify:

```bash
which python
```

Expected:

```text
tutorials/bin/python
```

---

## ❌ Problem 5: Debugger Uses Wrong Directory

### Cause

VS Code workspace was opened at:

```text
A1-103 code walk throughs
```

instead of the Build 6 folder.

### Solution

Open Build 6 directly:

```bash
cd "builds/06-AZ-Search(1)-Basic Search and retrival"

code .
```

or configure:

```json
cwd
```

inside launch.json.

---

## ❌ Problem 6: Duplicate File Paths

### Cause

launch.json was configured using Build 6 paths while Build 6 was already the workspace.

### Solution

Use:

```json
"${workspaceFolder}/ai_103_python_unit_6.py"
```

instead of repeating:

```text
builds/06-AZ-Search...
```

---

## 💡 Lessons Learned

* Azure AI Search names are globally unique.
* Azure regions may temporarily run out of capacity.
* RBAC propagation may take 2–5 minutes.
* VS Code debugger depends on the selected workspace.
* Always verify Python interpreters before debugging.
* Infrastructure issues are different from coding issues.
