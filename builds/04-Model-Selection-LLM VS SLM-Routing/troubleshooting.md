# 🐞 Build 04 Troubleshooting Guide

# ❌ Error 1 - Virtual Environment Not Found

## Error

```text
source: no such file or directory: tutorials/bin/activate
```

## Cause

The virtual environment had not been created yet.

## Solution

```bash
python3 -m venv tutorials

source tutorials/bin/activate
```

## Prevention

Always create the virtual environment first.

## AI-103 Relevance

Environment setup is required before AI development.

---

# ❌ Error 2 - Python Not Found

## Error

```text
python not found
```

## Cause

macOS defaults to:

```text
python3
```

and no virtual environment was active.

## Solution

Create and activate the environment.

## Prevention

Always verify:

```bash
which python

python --version
```

## AI-103 Relevance

Environment verification is a critical debugging skill.

---

# ❌ Error 3 - 429 RateLimitReached

## Error

```text
openai.RateLimitError: 429
```

## Cause

Too many requests were sent to Phi-4.

Possible reasons:

* Multiple model calls
* Debugger evaluation
* Repeated testing

## Solution

Wait:

```text
2-5 minutes
```

Avoid manually running:

```python
client.chat.completions.create(...)
```

inside debugger.

## Prevention

Use retry mechanisms.

Use exponential backoff.

## AI-103 Relevance

Production AI systems must handle:

* Rate limits
* Quotas
* Latency

---

# ❌ Error 4 - Simple Messages Classified As Complex

## Error

```text
Hi are you the AI agent for this company?

↓

Complex
```

## Cause

The classifier prompt was too ambiguous.

## Solution

Improve system instructions.

Combine:

* Rules
* Keywords
* AI classification

## Prevention

Never rely on a single AI classifier.

## AI-103 Relevance

AI systems are probabilistic.

---

# ❌ Error 5 - Deployment Success But Permission Failure

## Error

Application deployment works but Python execution fails.

## Cause

Deployment ≠ Authorization.

## Solution

Verify RBAC.

Assign:

```text
Cognitive Services User
```

Wait:

```text
2-5 minutes
```

## Prevention

Always verify permissions.

## AI-103 Relevance

Microsoft heavily tests Authentication vs Authorization.

---

# 🏆 Golden Engineering Lessons

Remember:

```text
Deployment ≠ Permission

Authentication ≠ Authorization

Simple ≠ Short

Complex ≠ Long

AI ≠ Deterministic

AI = Probabilistic

Use AI only for ambiguity

Use Python for certainty
```
