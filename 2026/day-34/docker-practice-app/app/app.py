from flask import Flask, jsonify, render_template
import psycopg2
import os
import json
from datetime import datetime

app = Flask(__name__)

"""
# ─────────────────────────────────────────────
# Build Counter
# Stored in a JSON file inside the container.
# The file lives in a Docker volume so the count
# persists across container restarts.
# Every time you run `docker compose up --build`
# the counter goes up by 1.
# ─────────────────────────────────────────────
BUILD_FILE = "/data/build_count.json"

def get_build_info():
    os.makedirs("/data", exist_ok=True)
    try:
        with open(BUILD_FILE, "r") as f:
            return json.load(f)
    except FileNotFoundError:
        return {"count": 0, "history": []}

def increment_build():
    info = get_build_info()
    info["count"] += 1
    info["history"].append({
        "build": info["count"],
        "time": datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    })
    # Keep only the last 10 builds in history
    info["history"] = info["history"][-10:]
    with open(BUILD_FILE, "w") as f:
        json.dump(info, f)
    return info

# Increment counter once when Flask starts (i.e. on every new build)
BUILD_INFO = increment_build()
"""

# ─────────────────────────────────────────────
# Helper: check PostgreSQL connection
# ─────────────────────────────────────────────
def check_postgres():
    try:
        conn = psycopg2.connect(
            host=os.getenv("POSTGRES_HOST", "postgres_db"),
            port=int(os.getenv("POSTGRES_PORT", 5432)),
            database=os.getenv("POSTGRES_DB", "practicedb"),
            user=os.getenv("POSTGRES_USER", "admin"),
            password=os.getenv("POSTGRES_PASSWORD", "secret"),
            connect_timeout=3,
        )
        conn.close()
        return {"status": "connected", "port": 5432}
    except Exception as e:
        return {"status": "error", "port": 5432, "error": str(e)}


# ─────────────────────────────────────────────
# Routes
# ─────────────────────────────────────────────
@app.route("/")
def index():
    return render_template("index.html")


@app.route("/api/health")
def health():
    """
    Returns the health status of all services.
    To add a new service later, just add a new entry to the `services` list below.
    """
    postgres = check_postgres()

    # ── ADD NEW SERVICES HERE (see README for full instructions) ──
    services = [
        {
            "name": "PostgreSQL",
            "description": "Primary relational database",
            "port": 5432,
            "status": postgres["status"],
            "error": postgres.get("error", None),
        },
        # EXAMPLE — uncomment when you add Redis:
        # {
        #     "name": "Redis",
        #     "description": "In-memory cache & message broker",
        #     "port": 6379,
        #     "status": check_redis()["status"],
        #     "error": check_redis().get("error", None),
        # },
    ]

    healthy = sum(1 for s in services if s["status"] in ("connected", "running"))
    issues  = sum(1 for s in services if s["status"] == "error")

    return jsonify({
        "total":    len(services),
        "healthy":  healthy,
        "issues":   issues,
        "services": services,
        "build": {
            "count":   BUILD_INFO["count"],
            "history": BUILD_INFO["history"],
        }
    })


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000, debug=True)
