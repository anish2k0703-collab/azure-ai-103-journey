# Build 03 Troubleshooting Guide

# Error 1

## Error

```text
ModuleNotFoundError: No module named 'openai'
```

## Cause

VS Code debugger was using the wrong Python interpreter.

## Solution

Configure launch.json:

```json
"${workspaceFolder}/tutorials/bin/python"
```

## Prevention

Always verify:

```bash
which python
```

---

# Error 2

## Error

```text
PermissionDenied

ContentSafety/text:analyze/action
```

## Cause

Missing RBAC permissions.

Authentication succeeded.

Authorization failed.

## Solution

Assign:

```text
Cognitive Services User
```

to Azure Content Safety.

## Prevention

Add RBAC verification after every deployment.

---

# Error 3

## Error

```text
PermissionDenied

OpenAI/deployments/chat/completions/action
```

## Cause

Azure OpenAI data-plane permissions were missing.

## Solution

Assign:

```text
Cognitive Services User
```

to Azure OpenAI.

---

# Error 4

## Error

launch.json not detected.

## Cause

launch.json was outside the .vscode folder.

## Solution

Move:

```text
launch.json
```

to:

```text
.vscode/launch.json
```

during development.

For GitHub portfolio, keep it at project root.

---

# Error 5

## Error

Windows Python path used on Mac.

```text
tutorials/Scripts/python.exe
```

## Cause

Microsoft tutorials are often Windows-oriented.

## Solution

Use:

```text
tutorials/bin/python
```

on Mac.

---

# ⭐ Permanent Prevention Checklist

After every build:

```text
Deploy Infrastructure

↓

Get Outputs

↓

Configure launch.json

↓

Verify Python Environment

↓

Assign RBAC Roles

↓

Wait 2-5 minutes

↓

Run Debugger
```

---

# 🧠 Key Takeaway

Successful deployment does NOT mean successful application execution.

Always verify:

1. Environment
2. Dependencies
3. Authentication
4. Authorization
5. Configuration
6. RBAC

before debugging the application.
