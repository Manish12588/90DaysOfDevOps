# Why Provision Datasources via YAML Instead of the UI?

---

## What is provisioning?

Instead of clicking through Grafana UI to add datasources, you define them in a YAML file:

```yaml
# grafana/provisioning/datasources/datasources.yml
apiVersion: 1
datasources:
  - name: Prometheus
    type: prometheus
    url: http://prometheus:9090
    isDefault: true

  - name: Loki
    type: loki
    url: http://loki:3100
```

Grafana reads this file at startup and configures datasources automatically.

---

## Problems with manual UI configuration

### 1. Lost on restart
```
docker compose down      ← datasources deleted
docker compose up        ← have to reconfigure everything manually again
```
Unless you mount a `grafana_data` volume, all UI changes are gone.

### 2. Not reproducible
- A new team member sets up the project
- They have to manually click through UI to add Prometheus, Loki, etc.
- They might use wrong URLs, wrong names, wrong settings
- No guarantee their setup matches yours

### 3. Not version controlled
```
UI change → exists only in Grafana's database
YAML change → exists in Git → tracked, reviewed, rollback-able
```

---

## Benefits of YAML provisioning

### 1. Survives restarts
```yaml
volumes:
  - ./grafana/provisioning/datasources:/etc/grafana/provisioning/datasources
```
Grafana loads the YAML every time it starts — datasources are always there.

### 2. Works across environments
```
Developer machine  →  docker compose up  →  datasources ready instantly
Staging server     →  docker compose up  →  datasources ready instantly
Production server  →  docker compose up  →  datasources ready instantly
```
Same YAML, same result everywhere.

### 3. Version controlled
```bash
git add grafana/provisioning/datasources/datasources.yml
git commit -m "add Loki datasource"
git push
```
- Full history of changes
- Easy rollback
- Code review before changes go live

### 4. Team collaboration
```
Without YAML:
  Dev 1 sets up datasources manually
  Dev 2 clones repo → runs docker compose up → no datasources
  Dev 2 has to ask Dev 1 "how did you configure Grafana?"

With YAML:
  Dev 1 sets up datasources in YAML → commits to Git
  Dev 2 clones repo → runs docker compose up → everything works
```

### 5. Disaster recovery
```
Server crashes → spin up new EC2 → git clone → docker compose up
→ Grafana fully configured automatically
```

---

## Comparison table

| | Manual UI | YAML Provisioning |
|---|---|---|
| Survives container restart | ❌ No (without volume) | ✅ Yes |
| Version controlled | ❌ No | ✅ Yes |
| Reproducible across machines | ❌ No | ✅ Yes |
| Team friendly | ❌ No | ✅ Yes |
| Disaster recovery | ❌ Manual redo | ✅ Automatic |
| Audit trail | ❌ No | ✅ Git history |

---

## Folder structure

```
project/
└── grafana/
    └── provisioning/
        ├── datasources/
        │   └── datasources.yml    ← defines Prometheus, Loki etc.
        └── dashboards/
            └── dashboards.yml     ← auto-imports dashboard JSON files
```

Mount it in docker-compose.yml:

```yaml
grafana:
  image: grafana/grafana-enterprise
  volumes:
    - grafana_data:/var/lib/grafana
    - ./grafana/provisioning/datasources:/etc/grafana/provisioning/datasources
    - ./grafana/provisioning/dashboards:/etc/grafana/provisioning/dashboards
```

---

## One line summary

> Manual UI configuration lives only in Grafana's database and disappears or drifts over time. YAML provisioning lives in your codebase, is version controlled, and makes your entire Grafana setup reproducible with a single `docker compose up`.