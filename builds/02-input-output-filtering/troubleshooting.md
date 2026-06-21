# 🔧 Troubleshooting Log

This document captures issues encountered during Build 02 and how they were resolved.

---

## 1. Virtual Environment Creation Failed

### Error

```text
Refusing to create a venv because path contains :
```

### Cause

The folder name contained `:`.

### Solution

Rename:

```text
02-Input:outputfiltering
```

to:

```text
02-Input-Output-Filtering
```

---

## 2. Python Package Not Found

### Error

```text
ModuleNotFoundError: No module named 'openai'
```

### Cause

VS Code was using the wrong Python interpreter.

### Solution

Verify:

```bash
which python
```

Expected:

```text
.../tutorials/bin/python
```

---

## 3. launch.json Environment Variables Not Loading

### Error

```text
Parameter 'endpoint' must not be None
```

### Cause

The debugger was not using `launch.json`.

### Solution

Run:

```text
Python Debugger: AI-103 Walkthrough
```

instead of:

```text
Python Debugger: Current File
```

---

## 4. Azure AI Content Safety Permission Error

### Error

```text
PermissionDenied

Microsoft.CognitiveServices/accounts/ContentSafety/text:analyze/action
```

### Cause

Missing RBAC permissions.

### Solution

Assign:

```text
Cognitive Services User
```

role to the Content Safety resource.

---

## 5. OpenAI Chat Completion Authorization Error

### Error

```text
401 PermissionDenied

Principal does not have access to API/Operation
```

### Cause

Azure authenticated the identity but denied access to the OpenAI data-plane operation.

### Solution

Used API key authentication.

---

## 6. Authentication vs Authorization Lesson

Authentication:

```text
Who are you?
```

Authorization:

```text
What are you allowed to do?
```

A successful Azure login does NOT guarantee access to every Azure AI service.

---

## 🧠 Debugging Workflow Learned

When Azure AI errors occur:

1. Verify deployment
2. Verify endpoints
3. Verify model deployment
4. Verify environment variables
5. Verify RBAC permissions
6. Verify authentication method
7. Verify authorization method

---

## 🎓 Key Takeaway

Building AI applications is not only about writing Python code.

It also involves:

- Responsible AI
- Authentication
- Authorization
- Cloud deployment
- Infrastructure as Code
- Debugging
- Documentation
- Version control