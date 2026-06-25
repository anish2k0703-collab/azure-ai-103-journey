# 🚀 AI-103 Build 07 – Azure AI Search: Vector Search & Semantic Ranking

## 📌 Overview

This project is **Build 07** of my **Microsoft AI-103 Learning Journey**, where I explored **Vector Search** and **Semantic Ranking** using **Azure AI Search** and **Azure AI Foundry (Azure OpenAI)**.

In the previous build, I implemented **basic keyword search** using Azure AI Search. While keyword search is useful, it relies on exact word matching. Modern AI applications such as **ChatGPT, Microsoft Copilot, and enterprise RAG (Retrieval-Augmented Generation) systems** require a much smarter retrieval mechanism that understands the **meaning** behind a user's query.

This build demonstrates how Azure AI Search combines **embeddings**, **vector search**, and **semantic ranking** to retrieve documents based on semantic similarity rather than exact keyword matches.

---

# 🎯 Objectives

The objectives of this build were to:

* Learn how vector search works in Azure AI Search
* Generate embeddings using Azure OpenAI
* Store embeddings inside Azure AI Search indexes
* Perform semantic retrieval
* Understand how enterprise AI systems retrieve grounding information
* Learn the RBAC permissions required for Azure AI Search and Azure OpenAI
* Understand how vector search forms the foundation of Retrieval-Augmented Generation (RAG)

---

# 🏗️ Architecture

```
User Query
      │
      ▼
Azure OpenAI Embedding Model
      │
Generate Query Embedding
      │
      ▼
Azure AI Search
(Vector Index)
      │
Similarity Search
      │
      ▼
Most Relevant Documents
      │
      ▼
Grounding for AI Applications
```

---

# 💼 Business Problem

Traditional keyword search only finds documents containing the same words as the user's query.

For example:

Query:

```
How do I cross the road?
```

A keyword search may fail if no document literally contains those exact words.

Vector Search instead understands the **meaning** of the question and retrieves documents discussing road safety, pedestrian crossings, or traffic rules even if they use different wording.

This capability is essential for:

* Enterprise knowledge bases
* Customer support chatbots
* Internal documentation search
* AI assistants
* Microsoft Copilot
* Retrieval-Augmented Generation (RAG)

---

# 🔍 What Was Built

This project includes:

* Azure AI Search Service
* Azure AI Services (Azure OpenAI)
* Vector-enabled Search Index
* Embedding generation using Azure OpenAI
* Uploading vectorized documents
* Semantic search queries
* RBAC authentication
* Python SDK implementation

---

# 🧠 Concepts Learned

## Azure OpenAI Embeddings

Embeddings convert text into numerical vectors.

Instead of storing words, Azure stores mathematical representations that capture semantic meaning.

In this build:

* Documents were converted into **1536-dimensional vectors**
* Query text was converted into vectors
* Similar vectors were retrieved during search

---

## Vector Search

Instead of matching exact words:

```
Docker
```

↓

Azure finds documents that are semantically related to Docker.

This allows AI systems to retrieve information even when wording differs.

---

## Semantic Ranking

After vector retrieval, Azure AI Search can further rank results using semantic understanding.

This improves answer quality by placing the most meaningful documents at the top.

---

## Grounding

Grounding means providing an AI model with real enterprise documents before it generates a response.

Instead of hallucinating, the AI answers using retrieved information.

---

# 🧪 Testing Performed

I tested multiple search scenarios to verify that vector search was working correctly.

### Test 1

**Query**

```
What is Docker?
```

Result:

Azure AI Search successfully retrieved the document explaining Docker and containerization.

---

### Test 2

**Query**

```
How do I cross the road?
```

Result:

Azure AI Search returned the most semantically relevant document instead of relying on exact keyword matching.

This demonstrated that vector search understands **meaning**, not just matching words.


---

# 🛠 Technologies Used

* Python
* Azure AI Search
* Azure AI Foundry
* Azure OpenAI
* Azure CLI
* Bicep
* VS Code
* Azure Identity
* Azure Search SDK

---

# ⚠ Subscription & Quota Requirements

One important lesson from this build is that **Azure OpenAI embedding models require sufficient quota**.

For the `text-embedding-3-small` model:

* A free trial subscription may not have the required quota.
* You may need to **upgrade to a Pay-As-You-Go Azure subscription**.
* You may also need to **request quota approval** for the embedding model before deployments become usable.

Without sufficient quota, embedding requests may fail even if the deployment exists.

---

# 🎯 AI-103 Exam Relevance

This build covers several important AI-103 concepts:

* Azure AI Search
* Vector Search
* Semantic Search
* Embeddings
* Grounding
* Retrieval-Augmented Generation (RAG)
* Azure OpenAI
* RBAC
* Enterprise AI Search

---

# 📚 Key Takeaways

* Vector Search retrieves information based on **meaning**, not exact words.
* Embeddings convert text into numerical vectors.
* Azure OpenAI SDK uses the **deployment name**, not the base model name.
* Azure AI Search and Azure OpenAI require separate RBAC roles.
* Index names must be lowercase and use dashes only.
* Azure regional capacity can affect deployments.
* Azure OpenAI embedding models require sufficient quota before they can be used.

---

# 🧠 Memory Trick

> **Keyword Search → Finds words**
> **Vector Search → Finds meaning**
> **Semantic Ranking → Finds the best answer**
> **Grounding → Helps AI answer using real enterprise data**
