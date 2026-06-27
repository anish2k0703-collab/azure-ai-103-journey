# 🚨 Build 09 Troubleshooting Guide

This document captures the major issues encountered during Build 09 and how they were resolved.

---

# ❌ Error 1

## Bicep File Not Found

### Error

```text
Could not find file
ai_103_bicep_build_9.bicep
```

### 🔍 Root Cause

Deployment command referenced:

```text
ai_103_bicep_build_9.bicep
```

Actual file name:

```text
ai_103_bicep_unit_9.bicep
```

### ✅ Resolution

Updated deployment command to use the correct file name.

### 🎓 Lesson Learned

Deployment names and filenames do not need to match.

Always verify file names before deployment.

---

# ❌ Error 2

## VS Code Debugger Failed

### Error

```text
Could not spawn debugger

tutorials/Scripts/python.exe
```

### 🔍 Root Cause

launch.json contained a Windows virtual environment path.

### ✅ Resolution

Updated path:

```json
${workspaceFolder}/tutorials/bin/python
```

### 🎓 Lesson Learned

Windows:

```text
Scripts/
```

Mac/Linux:

```text
bin/
```

Always use platform-specific Python paths.

---

# ❌ Error 3

## Deprecated Model Deployment

### Error

```text
The model gpt-4o-mini version 2024-07-18 is in deprecating state
```

### 🔍 Root Cause

Azure blocked creation of new deployments using a deprecated model version.

### ✅ Resolution

Replaced deployment with:

* 🧠 GPT-4.1 Mini
* ⚡ GPT-4.1 Nano

### 🎓 Lesson Learned

Azure OpenAI deployments require supported model versions.

Always review model lifecycle documentation before deployment.

---

# ❌ Error 4

## RBAC Permissions Not Working Immediately

### Error

Agent failed authentication even though deployment succeeded.

### 🔍 Root Cause

Azure RBAC assignments require propagation time.

### ✅ Resolution

Waited several minutes and refreshed Azure authentication.

```bash
az logout
az login
```

### 🎓 Lesson Learned

RBAC changes are not instantaneous.

Allow 2–5 minutes for permissions to propagate.

---

# ❌ Error 5

## Weather API Authentication Failure

### Error

```text
401 Unauthorized
```

### 🔍 Root Cause

Missing or invalid API key.

### ✅ Resolution

Verified:

* API key
* Endpoint URL
* Query parameters

### 🎓 Lesson Learned

API endpoints and API keys are separate configuration items.

Never hardcode secrets in source code.

---

# ❌ Error 6

## Tool Not Invoked

### Error

Agent responded without calling the expected tool.

### 🔍 Root Cause

The user request did not clearly require external information.

### ✅ Resolution

Reviewed:

* Function definitions
* Tool schemas
* Agent instructions

### 🎓 Lesson Learned

Agents perform reasoning before calling tools.

Tools are only invoked when required.

---

# ❌ Error 7

## Multiple Tool Calls Not Triggered

### Error

Only one tool was called when two were expected.

### 🔍 Root Cause

Prompt did not clearly request both data sources.

### ✅ Resolution

Used a combined prompt:

```text
What is the weather in Chicago and convert 100 USD to INR?
```

### 🎓 Lesson Learned

Prompt wording influences tool selection behavior.

---

# 💡 Biggest Lesson From This Build

The most important realization from Build 09 was:

```text
Tools should only be called when necessary.
```

The agent first:

1️⃣ Understands intent

2️⃣ Determines if external information is required

3️⃣ Selects the appropriate tool

4️⃣ Executes the tool

5️⃣ Generates the final response

This reasoning-first approach is the foundation of modern enterprise AI agents.

---

# 🎓 AI-103 Exam Takeaway

Remember:

🧠 Model = Reasoning

🔧 Tool = Action

🌐 API = External Data Source

The agent decides when the tool should be used.

The tool does not decide when it should be called.
