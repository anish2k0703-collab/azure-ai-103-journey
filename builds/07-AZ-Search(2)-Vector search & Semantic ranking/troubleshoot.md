# Troubleshooting Guide – AI-103 Build 07

## 📌 Overview

This document captures every significant issue encountered while completing **AI-103 Build 07 – Azure AI Search: Vector Search & Semantic Ranking**, along with the root cause, solution, and lessons learned.

One of the goals of this GitHub learning journey is not only to document successful implementations but also to record real-world Azure troubleshooting scenarios that are common in enterprise environments.

---

# ❌ Issue 1 – East US 2 Capacity Error

## Error

```text
InsufficientResourcesAvailable
The region 'eastus2' is currently out of the resources required to provision new services.
```

## Root Cause

Although Azure AI Search supports deployment in **East US 2**, the region did not have enough available capacity to provision new resources at that time.

## Resolution

Changed the deployment region from:

```text
eastus2
```

to

```text
eastus
```

and redeployed the Bicep template.

## Lesson Learned

A region supporting a service does **not** guarantee that sufficient resources are currently available.

---

# ❌ Issue 2 – CustomDomainInUse

## Error

```text
CustomDomainInUse
```

## Root Cause

The Azure AI Services resource name:

```text
unit7course
```

was already being used globally.

Azure AI Services requires globally unique subdomain names.

## Resolution

Changed the deployment parameter to:

```text
anish0703build7
```

and redeployed.

## Lesson Learned

Always use a unique resource prefix when deploying Azure AI Services.

---

# ❌ Issue 3 – Search Service Not Found During RBAC Assignment

## Error

```text
ResourceNotFound
```

while assigning Search roles.

## Root Cause

The RBAC command referenced the previous build:

```text
anish0703build6-aisearch
```

instead of the Build 07 search service.

## Resolution

Listed available Azure AI Search services and updated the RBAC scope to:

```text
anish0703build7-aisearch
```

## Lesson Learned

Always verify resource names after each deployment before assigning RBAC permissions.

---

# ❌ Issue 4 – Missing Azure OpenAI Endpoint

## Error

```text
APIConnectionError

Request URL is missing an http:// or https:// protocol.
```

## Root Cause

The environment variable:

```text
AZURE_OPENAI_ENDPOINT
```

was empty inside `launch.json`.

## Resolution

Updated the endpoint to:

```text
https://anish0703build7.services.ai.azure.com/openai/v1
```

## Lesson Learned

Azure SDK clients require a complete endpoint URL including the protocol.

---

# ❌ Issue 5 – Azure OpenAI Permission Denied

## Error

```text
401 PermissionDenied

The principal lacks the required data action
```

## Root Cause

Azure AI Search permissions had been assigned, but the user did not have Azure OpenAI data-plane permissions.

## Resolution

Assigned the following Azure role:

```text
Cognitive Services OpenAI User
```

Then refreshed authentication:

```bash
az logout
az login
```

Waited several minutes for RBAC propagation.

## Lesson Learned

Azure AI Search permissions and Azure OpenAI permissions are completely separate.

Vector search requires access to **both** services.

---

# ❌ Issue 6 – Azure AI User Role Not Found

## Error

```text
Role 'Azure AI User' doesn't exist.
```

## Root Cause

The subscription did not contain the newer Azure AI role definition.

## Resolution

Used:

```text
Cognitive Services OpenAI User
```

instead.

## Lesson Learned

Role names may vary between Azure subscriptions and service versions.

Always verify available roles before assigning RBAC permissions.

---

# ❌ Issue 7 – Embedding Model Unavailable

## Error

```text
Unavailable model:

text-embedding-3-small
```

## Root Cause

The Python SDK expects the **deployment name**, not the underlying model name.

Additionally, embedding models require sufficient Azure quota.

## Resolution

Listed Azure AI deployments:

```bash
az cognitiveservices account deployment list
```

Updated the Python environment to use:

```text
anish0703build7-embedding-deploy
```

instead of:

```text
text-embedding-3-small
```

## Lesson Learned

Azure OpenAI uses deployment names.

Always verify the deployment name before updating the environment variables.

---

# ❌ Issue 8 – Embedding Model Quota

## Observation

The embedding deployment required quota approval.

The Free Trial Azure subscription may not provide sufficient quota for embedding models.

## Resolution

Requested quota approval and upgraded the Azure subscription to a Pay-As-You-Go account.

## Lesson Learned

Some Azure OpenAI models require both:

* Deployment
* Available quota

before they become usable.

---

# ❌ Issue 9 – Invalid Azure AI Search Index Name

## Error

```text
InvalidIndexName

Index name must only contain lowercase letters,
digits or dashes.
```

## Root Cause

The Python script attempted to create:

```text
Build_7_ai_search_index
```

Azure AI Search does not allow:

* Uppercase letters
* Underscores

## Resolution

Renamed the index:

```text
build-7-ai-search-index
```

## Lesson Learned

Azure AI Search index names must:

* use lowercase letters
* contain only letters, digits and dashes
* not begin or end with a dash

---

# ❌ Issue 10 – VS Code Python Interpreter

## Problem

The original launch configuration referenced the Windows interpreter:

```text
tutorials/Scripts/python.exe
```

## Resolution

Updated it for macOS:

```text
${workspaceFolder}/tutorials/bin/python
```

Verified using:

```bash
which python
```

## Lesson Learned

Always use the virtual environment interpreter instead of the system Python.

---

# ❌ Issue 11 – Deployment Name vs Model Name

## Problem

Initially, the environment variable contained:

```text
text-embedding-3-small
```

instead of the deployment name.

## Resolution

Updated:

```text
EMBEDDING_MODEL_DEPLOYMENT_NAME
```

to:

```text
anish0703build7-embedding-deploy
```

## Lesson Learned

This is one of the most common Azure OpenAI mistakes.

Remember:

**Model Name ≠ Deployment Name**

The SDK requires the deployment name.

---

# 🧠 Overall Lessons Learned

Throughout this build, several important Azure concepts became clear:

* Azure AI Search and Azure OpenAI require separate RBAC permissions.
* Deployment names are different from model names.
* Azure OpenAI embedding models require quota approval.
* Azure regional capacity may prevent deployments even in supported regions.
* Resource names must be globally unique.
* Azure AI Search index names have strict naming rules.
* RBAC changes require several minutes to propagate.
* Always verify deployments, role assignments, and environment variables before debugging Python code.

---

# ✅ Final Outcome

After resolving all issues, the project successfully:

* Generated embeddings using Azure OpenAI
* Created a vector-enabled Azure AI Search index
* Uploaded vectorized documents
* Performed semantic search queries
* Returned relevant search results based on semantic similarity

This build provided hands-on experience with the same technologies used in modern enterprise AI systems, including Retrieval-Augmented Generation (RAG), intelligent search, and AI-powered knowledge retrieval.
