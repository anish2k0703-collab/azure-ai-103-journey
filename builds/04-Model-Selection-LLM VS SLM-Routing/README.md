# 🤖 AI-103 Build 04 - Model Selection: LLM vs SLM Routing

## 🎯 Objective

Build an intelligent AI routing system that automatically decides whether a user request should be handled by a Small Language Model (SLM) or a Large Language Model (LLM).

This build demonstrates how enterprise AI systems optimize for:

* ⚡ Speed
* 💰 Cost
* 🧠 Reasoning capability
* 📈 Scalability

Instead of sending every request to a powerful and expensive model, we first classify the user's intent and then route the request to the most appropriate model.

---

# 🏢 Business Problem

In real-world AI systems, not every question requires a large and expensive model.

Examples:

Simple requests:

* "Hi, are you the AI agent for this company?"
* "What is my refund status?"

Complex requests:

* "Analyze why my refund has been delayed."
* "Recommend the best next steps."

Sending every request to GPT-4 increases:

* Cost
* Latency
* Resource consumption

The goal is to intelligently route requests to the appropriate model.

---

# 🏗️ Solution Architecture

```text
User Message

↓

Intent Classification

↓

Simple ? ---------------------> Phi-4 (SLM)

↓

Complex ? --------------------> GPT-4.1-Mini (LLM)

↓

Generate Response

↓

Display Metrics
```

---

# 🧠 Key Concepts Learned

## 🔹 LLM (Large Language Model)

Large models that are powerful at:

* Analysis
* Planning
* Recommendations
* Multi-step reasoning

Example:

GPT-4.1-Mini

---

## 🔹 SLM (Small Language Model)

Smaller models optimized for:

* Lower cost
* Faster responses
* Simpler tasks

Example:

Phi-4-Mini

---

## 🔹 Model Routing

Selecting the appropriate model based on the complexity of the user's request.

Goal:

```text
Simple → SLM

Complex → LLM
```

---

## 🔹 Intent Classification

A system that determines whether a user request is:

```text
simple

or

complex
```

before selecting the model.

---

## 🔹 Authentication vs Authorization

Authentication:

```text
Who are you?
```

Authorization:

```text
What are you allowed to do?
```

---

## 🔹 RBAC

Role Based Access Control.

Deployment success does NOT mean application execution success.

---

# 🛠️ Technologies Used

* Azure AI Foundry
* Azure OpenAI
* Azure AI Content Safety
* Azure RBAC
* Azure CLI
* Bicep
* Python
* VS Code
* DefaultAzureCredential
* Phi-4
* GPT-4.1-Mini

---

# ⚙️ How LLM Routing Was Achieved

The routing process was achieved using three functions.

## 1️⃣ classify_intent()

Keyword-based classification.

Responsibilities:

* Detect greetings
* Detect simple questions
* Detect analysis keywords

Example:

```python
compare
analyze
recommend
plan
```

↓

Complex

---

## 2️⃣ classify_intent_via_slm()

Uses Phi-4 to classify user intent.

Responsibilities:

* Send user prompt to Phi
* Return:

```text
simple

or

complex
```

---

## 3️⃣ route_to_model()

The main orchestrator.

Responsibilities:

* Receive user input
* Call classifier
* Select model
* Send request
* Measure latency
* Track token usage

This function is the heart of Build 04.

---

# 🧪 Experiments Performed

## Experiment 1

User Prompt:

```text
What is the status of my refund request?
```

Expected:

```text
Simple
```

Result:

```text
Phi-4
```

---

## Experiment 2

User Prompt:

```text
My refund has been pending for three weeks. Analyze possible reasons and recommend next steps.
```

Expected:

```text
Complex
```

Result:

```text
GPT-4.1-Mini
```

---

## Experiment 3

User Prompt:

```text
Hi, are you the AI agent for this company?
```

Expected:

```text
Simple
```

Result:

```text
Complex
```

Observation:

The SLM classifier was overly conservative.

This exposed a limitation of AI-based routing.

---

## Experiment 4

User Prompt:

```text
Hi, are you the AI agent for this company and can you help me?
```

Expected:

```text
Simple
```

Result:

```text
Complex
```

Observation:

AI routing is probabilistic, not deterministic.

---

# 🔐 Authentication Journey

```text
az login

↓

DefaultAzureCredential()

↓

Azure Identity

↓

Bearer Token

↓

Azure Services
```

---

# 🎓 AI-103 Exam Takeaways

Remember:

```text
Authentication ≠ Authorization

Deployment ≠ Permission

Simple ≠ Short

Complex ≠ Long

AI ≠ Deterministic

AI = Probabilistic
```

---

# 🚀 Outcome

Successfully built an enterprise AI routing system that:

* Dynamically routes requests
* Uses LLM and SLM together
* Measures latency
* Optimizes cost
* Demonstrates production AI concepts

---

# 🏆 Skills Demonstrated

* Azure AI Engineering
* Azure OpenAI
* AI Foundry
* Bicep
* Python
* Model Routing
* Prompt Engineering
* Azure Identity
* RBAC
* AI Orchestration
* Debugging
* Cloud Troubleshooting
