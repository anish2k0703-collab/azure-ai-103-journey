# 🔎 AI-103 Build 06 - Azure AI Search (Part 1): Basic Search and Retrieval

## 🎯 Project Overview

This project introduces **Azure AI Search**, Microsoft's cloud-based search engine for building intelligent search experiences in enterprise applications.

In this first part, I learned how to provision an Azure AI Search service, create a search index, upload documents, and query those documents programmatically using Python.

This build focuses on **traditional keyword-based search** and intentionally does **not** use vector search, semantic search, embeddings, or Retrieval-Augmented Generation (RAG). Those advanced concepts will be explored in later builds.

---

## 🧠 What Problem Are We Solving?

Organizations often have thousands or millions of documents spread across databases, websites, PDFs, and internal systems.

Searching through this information manually is inefficient.

Azure AI Search provides a centralized search engine that allows users to:

* Store searchable content
* Build indexes
* Retrieve relevant information quickly
* Rank search results based on relevance
* Build enterprise search applications

Think of Azure AI Search as a specialized search engine that organizations can build into their applications.

---

## 🏗️ Architecture Overview

This project follows the following lifecycle:

```text
Azure AI Search Service
        ↓
Create Search Index
        ↓
Upload Documents
        ↓
Perform Search Query
        ↓
Retrieve Ranked Results
```

---

## ⚙️ Technologies Used

### ☁️ Azure Services

* Azure AI Search
* Azure Role-Based Access Control (RBAC)
* Azure Resource Manager (ARM)

### 💻 Programming Languages

* Python
* Bicep
* Bash (Azure CLI)

### 📚 Python Libraries

* azure-identity
* azure-search-documents

---

## 🧩 What Was Built?

### 1️⃣ Provision Azure AI Search using Bicep

Infrastructure was deployed using Infrastructure-as-Code.

The Bicep file created:

* Azure AI Search service
* Search service endpoint
* Search service configuration

---

### 2️⃣ Create a Search Index

A search index was created to define how documents are stored.

The schema included:

| Field    | Type              | Purpose            |
| -------- | ----------------- | ------------------ |
| id       | String            | Unique identifier  |
| title    | Searchable String | Document title     |
| content  | Searchable String | Main document body |
| category | Filterable String | Document category  |

---

### 3️⃣ Upload Documents

Five sample documents were uploaded.

Examples:

* Azure Machine Learning Tutorial
* Python Programming
* Azure AI Search Best Practices
* Cloud Computing Fundamentals
* Docker Fundamentals

---

### 4️⃣ Query the Search Index

The application searched:

```text
What is Docker?
```

Azure AI Search:

* Tokenized the query
* Matched relevant words
* Scored matching documents
* Returned ranked results

---

## 🔐 RBAC Roles Implemented

Three Azure AI Search roles were assigned.

### Search Service Contributor

Manage the Azure AI Search service itself.

### Search Index Data Contributor

Create, update, and delete index data.

### Search Index Data Reader

Read and query index data.

---

## 🧠 Key Concepts Learned

### Search Index

A structured container that stores searchable information.

### Documents

Individual records stored inside the index.

### Searchable Fields

Fields Azure AI Search can search through.

### Filterable Fields

Fields that can be filtered.

### Relevance Score

Azure AI Search automatically ranks documents based on relevance.


---

## 🎓 Key AI-103 Exam Takeaways

* Understand the Azure AI Search lifecycle
* Learn how indexes work
* Learn document ingestion
* Understand RBAC permissions
* Differentiate keyword search from semantic/vector search
* Learn Infrastructure-as-Code with Bicep
