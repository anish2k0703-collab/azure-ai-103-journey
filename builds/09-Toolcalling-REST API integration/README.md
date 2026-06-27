# 🤖 AI-103 Build 09 – Tool Calling & REST API Integration

## 🎯 Project Overview

In this build, I implemented **Tool Calling** using Azure AI Foundry Agents and external REST APIs.

The goal was to understand how AI agents can interact with external systems and retrieve real-time information instead of relying only on model knowledge.

This project demonstrates how enterprise AI systems combine:

* 🧠 LLM Reasoning
* 🔧 Tool Calling
* 🌐 REST APIs
* ☁️ Azure AI Foundry

to create intelligent and dynamic AI solutions.

---

# 🚀 Business Problem

Large Language Models are trained on historical data and cannot reliably answer questions requiring real-time information.

Examples include:

* 🌤 Current weather
* 💱 Live exchange rates
* 📦 Order tracking
* 🏦 Banking balances
* 🚚 Inventory availability

Modern AI systems solve this by connecting agents to external tools and APIs.

---

# 🏗️ Solution Architecture

```text
User
  ↓
Azure AI Foundry Agent
  ↓
Reasoning Engine
  ↓
Tool Selection
  ↓
REST API Call
  ↓
Tool Response
  ↓
Final AI Response
```

The model first determines whether a tool is required before generating a response.

---

# ☁️ Azure Services Used

| Service                 | Purpose                      |
| ----------------------- | ---------------------------- |
| Azure AI Foundry        | Agent hosting and management |
| Azure AI Project        | Development environment      |
| GPT-4.1 Mini            | Primary reasoning model      |
| GPT-4.1 Nano            | Lightweight helper model     |
| Azure AI Content Safety | Content moderation           |
| Azure RBAC              | Security and permissions     |
| Azure CLI               | Deployment automation        |
| Bicep                   | Infrastructure as Code       |

---

# 🌐 External APIs Used

## 🌤 OpenWeatherMap API

Purpose:

Retrieve real-time weather information.

Example:

```text
What is the weather in Chicago?
```

---

## 💱 Currency Exchange API

Purpose:

Retrieve live exchange rates.

Example:

```text
Convert 100 USD to INR
```

---

# 🧪 Tool Calling Experiments

The most important learning outcome of this build was understanding **when an agent should call a tool**.

---

## 🧪 Scenario 1 – Multiple Tool Calls

### User Prompt

```text
What is the weather in Chicago and convert 100 USD to INR?
```

### Agent Behavior

✅ Weather API called

✅ Currency API called

### Result

The agent recognized that both requests required real-time information and invoked both tools before generating a response.

---

## 🧪 Scenario 2 – Single Tool Call

### User Prompt

```text
What is the weather in Chicago?
```

### Agent Behavior

✅ Weather API called

❌ Currency API not called

### Result

The agent selected only the tool required to answer the question.

This demonstrated selective tool invocation.

---

## 🧪 Scenario 3 – No Tool Call

### User Prompt

```text
What is your refund policy?
```

### Agent Behavior

❌ No external tools called

### Result

The agent answered directly using the refund policy instructions already available in its context.

This proved that tools should only be used when additional information is required.

---

# 🧠 What I Learned

A common misconception is that agents always call tools.

In reality the agent follows a reasoning process:

1️⃣ Understand the user's intent

2️⃣ Determine whether external information is needed

3️⃣ Select the correct tool

4️⃣ Execute the tool

5️⃣ Generate the final response

This approach:

* 💰 Reduces cost
* ⚡ Improves performance
* 🎯 Improves accuracy
* 🔒 Limits unnecessary API calls

---

# 🎓 AI-103 Exam Relevance

Key concepts covered:

* Tool Calling
* Function Calling
* REST API Integration
* Azure AI Foundry Agents
* Agent Instructions
* Tool Selection
* External Knowledge Retrieval

### Possible Exam Question

❓ When should an agent invoke a tool?

✅ Answer:

Only when additional external information is required to answer the user's request.

---

# 🏢 Enterprise Applications

Tool Calling is used extensively in enterprise AI systems:

* 🎧 Customer Support Agents
* ✈️ Travel Assistants
* 💰 Financial Advisors
* 🏦 Banking Agents
* 📦 Order Tracking Systems
* 🚚 Supply Chain Systems
* 🛒 E-commerce Assistants

---

# 📸 Screenshots

Capture the following screenshots:

* 📷 Bicep Deployment Success
* 📷 Azure AI Foundry Resource
* 📷 Azure AI Project
* 📷 GPT-4.1 Mini Deployment
* 📷 GPT-4.1 Nano Deployment
* 📷 Weather API Tool Call
* 📷 Currency API Tool Call
* 📷 Multiple Tool Call Example
* 📷 Refund Policy Example
* 📷 Successful Terminal Execution

---

# 💡 Memory Trick

### LLM = Brain

The LLM performs reasoning.

### Tool = Hand

The tool performs actions.

### API = Telephone

The API connects the agent to external systems.

Think:

🧠 Brain → 🤔 Decide

🔧 Tool → ⚙️ Act

🌐 API → 📞 Communicate

---

# ✅ Key Takeaways

* Azure AI Foundry Agents can call external tools.
* REST APIs provide real-time information.
* Agents decide when tools should be called.
* Multiple tools can be used in a single conversation.
* Proper instructions reduce unnecessary tool usage.
* Tool Calling is a foundational enterprise AI pattern.
* Understanding Tool Calling is important for both AI-103 and real-world AI architecture.
