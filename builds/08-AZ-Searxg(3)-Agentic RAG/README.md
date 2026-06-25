# 🤖 AI-103 Build 08 – Agentic RAG with Azure AI Search

## 📌 Project Overview

This project demonstrates how to build an **Agentic Retrieval-Augmented Generation (Agentic RAG)** application using Azure AI Foundry, Azure AI Search, Azure OpenAI, and Azure AI Content Safety.

Unlike a traditional chatbot that answers only from its pre-trained knowledge, an Agentic RAG application first retrieves relevant enterprise data from Azure AI Search and then uses that information to generate grounded, accurate, and context-aware responses.

This build focuses on how Azure AI Search integrates with Azure OpenAI embeddings to enable semantic search, vector search, and grounded responses.

---

# 🎯 Business Problem

Organizations store large amounts of internal knowledge such as:

* Customer orders
* Product catalogs
* Employee documentation
* HR policies
* Support articles

A standard LLM cannot reliably answer questions about this proprietary data because it was never trained on it.

Agentic RAG solves this problem by allowing the AI agent to retrieve relevant documents before generating a response.

---

# 🏗️ Solution Architecture

User Question

↓

Generate Embedding

↓

Azure AI Search (Vector Search)

↓

Retrieve Relevant Documents

↓

LLM receives grounded context

↓

Generate Final Response

---

# ☁️ Azure Services Used

* Azure AI Foundry
* Azure AI Foundry Project
* Azure OpenAI
* GPT-4.1 Mini
* GPT-4o Mini
* Text Embedding 3 Small
* Azure AI Search
* Azure AI Content Safety
* Azure Entra ID (RBAC)

---

# 📂 Project Structure

```
08-Agentic-RAG/
│
├── README.md
├── setup.md
├── troubleshoot.md
├── notes.md
├── requirements.txt
├── launch.json
├── screenshots/
├── ai_103_python_build_8.py
├── ai_103_bicep_build_8.bicep
└── ai_103_cli_build_8.sh
```

---

# 🚀 Features

* Deploy Azure AI infrastructure using Bicep
* Automatic RBAC role assignment
* Azure OpenAI model deployments
* Generate embeddings
* Perform vector search
* Retrieve enterprise documents
* Ground LLM responses using Azure AI Search
* Apply Azure AI Content Safety
* End-to-end Agentic RAG workflow

---

# 🧠 AI-103 Concepts Covered

* Agentic RAG
* Retrieval-Augmented Generation
* Vector Embeddings
* Semantic Search
* Azure AI Search Indexes
* Azure AI Foundry Projects
* Azure OpenAI Deployments
* Content Safety
* RBAC
* Managed Infrastructure

---

# 💼 Business Applications

* Customer Support Agents
* Enterprise Knowledge Bases
* HR Assistants
* IT Help Desks
* Legal Document Search
* Healthcare Knowledge Retrieval
* Internal Company Search

---

# 📸 Screenshots

* Azure Resource Group
* Azure AI Foundry
* Azure AI Search
* Azure AI Search Index
* Model Deployments
* Content Safety Resource
* Successful Python Execution
* Agent Response
* Azure Portal Resources

---

# 📚 Key Learning Outcomes

* Understand the complete Agentic RAG pipeline.
* Learn how embeddings enable semantic similarity search.
* Understand how Azure AI Search retrieves relevant documents.
* Learn why grounding improves LLM accuracy.
* Configure Azure infrastructure using Infrastructure as Code (Bicep).
* Apply Azure RBAC for secure authentication.

---

# 🎯 AI-103 Exam Relevance

This build directly covers:

* Azure AI Search
* Vector Search
* Embeddings
* Retrieval-Augmented Generation
* Azure AI Foundry
* Azure OpenAI Deployments
* Content Safety
* Enterprise AI Architecture

---

# 📝 Key Takeaways

* LLMs generate responses.
* Embeddings enable semantic understanding.
* Azure AI Search retrieves relevant enterprise data.
* Grounding reduces hallucinations.
* Agentic RAG combines retrieval with reasoning to produce reliable enterprise AI applications.
