# AI-103 Mac Setup Guide 🍎

## Goal

Set up my Mac so I can run AI-103 Azure AI code walkthroughs.

---

## 1. Check Python version

```bash
python3 --version
```

Purpose:

Check the Python version installed on my Mac.

---

## 2. Install Python 3.12 (One-time setup)

```bash
brew install python@3.12
```

Verify:

```bash
python3.12 --version
```

Purpose:

Modern AI-103 labs work better with Python 3.12.

---

## 3. Create a virtual environment

```bash
python3.12 -m venv tutorials
```

Purpose:

Create a private Python workspace for this project.

---

## 4. Activate the environment

```bash
source tutorials/bin/activate
```

Expected:

```text
(tutorials)
```

Purpose:

Tell the computer to use this project's Python.

---

## 5. Upgrade pip

```bash
python -m pip install --upgrade pip
```

Purpose:

Update Python's package installer.

---

## 6. Install dependencies

```bash
pip install -r requirements.txt
```

Purpose:

Install all packages required for this AI-103 lab.

---

## 7. Troubleshooting

Problem:

```text
No matching distribution found for anyio==4.13.0
```

What we learned:

* Old Python versions can cause package issues.
* Python 3.12 is recommended for AI-103.

---

## 8. Freeze dependencies

```bash
pip freeze > requirements.txt
```

Purpose:

Save the exact package versions currently installed.

---

## 9. Install Azure CLI (One-time setup)

```bash
brew install azure-cli
```

Verify:

```bash
az version
```

Purpose:

Allow my computer to communicate with Azure.

---

## 10. Login to Azure

```bash
az login
```

Purpose:

Connect my computer to my Azure account.

---

## 11. Create launch.json (VS Code setup)

Purpose:

`launch.json` is an instruction file for VS Code.

I DO NOT run this file.

VS Code reads it automatically.

It tells VS Code:

* Which Python file to run
* Which Python environment to use
* Which Azure variables to use
* How to debug my code

Think:

```text
Me
↓
VS Code
↓
launch.json
↓
Python program
↓
Azure Cloud
```

Important:

`launch.json` is for VS Code, NOT Python.

---

## 12. Exit the environment

```bash
deactivate
```

Purpose:

Exit the project's Python workspace.

---

# Mental Model 🧠

```text
Mac
↓
Python 3.12
↓
Virtual Environment (tutorials)
↓
requirements.txt
↓
VS Code
↓
launch.json
↓
Python Code (.py)
↓
Azure CLI
↓
Azure Cloud
```

# Who uses what?

requirements.txt → pip

launch.json → VS Code

.py → Python

.sh → Terminal

.bicep → Azure

Azure CLI → Azure

# One sentence summary

I am setting up my computer so my Python code can safely communicate with Azure AI services.
