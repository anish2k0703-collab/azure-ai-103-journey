# 🍎 AI-103 Mac Setup Guide

## 🎯 Goal

Set up a Mac development environment for Azure AI-103 projects.

---

## 1. Verify Python Installation

```bash
python3 --version
```

Purpose:

Verify the Python version installed on the system.

---

## 2. Install Python 3.12

```bash
brew install python@3.12
```

Verify:

```bash
python3.12 --version
```

Purpose:

Modern AI-103 labs work best with Python 3.12.

---

## 3. Create a Virtual Environment

```bash
python3.12 -m venv tutorials
```

Purpose:

Create an isolated Python workspace for the project.

---

## 4. Activate the Environment

```bash
source tutorials/bin/activate
```

Expected:

```text
(tutorials)
```

Purpose:

Use the project's dedicated Python environment.

---

## 5. Upgrade pip

```bash
python -m pip install --upgrade pip
```

Purpose:

Update Python's package manager.

---

## 6. Install Dependencies

```bash
pip install -r requirements.txt
```

Purpose:

Install all required project packages.

---

## 7. Freeze Dependencies

```bash
pip freeze > requirements.txt
```

Purpose:

Save installed package versions.

---

## 8. Install Azure CLI

```bash
brew install azure-cli
```

Verify:

```bash
az version
```

Purpose:

Allow the computer to communicate with Azure.

---

## 9. Login to Azure

```bash
az login
```

Purpose:

Authenticate with Azure.

---

## 10. Configure launch.json

Purpose:

`launch.json` is an instruction file for VS Code.

It tells VS Code:

* Which Python file to execute
* Which Python environment to use
* Which environment variables to use
* How to debug the application

Think of it as:

```text
Me
↓
VS Code
↓
launch.json
↓
Python
↓
Azure Cloud
```

---

## 🧠 Mental Model

```text
Mac
↓
Python 3.12
↓
Virtual Environment
↓
requirements.txt
↓
VS Code
↓
launch.json
↓
Python Code
↓
Azure CLI
↓
Azure Cloud
```

---

## 📝 One-Line Summary

I am setting up my computer so my Python code can securely communicate with Azure AI services.
