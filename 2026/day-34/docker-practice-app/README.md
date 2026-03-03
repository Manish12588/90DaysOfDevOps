# 🐳 Docker Practice App

A beginner-friendly multi-container app to practice Docker fundamentals.

**Stack:** Flask (Python) · PostgreSQL · Nginx

```
http://localhost:8080  →  Nginx  →  Flask API  →  PostgreSQL
```

---

## 📁 Project Structure

```
docker-practice-app/
├── app/
│   ├── app.py              ← Flask web server + health check logic
│   ├── requirements.txt    ← Python packages
│   ├── Dockerfile          ← How to build the Flask container
│   └── templates/
│       └── index.html      ← The dashboard UI
├── nginx/
│   └── default.conf        ← Nginx reverse-proxy config
├── docker-compose.yml      ← Defines ALL containers and how they connect
└── README.md               ← You are here
```

---

## 🚀 How to Run

### Prerequisites
- [Docker Desktop](https://www.docker.com/products/docker-desktop/) installed and running

### Start the app
```bash
# From the project root folder:
docker compose up --build
```

Open your browser at **http://localhost:8080**

### Stop the app
```bash
docker compose down
```

### Stop AND delete all saved data (volumes)
```bash
docker compose down -v
```

---

## 🧱 Understanding the Key Concepts

### What is a Container?
A container is like a mini-computer that runs only one service (e.g. just PostgreSQL, or just your Flask app). It's isolated from your machine but can talk to other containers over a **network**.

### What is docker-compose.yml?
It's the "master plan" file. It tells Docker:
- Which containers to create
- What settings/passwords to use
- Which ports to open
- How they connect to each other

### What is a Network?
All containers in this project join `app_network`. This lets them find each other by **name** instead of IP address.  
For example, Flask connects to PostgreSQL using the hostname `postgres_db` — that's the container name in `docker-compose.yml`.

### What is a Volume?
A volume saves data outside the container so it survives restarts.  
`postgres_data` saves your database rows even if you stop and restart Docker.

---

## ➕ How to Add a New Service

Follow these steps every time you want to add a new container (Redis, MySQL, MongoDB, etc.).

> **Rule of thumb:** You always touch 2–3 files:
> 1. `docker-compose.yml` — add the new container
> 2. `app/app.py` — add a health-check function
> 3. `app/requirements.txt` — add the Python library (if needed)

---

### Example A — Adding Redis

#### Step 1 · Add Redis to `docker-compose.yml`

Open `docker-compose.yml` and paste this block **inside the `services:` section** (after the `flask_app` block, before the `volumes:` section):

```yaml
  redis_cache:
    image: redis:7-alpine       # official Redis image, no build needed
    container_name: redis_cache
    restart: unless-stopped
    ports:
      - "6379:6379"
    networks:
      - app_network             # must match the network name at the bottom of the file
```

#### Step 2 · Install the Python library

Open `app/requirements.txt` and add:

```
redis==5.0.7
```

#### Step 3 · Add a health-check function in `app/app.py`

At the top of `app.py`, import the library:
```python
import redis as redis_client
```

Then add this function (anywhere before the `/api/health` route):
```python
def check_redis():
    try:
        r = redis_client.Redis(
            host=os.getenv("REDIS_HOST", "redis_cache"),  # container name = hostname
            port=int(os.getenv("REDIS_PORT", 6379)),
            socket_connect_timeout=3,
        )
        r.ping()
        return {"status": "connected", "port": 6379}
    except Exception as e:
        return {"status": "error", "port": 6379, "error": str(e)}
```

#### Step 4 · Register Redis in the health endpoint

Inside the `/api/health` route, find the `services = [...]` list and add a new entry:

```python
{
    "name": "Redis",
    "description": "In-memory cache & message broker",
    "port": 6379,
    "status": check_redis()["status"],
    "error": check_redis().get("error", None),
},
```

#### Step 5 · Restart everything

```bash
docker compose down
docker compose up --build
```

✅ Redis now appears on your dashboard!

---

### Example B — Adding MySQL

#### Step 1 · Add MySQL to `docker-compose.yml`

```yaml
  mysql_db:
    image: mysql:8
    container_name: mysql_db
    restart: unless-stopped
    environment:
      MYSQL_ROOT_PASSWORD: rootsecret
      MYSQL_DATABASE:      practicedb
      MYSQL_USER:          admin
      MYSQL_PASSWORD:      secret
    ports:
      - "3306:3306"
    volumes:
      - mysql_data:/var/lib/mysql   # persist MySQL data
    networks:
      - app_network
```

Also add the volume at the bottom of the file, inside `volumes:`:
```yaml
  mysql_data:
```

#### Step 2 · Add the Python library

Add to `app/requirements.txt`:
```
PyMySQL==1.1.1
```

#### Step 3 · Add the health-check function in `app/app.py`

Import at the top:
```python
import pymysql
```

Add the function:
```python
def check_mysql():
    try:
        conn = pymysql.connect(
            host=os.getenv("MYSQL_HOST", "mysql_db"),
            port=int(os.getenv("MYSQL_PORT", 3306)),
            user=os.getenv("MYSQL_USER", "admin"),
            password=os.getenv("MYSQL_PASSWORD", "secret"),
            database=os.getenv("MYSQL_DB", "practicedb"),
            connect_timeout=3,
        )
        conn.close()
        return {"status": "connected", "port": 3306}
    except Exception as e:
        return {"status": "error", "port": 3306, "error": str(e)}
```

#### Step 4 · Add MySQL to the health list

```python
{
    "name": "MySQL",
    "description": "MySQL 8.0 — mysql_db",
    "port": 3306,
    "status": check_mysql()["status"],
    "error": check_mysql().get("error", None),
},
```

#### Step 5 · Restart

```bash
docker compose down
docker compose up --build
```

---

### Example C — Adding MongoDB

#### Step 1 · `docker-compose.yml`

```yaml
  mongo_db:
    image: mongo:7
    container_name: mongo_db
    restart: unless-stopped
    environment:
      MONGO_INITDB_ROOT_USERNAME: admin
      MONGO_INITDB_ROOT_PASSWORD: secret
    ports:
      - "27017:27017"
    volumes:
      - mongo_data:/data/db
    networks:
      - app_network
```

Add `mongo_data:` to the `volumes:` section.

#### Step 2 · `requirements.txt`

```
pymongo==4.8.0
```

#### Step 3 · Health-check function

```python
from pymongo import MongoClient
from pymongo.errors import ConnectionFailure

def check_mongo():
    try:
        client = MongoClient(
            host=os.getenv("MONGO_HOST", "mongo_db"),
            port=int(os.getenv("MONGO_PORT", 27017)),
            username=os.getenv("MONGO_USER", "admin"),
            password=os.getenv("MONGO_PASSWORD", "secret"),
            serverSelectionTimeoutMS=3000,
        )
        client.admin.command("ping")
        return {"status": "connected", "port": 27017}
    except Exception as e:
        return {"status": "error", "port": 27017, "error": str(e)}
```

#### Step 4 · Register in health list

```python
{
    "name": "MongoDB",
    "description": "NoSQL document database",
    "port": 27017,
    "status": check_mongo()["status"],
    "error": check_mongo().get("error", None),
},
```

---

## 🔑 Quick Reference — Service Cheatsheet

| Service    | Image            | Default Port | Python Library      | Hostname (in code) |
|------------|------------------|:------------:|---------------------|--------------------|
| PostgreSQL | postgres:16-alpine | 5432       | psycopg2-binary     | `postgres_db`      |
| Redis      | redis:7-alpine   | 6379         | redis               | `redis_cache`      |
| MySQL      | mysql:8          | 3306         | PyMySQL             | `mysql_db`         |
| MongoDB    | mongo:7          | 27017        | pymongo             | `mongo_db`         |
| RabbitMQ   | rabbitmq:3-management | 5672    | pika                | `rabbitmq`         |

---

## 🐛 Troubleshooting

| Problem | Fix |
|---------|-----|
| `http://localhost:8080` not loading | Make sure Docker is running and you did `docker compose up --build` |
| Service shows "error" on dashboard | Check `docker compose logs <container_name>` for details |
| Port already in use | Change the left side of the port mapping, e.g. `"5433:5432"` |
| Data lost after restart | Make sure you added a `volume` for that service |
| Python library not found | Make sure you added it to `requirements.txt` AND ran `docker compose up --build` |

---

## 📚 What You're Learning

By working through this project you're practising:

- ✅ Writing a `Dockerfile` (how to package an app into an image)
- ✅ Writing `docker-compose.yml` (orchestrating multiple containers)
- ✅ Container networking (containers talking by hostname)
- ✅ Environment variables (passing config to containers safely)
- ✅ Volumes (persisting data)
- ✅ Port mapping (exposing container ports to your host machine)
- ✅ Reverse proxy pattern (Nginx → Flask)

Happy container-ing! 🐳
