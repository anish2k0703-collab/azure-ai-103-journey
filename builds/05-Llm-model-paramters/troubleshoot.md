# 🛠️ Build 05 Troubleshooting Guide

## ❌ Error 1: InsufficientQuota

### Cause

Azure subscription had no available quota for:

```text
gpt-4o-mini
```

### Solution

Use:

```text
Phi-4-mini-instruct
```

instead.

### AI-103 Relevance

Model selection depends on:

* Quota
* Region
* Cost
* Availability

---

## ❌ Error 2: Wrong Python Path

### Cause

Windows path used on macOS.

Wrong:

```text
tutorials/Scripts/python.exe
```

Correct:

```text
tutorials/bin/python
```

### AI-103 Relevance

Always configure launch.json correctly.

---

## ❌ Error 3: top_p = 0.0

### Cause

Invalid model parameter.

### Error

```text
top_p must be in (0,1]
```

### Solution

Set:

```yaml
top_p: 1.0
```

---

## ❌ Error 4: FileNotFoundError

### Cause

launch.json pointed to the wrong Python filename.

### Solution

Update:

```json
"program"
```

to match the actual file.

---

## ❌ Error 5: Phi Classifier Returned "I'm sorry"

### Cause

LLMs are probabilistic systems.

### Solution

Do not trust model outputs directly.

Validate outputs before business logic.

### AI-103 Relevance

AI systems require validation layers.

---

## ❌ Error 6: 403 Forbidden

### Cause

RBAC permissions were not fully propagated.

### Solution

Wait:

```text
2-5 minutes
```

after assigning roles.

---

## 🎓 Key Lesson

Never trust models blindly.

Use:

```text
Input

↓

Model

↓

Validation Layer

↓

Business Logic
```
