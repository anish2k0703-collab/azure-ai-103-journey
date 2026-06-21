# 🛡️ Build 02: Implementing Input & Output Filtering with Azure AI Content Safety

## 🎯 Objective

The objective of this build was to implement Responsible AI principles by integrating Azure AI Content Safety into an AI application.

This build extends Build 01 by introducing safety mechanisms before and after interactions with a Large Language Model (LLM).

The application now protects:

* The AI system from harmful user inputs
* End users from unsafe AI-generated outputs

This build also introduced real-world cloud debugging concepts such as authentication, authorization, RBAC permissions, and Azure service integrations.

---

## 🛠️ Technologies Used

* Azure AI Foundry
* Azure OpenAI
* Azure AI Content Safety
* Python
* Azure CLI
* Azure Identity
* OpenAI SDK
* Bicep (Infrastructure as Code)
* VS Code
* Git & GitHub

---

## 🏗️ Workflow

1. Created Azure AI Foundry resources using Bicep.
2. Deployed a GPT-4.1-mini model.
3. Deployed a separate Azure AI Content Safety resource.
4. Configured VS Code debugging using `launch.json`.
5. Implemented input filtering.
6. Experimented with severity thresholds.
7. Implemented output filtering.
8. Added safe fallback responses.
9. Troubleshooted Azure authentication and authorization issues.
10. Documented and published the build to GitHub.

---

## 🧠 Architecture

```text
User Input
    ↓
Azure AI Content Safety (Input Filter)
    ↓
Azure OpenAI Model (GPT-4.1-mini)
    ↓
Azure AI Content Safety (Output Filter)
    ↓
User
```

---

## 📚 Key Concepts Learned

### Azure AI Content Safety

A cloud service that analyzes text for harmful content.

The four categories are:

* Hate
* Sexual
* Violence
* Self-Harm

---

### Input Filtering

User prompts are scanned before they reach the LLM.

Purpose:

* Prevent harmful prompts
* Reduce abuse
* Protect the AI system

---

### Output Filtering

AI responses are scanned before they are shown to users.

Purpose:

* Prevent unsafe responses
* Protect end users

---

### Severity Thresholds

Azure AI Content Safety assigns severity levels from:

```text
0 → Safe
6 → Extremely Harmful
```

This build experimented with multiple threshold values to understand how filtering behavior changes.

---

### Safe Default Responses

If unsafe content is detected, a fallback response is returned instead of exposing harmful content.

Example:

```text
I cannot generate a response to this request.
```

---

## 🧪 Experiments Performed

### Experiment 1: Severity Threshold = 1

```python
SEVERITY_THRESHOLD = 1
```

Input:

```text
I hate you
```

Result:

```text
Blocked by Content Safety
```

The message never reached the LLM because the harmful content exceeded the threshold.

This demonstrated how input filtering protects the AI system.

---

### Experiment 2: Severity Threshold = 3

```python
SEVERITY_THRESHOLD = 3
```

Input:

```text
I hate you
```

Result:

```text
Allowed through
```

The message was allowed to reach the LLM because its severity score no longer exceeded the threshold.

This allowed me to observe how the AI model responds to potentially harmful inputs.

---

### Experiment 3: Output Filtering

After generating the AI response, I enabled output filtering.

The assistant response was scanned before being shown to the user.

This demonstrated how AI systems can protect users from unsafe AI-generated content.

---

## 🔐 Authentication Journey

Two authentication approaches were explored.

### Identity-Based Authentication

Used:

```python
DefaultAzureCredential()
```

Worked successfully for:

* Azure AI Content Safety

---

### API Key Authentication

Used successfully for:

* Azure OpenAI model invocation

This demonstrated the difference between authentication and authorization.

---

## 🧠 Authentication vs Authorization

One of the biggest learnings from this build was understanding the difference between authentication and authorization.

Authentication answers:

```text
Who are you?
```

Authorization answers:

```text
What are you allowed to do?
```

Important lesson:

```text
az login
```

does NOT guarantee access to every Azure AI service.

Azure performs authorization checks independently for every service and operation.

For example:

```text
Content Safety → Allowed ✅

OpenAI Chat Completions → Denied ❌
```

Even though both services used Azure AI resources.

---

## 🎯 Outcome

Successfully implemented Responsible AI mechanisms by introducing:

* Input Filtering
* Output Filtering
* Severity Thresholds
* Safe Default Responses

I also experimented with multiple threshold values to understand how Azure AI Content Safety behaves under different configurations.

Additionally, I gained hands-on experience debugging Azure authentication and authorization issues.

---

## 🚀 Skills Demonstrated

* Azure AI Foundry
* Azure OpenAI
* Azure AI Content Safety
* Responsible AI
* Input Filtering
* Output Filtering
* Safety Engineering
* Bicep
* Azure CLI
* Python SDK Integration
* Authentication
* Authorization
* RBAC
* Cloud Troubleshooting
* GitHub Documentation
