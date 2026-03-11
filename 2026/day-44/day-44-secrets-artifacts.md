# Day 44 – Secrets, Artifacts & Running Real Tests in CI

### Task 1: GitHub Secrets
1. Go to your repo → Settings → Secrets and Variables → Actions
2. Create a secret called `MY_SECRET_MESSAGE`
   
   ![](Images/Task-1_Step-1.png)

3. Create a workflow that reads it and prints: `The secret is set: true` (never print the actual value)
4. Try to print `${{ secrets.MY_SECRET_MESSAGE }}` directly — what does GitHub show?

   ![](Images/Task-1_Step-4.png)

   [Task-1-Workflow](./YAML/day44_Task_1.yml)

Write in your notes: Why should you never print secrets in CI logs?
 
  - CI logs are public and accessible
  - Printing secrets can expose API keys, tokens, or passwords.
  
---

### Task 2: Use Secrets as Environment Variables
1. Pass a secret to a step as an environment variable
2. Use it in a shell command without ever hardcoding it
3. Add `DOCKER_USERNAME` and `DOCKER_TOKEN` as secrets (you'll need these on Day 45)

[Task-2-Workflow](./YAML/day44_Task_2.yml)

![](Images/Task-2.png)

---

### Task 3: Upload Artifacts
1. Create a step that generates a file — e.g., a test report or a log file
2. Use `actions/upload-artifact` to save it
3. After the workflow runs, download the artifact from the Actions tab

**Verify:** Can you see and download it from GitHub?

    Yes I am able to download it from github under actions tab.

[Task-3-Workflow](./YAML/day44_Task_3.yml)

![](Images/Task-3.png)

![](Images/Task-3_Step-1.png)
---

### Task 4: Download Artifacts Between Jobs
1. Job 1: generate a file and upload it as an artifact
2. Job 2: download the artifact from Job 1 and use it (print its contents)

[Task-3-Workflow](./YAML/day44_Task_3.yml)

![](Images/Task-4_Step-1.png)

![](Images/Task-4_Step-2.png)

Write in your notes: When would you use artifacts in a real pipeline?

  - Use artifacts when one job creates a file that another job needs — or when you want to download the file after the workflow finishes.

---

### Task 5: Run Real Tests in CI
Take any script from your earlier days (Python or Shell) and run it in CI:
1. Add your script to the `github-actions-practice` repo
2. Write a workflow that:
   - Checks out the code
   - Installs any dependencies needed
   - Runs the script
   - Fails the pipeline if the script exits with a non-zero code
3. Intentionally break the script — verify the pipeline goes red
4. Fix it — verify it goes green again

[Dependencies](./requirement.txt)

[Script](./system-info.sh)

[Task-5-Workflow](./YAML/day44_Task_5.yml)

![](Images/Task-5_Step-1.png)

![](Images/Task-5_Step-2.png)

---

### Task 6: Caching
1. Add `actions/cache` to a workflow that installs dependencies
2. Run it twice — observe the time difference
3. Write in your notes: What is being cached and where is it stored?

[Task-6-Workflow](./YAML/day44_Task_6.yml)

![](Images/Task-6.png)

---

## Hints
- Secrets: `${{ secrets.SECRET_NAME }}`
- Upload artifact: `uses: actions/upload-artifact@v4`
- Download artifact: `uses: actions/download-artifact@v4`
- Cache: `uses: actions/cache@v4`
- GitHub masks secret values in logs automatically

---