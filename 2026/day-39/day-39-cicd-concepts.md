# Day 39 – What is CI/CD?

---

## Challenge Tasks

### Task 1: The Problem
Think about a team of 5 developers all pushing code to the same repo manually deploying to production.

Write in your notes:
1. What can go wrong?
   - There will be a merge conflict in repo when multiple developer push their code
   - Difficult to rollback if it fails because couldn't indentify which commits create problem.
  
2. What does "it works on my machine" mean and why is it a real problem?
    - Diifernt OS, libraries or version installed.
    - Environment varibale or configuration could be different.
    - There could be missing dependencies.

3. How many times a day can a team safely deploy manually?
    - Could be 1-2 times a day for safely deployment.

---

### Task 2: CI vs CD
Research and write short definitions (2-3 lines each):
1. **Continuous Integration** — what happens, how often, what it catches
    - What happens:
      - Developers frequently push code to a shared repository.
      - CI tools (like Jenkins, GitHub Actions, GitLab CI/CD, or CircleCI) automatically build the code and run tests, providing instant feedback.

    - How often:
      - Every time code is pushed—often multiple times per day.

    - What is catch:
      - Compilation errors, failing tests, integration issues, and early bugs before they reach production.

2. **Continuous Delivery** — how it's different from CI, what "delivery" means
    - Continuous Delivery (CD) extends CI so that every successful build is always in a deployable state, ready to release with (usually) just a manual approval or “push of a button”.
    - In Continuous Delivery, “delivery” does not necessarily mean “users are already running this version in production”.

3. **Continuous Deployment** — how it differs from Delivery, when teams use it
    - Continuous Deployment (CD in this sense) takes Continuous Delivery one step further: every change that passes the pipeline is automatically deployed to production with no manual approval step.
    - When team use it:
      - When they run online product where small, frequent updates are normal, They want user to see fixes and changes in minuts or hours, not weeks.
      - When they have string automatic test and monitoring so the system can catch problems quickly and, if needed, roll back to safe version.
  
Write one real-world example for each.

---

### Task 3: Pipeline Anatomy
A pipeline has these parts — write what each one does:
- **Trigger** — what starts the pipeline
  - It's an event that tells the system, "Start running this pipeline now."
  
- **Stage** — a logical phase (build, test, deploy)
  - A bug bucket of work, grouped by purpose such as "build", "test" or "deploy". The pipeline usually runs stages in order.
  
- **Job** — a unit of work inside a stage
  - A named piece of work within the stage, like "build-backend","run unit-test" or "deploy-to-staging". Each jobs has it's own configuration, environment and set of 
    steps.

- **Step** — a single command or action inside a job
  - The smallest action: run the command, use the plugin, checkout code, upload a file etc. A job is just a list of steps run in order.
  
- **Runner** — the machine that executes the job
  - The actual computer (VM, Container or physical machine) that runs the job's steps.

- **Artifact** — output produced by a job
  - Files a job produces and saves for later use.

---

### Task 4: Draw a Pipeline
Draw a CI/CD pipeline for this scenario:
> A developer pushes code to GitHub. The app is tested, built into a Docker image, and deployed to a staging server.

Include at least 3 stages. Hand-drawn and photographed is perfectly fine.

    Developer
    │
    ▼
    GitHub (Push Trigger)
    │
    ▼
    Run Tests (CI)
    │
    ▼
    Build Docker Image
    │
    ▼
    Deploy to Staging


---

### Task 5: Explore in the Wild
1. Open any popular open-source repo on GitHub (Kubernetes, React, FastAPI — pick one you know)
2. Find their `.github/workflows/` folder
3. Open one workflow YAML file
4. Write in your notes:
   - What triggers it?
   - How many jobs does it have?
   - What does it do? (best guess)
  
[Repo](https://github.com/fastapi/fastapi/blob/master/.github/workflows/add-to-project.yml)

```yaml
name: Add to Project

on:
  pull_request_target:
  issues:
    types:
      - opened
      - reopened

jobs:
  add-to-project:
    name: Add to project
    runs-on: ubuntu-latest
    steps:
      - uses: actions/add-to-project@v1.0.2
        with:
          project-url: https://github.com/orgs/fastapi/projects/2
          github-token: ${{ secrets.PROJECTS_TOKEN }}

```
   - What triggers it?
     - Run on pull request created for issue if open or reopened.
     
   - How many jobs does it have?
      - It has only one job which is add-to-project
  
   - What does it do? (best guess)
     - It open or reopned an issue to the corresponding project.
---

## Hints
- CI/CD is a practice, not just a tool
- GitHub Actions, Jenkins, GitLab CI, CircleCI — all are tools that implement CI/CD
- A pipeline failing is not a problem — it's CI/CD doing its job

---
