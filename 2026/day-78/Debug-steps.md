**Step 1:--** Describe the pod to see the exact image and error:
- **kubectl describe pod <Name-of-pod>**
  - kubectl describe pod bankapp-mysql-0






### Suggestions

Option 2 — Use official MySQL image + disable init container (cleanest for dev):
bashhelm install bankapp-mysql bitnami/mysql \
  --set global.security.allowInsecureImages=true \
  --set image.registry=docker.io \
  --set image.repository=mysql \
  --set image.tag=8.0 \
  --set volumePermissions.enabled=false \
  --set auth.rootPassword=Test@123 \
  --set auth.database=bankappdb \
  --set primary.resources.requests.memory=256Mi \
  --set primary.resources.requests.cpu=250m \
  --set primary.resources.limits.memory=512Mi \
  --set primary.resources.limits.cpu=500m \
  --set primary.persistence.size=5Gi
  