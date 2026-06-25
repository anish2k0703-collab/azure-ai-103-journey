# 🛠️ Troubleshooting

## Issue 1 – Unknown Model

### Error

```
unknown_model
```

### Root Cause

The Azure OpenAI SDK could not find the deployment name.

### Resolution

Verify model deployments:

```bash
az cognitiveservices account deployment list \
  --resource-group aiagent-course-rg \
  --name anish0703build8
```

Update `launch.json` with the correct deployment names.

---

## Issue 2 – Missing RBAC Permissions

### Error

403 Authorization Failed

### Root Cause

User lacked Azure RBAC permissions.

### Resolution

Added automatic RBAC role assignments in the Bicep template:

* Cognitive Services User
* Search Service Contributor
* Search Index Data Contributor
* Search Index Data Reader

Wait 2–5 minutes after deployment for permissions to propagate.

---

## Issue 3 – Embedding Generation Failure

### Error

Embedding generation failed.

### Root Cause

Incorrect deployment name or endpoint.

### Resolution

Verified:

* Azure OpenAI Endpoint
* Embedding Deployment Name
* launch.json configuration

---

## Issue 4 – Search Service Verification

### Error

Azure CLI did not recognize `az search index`.

### Root Cause

The Azure CLI Search extension was unavailable.

### Resolution

Verified the index using the Azure AI Search REST API with a Microsoft Entra ID access token.

---

## Issue 5 – Generic LLM Responses

### Observation

The assistant answered generically instead of returning the exact product information.

### Investigation

Verified:

* Azure AI Search service
* Search index
* Indexed documents

The order documents were correctly indexed.

### Lesson Learned

RAG consists of two stages:

1. Retrieval
2. Generation

Even if documents exist in the search index, the retrieved content must be successfully passed into the LLM prompt to produce grounded responses.

---

# Lessons Learned

* Deployment names must match exactly.
* Azure OpenAI uses deployment names, not base model names.
* RBAC propagation may take several minutes.
* Azure AI Search service, indexes, and documents should all be verified independently.
* Agentic RAG depends on both retrieval quality and prompt grounding.
* Infrastructure as Code simplifies repeatable deployments and permission management.
