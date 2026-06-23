# 🤖 AI-103 Build 05 - Model Parameters & Intelligent Model Routing

## 🎯 Objective

The goal of this build was to understand how AI applications can intelligently select and configure different models based on the complexity of a user's request.

In this build, I implemented a multi-model AI system that uses both a Large Language Model (LLM) and a Small Language Model (SLM) while incorporating Azure AI Content Safety, dynamic system instructions, token tracking, latency measurements, and cost estimation.

---

## 🏢 Business Problem

Not every user request requires a powerful and expensive model.

Organizations need AI systems that can:

* Reduce costs
* Improve response times
* Route tasks intelligently
* Scale efficiently
* Apply safety guardrails

Instead of sending every request to a powerful LLM, we can route simple requests to a smaller model and reserve the larger model for complex reasoning tasks.

---

## 🛠️ Technologies Used

* Azure AI Foundry
* Azure AI Content Safety
* Azure AI Models
* Azure Bicep
* Azure CLI
* Python
* OpenAI SDK
* Azure Identity SDK
* VS Code
* YAML Configuration

---

## 🧠 Concepts Learned

### Model Selection

Choosing the right model for a specific task.

### Model Routing

Directing user requests to different models based on complexity.

### LLM vs SLM

LLM:

* More intelligent
* Better reasoning
* More expensive
* Higher latency

SLM:

* Faster
* Cheaper
* Lower latency
* Suitable for simple tasks

### Model Parameters

* max_tokens
* temperature
* top_p
* max_past_messages

### Content Safety

Applying input and output filtering.

### Authentication vs Authorization

Authentication:
Who are you?

Authorization:
What are you allowed to access?

---

## 🏗️ Build Workflow

User Input

↓

Azure AI Content Safety (Input Filtering)

↓

Intent Classification

↓

Model Routing

↓

LLM or SLM

↓

Azure AI Content Safety (Output Filtering)

↓

Performance Metrics

---

## 📊 Experiments Performed

* Tested LLM vs SLM routing
* Tested model parameters
* Tested Content Safety filtering
* Tested latency measurements
* Tested token usage tracking
* Tested cost estimation

---

## 🏆 Skills Demonstrated

* Azure AI Foundry deployment
* AI model routing
* Python AI application development
* Azure Content Safety integration
* Bicep Infrastructure as Code
* Azure RBAC permissions
* AI debugging and troubleshooting
* AI system architecture design

---

## 🎓 AI-103 Exam Takeaways

* LLM vs SLM tradeoffs
* Model routing
* Model parameters
* Token consumption
* Cost optimization
* Authentication vs Authorization
* Azure RBAC
* Content Safety integration
* AI system design patterns
