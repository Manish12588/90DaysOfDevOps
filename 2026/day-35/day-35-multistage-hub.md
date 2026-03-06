# Day 35 – Multi-Stage Builds & Docker Hub

## Task
Today's goal is to **build optimized images and share them with the world**.

Multi-stage builds are how real teams ship small, secure images. Docker Hub is how you distribute them. Both are interview favourites.

---

## Expected Output
- A markdown file: `day-35-multistage-hub.md`
- Dockerfiles demonstrating multi-stage builds
- An image pushed to your Docker Hub account

---

## Challenge Tasks

### Task 1: The Problem with Large Images
1. Write a simple Go, Java, or Node.js app (even a "Hello World" is fine)
2. Create a Dockerfile that builds and runs it in a **single stage**
   
   [Dockerfile](./learning-path-app-java/Dockerfile)

3. Build the image and check its **size**

        docker build -t day-35-task .
    
        Images size = 458 MB

    ![](Images/Task-1_Step-3.png)

Note down the size — you'll compare it later.

---

### Task 2: Multi-Stage Build
1. Rewrite the Dockerfile using **multi-stage build**:
   - Stage 1: Build the app (install dependencies, compile)
   - Stage 2: Copy only the built artifact into a minimal base image (`alpine`, `distroless`, or `scratch`)

    [Dockerfile.multistage](./learning-path-app-java/Dockerfile.multistage)

2. Build the image and check its size again
    
        docker build -f Dockerfile.multistage -t day-35-task-multistage .
    
3. Compare the two sizes

        With single stage docker file it created with 450 MB file but with multistage it created 200MB file size.

Write in your notes: Why is the multi-stage image so much smaller?
        Because in build stage we build the project and copy the build file only.
---

### Task 3: Push to Docker Hub
1. Create a free account on [Docker Hub](https://hub.docker.com) (if you don't have one)
2. Log in from your terminal
3. Tag your image properly: `yourusername/image-name:tag`
4. Push it to Docker Hub
   
    ![](Images/Task-3_Step-4.png)

5. Pull it on a different machine (or after removing locally) to verify
   
    docker pull <username/image-name>

    ![](Images/Task-3_Step-5.png)

---

### Task 4: Docker Hub Repository
1. Go to Docker Hub and check your pushed image
2. Add a **description** to the repository
3. Explore the **tags** tab — understand how versioning works
4. Pull a specific tag vs `latest` — what happens?

---

### Task 5: Image Best Practices
Apply these to one of your images and rebuild:
1. Use a **minimal base image** (alpine vs ubuntu — compare sizes)
2. **Don't run as root** — add a non-root USER in your Dockerfile
3. Combine `RUN` commands to **reduce layers**
4. Use **specific tags** for base images (not `latest`)

Check the size before and after.

---

## Hints
- Multi-stage: use `FROM ... AS builder` then `COPY --from=builder`
- Login: `docker login`
- Tag: `docker tag local-image:tag username/repo:tag`
- Push: `docker push username/repo:tag`
- Non-root user: `RUN adduser` + `USER`

---

## Submission
1. Add your Dockerfiles and `day-35-multistage-hub.md` to `2026/day-35/`
2. Include the link to your Docker Hub repo
3. Commit and push to your fork

---

## Learn in Public
Share your before/after image sizes on LinkedIn — the difference is always impressive.

`#90DaysOfDevOps` `#DevOpsKaJosh` `#TrainWithShubham`

Happy Learning!
**TrainWithShubham**
