# 🟢 Node + Mongo Docker Practice App

A beginner-friendly multi-container app to practice Docker with Node.js and MongoDB.

```
http://localhost:8080  →  Nginx  →  Express API  →  MongoDB
```

---

## 📁 Project Structure

```
node-mongo-app/
├── app/
│   ├── index.js            ← Express server + health check + build counter
│   ├── package.json        ← Node.js dependencies
│   ├── Dockerfile          ← How to build the Express container
│   └── public/
│       └── index.html      ← Dashboard UI
├── nginx/
│   └── default.conf        ← Nginx reverse-proxy config
├── docker-compose.yml      ← Defines all containers
├── .env.example            ← Environment variable template
├── .gitignore
└── README.md
```

---

## 🚀 How to Run

### Prerequisites
- [Docker Desktop](https://www.docker.com/products/docker-desktop/) installed and running

```bash
# Start everything
docker compose up --build

# Open browser at:
http://localhost:8080

# Stop
docker compose down

# Stop + delete all data
docker compose down -v
```

---

## ➕ How to Add a New Service

You always touch 3 files: `docker-compose.yml`, `app/index.js`, and `app/package.json`.

---

### Example — Adding Redis

#### Step 1 · `docker-compose.yml`
```yaml
  redis_cache:
    image: redis:7-alpine
    container_name: redis_cache
    restart: unless-stopped
    ports:
      - "6379:6379"
    networks:
      - app_network
```

#### Step 2 · `app/package.json` — add dependency
```json
"dependencies": {
  "express": "^4.19.2",
  "mongoose": "^8.4.0",
  "ioredis": "^5.3.2"
}
```

#### Step 3 · `app/index.js` — add health check

At the top:
```js
const Redis = require('ioredis');
const redis = new Redis({
  host: process.env.REDIS_HOST || 'redis_cache',
  port: process.env.REDIS_PORT || 6379,
  lazyConnect: true,
  connectTimeout: 3000,
});
redis.connect().catch(() => {});
```

Inside the `services` array in `/api/health`:
```js
{
  name: 'Redis',
  description: 'In-memory cache & message broker',
  port: 6379,
  status: redis.status === 'ready' ? 'connected' : 'error',
},
```

#### Step 4 · Rebuild
```bash
docker compose down
docker compose up --build
```

---

### Example — Adding MySQL

#### Step 1 · `docker-compose.yml`
```yaml
  mysql_db:
    image: mysql:8
    container_name: mysql_db
    environment:
      MYSQL_ROOT_PASSWORD: rootsecret
      MYSQL_DATABASE: practicedb
      MYSQL_USER: admin
      MYSQL_PASSWORD: secret
    ports:
      - "3306:3306"
    volumes:
      - mysql_data:/var/lib/mysql
    networks:
      - app_network
```
Add `mysql_data:` under `volumes:`.

#### Step 2 · `package.json`
```json
"mysql2": "^3.9.7"
```

#### Step 3 · `index.js`
```js
const mysql = require('mysql2/promise');

async function checkMySQL() {
  try {
    const conn = await mysql.createConnection({
      host: process.env.MYSQL_HOST || 'mysql_db',
      user: process.env.MYSQL_USER || 'admin',
      password: process.env.MYSQL_PASSWORD || 'secret',
      database: process.env.MYSQL_DB || 'practicedb',
      connectTimeout: 3000,
    });
    await conn.end();
    return 'connected';
  } catch { return 'error'; }
}
```

Add to services array:
```js
{ name: 'MySQL', description: 'Relational database', port: 3306, status: await checkMySQL() }
```

---

## 🔑 Service Cheatsheet

| Service   | Image           | Port  | npm Package  | Hostname       |
|-----------|-----------------|:-----:|--------------|----------------|
| MongoDB   | mongo:7         | 27017 | mongoose     | `mongo_db`     |
| Redis     | redis:7-alpine  | 6379  | ioredis      | `redis_cache`  |
| MySQL     | mysql:8         | 3306  | mysql2       | `mysql_db`     |
| PostgreSQL| postgres:16-alpine | 5432 | pg          | `postgres_db`  |

---

## 🐛 Troubleshooting

| Problem | Fix |
|---------|-----|
| Page not loading | Run `docker compose up --build` and wait 10s |
| MongoDB shows error | Run `docker compose logs mongo_db` |
| Port in use | Change left side of port e.g. `"27018:27017"` |
| Package not found | Add to `package.json` then `docker compose up --build` |
