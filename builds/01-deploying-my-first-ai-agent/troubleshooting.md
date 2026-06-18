# 🔧 Troubleshooting Log

This document captures the issues encountered during Build 01 and how they were resolved.

---

## 1. Python Command Not Found

### Error

zsh: command not found: python

### Cause

macOS uses `python3` instead of `python`.

### Solution

Use:

`python3`

instead of:

`python`

---

## 2. Dependency Installation Error

### Error

No matching distribution found for anyio==4.13.0

### Cause

Older Python and pip versions were being used.

### Solution

* Upgraded Python
* Upgraded pip
* Recreated the virtual environment

---

## 3. CustomDomainInUse Error

### Error

CustomDomainInUse

### Cause

The Azure AI Foundry resource name already existed.

### Solution

Created a unique resource name.

---

## 4. InsufficientQuota Error

### Error

InsufficientQuota

### Cause

Automatic GPT-4.1-mini deployment was unavailable in the selected region.

### Solution

Manually deployed the model in Azure AI Foundry.

---

## 5. Authentication Error (401 Invalid Issuer)

### Error

401 Invalid Issuer

### Cause

Environment variables were not being loaded.

### Solution

Configured:

* AZURE_OPENAI_ENDPOINT
* AZURE_OPENAI_DEPLOYMENT_NAME

and executed the script from the correct environment.

---

## 6. launch.json Environment Variable Issue

### Problem

Environment variables inside `launch.json` only work when running the Python debugger inside VS Code.

### Solution

Run the application using the VS Code debugger or manually export environment variables in the terminal.



---

## 🎓 Key Takeaway

Building AI applications is not only about writing Python code. It also involves:

* Environment management
* Cloud resource deployment
* Authentication
* Infrastructure as Code
* Debugging
* Version control
* Documentation
