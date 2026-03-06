const express = require('express');
const mongoose = require('mongoose');
const path = require('path');
const fs = require('fs');

const app = express();
app.use(express.json());
app.use(express.static(path.join(__dirname, 'public')));

// ─────────────────────────────────────────────
// Build Counter (persisted in /data/build.json)
// ─────────────────────────────────────────────
const BUILD_FILE = '/data/build.json';

function getBuildInfo() {
  try {
    fs.mkdirSync('/data', { recursive: true });
    return JSON.parse(fs.readFileSync(BUILD_FILE, 'utf8'));
  } catch {
    return { count: 0, history: [] };
  }
}

function incrementBuild() {
  const info = getBuildInfo();
  info.count += 1;
  info.history.push({
    build: info.count,
    time: new Date().toISOString().replace('T', ' ').slice(0, 19),
  });
  info.history = info.history.slice(-10); // keep last 10
  fs.writeFileSync(BUILD_FILE, JSON.stringify(info));
  return info;
}

const BUILD_INFO = incrementBuild();

// ─────────────────────────────────────────────
// MongoDB Connection
// ─────────────────────────────────────────────
const MONGO_URI = `mongodb://${process.env.MONGO_USER || 'admin'}:${process.env.MONGO_PASSWORD || 'secret'}@${process.env.MONGO_HOST || 'mongo_db'}:27017/${process.env.MONGO_DB || 'practicedb'}?authSource=admin`;

mongoose.connect(MONGO_URI, { serverSelectionTimeoutMS: 3000 })
  .then(() => console.log('✅ MongoDB connected'))
  .catch(err => console.error('❌ MongoDB error:', err.message));

// ─────────────────────────────────────────────
// Routes
// ─────────────────────────────────────────────
app.get('/', (req, res) => {
  res.sendFile(path.join(__dirname, 'public', 'index.html'));
});

app.get('/api/health', (req, res) => {
  const mongoStatus = mongoose.connection.readyState;
  // 0=disconnected, 1=connected, 2=connecting, 3=disconnecting
  const statusMap = { 0: 'error', 1: 'connected', 2: 'connecting', 3: 'disconnecting' };

  const services = [
    {
      name: 'Express API',
      description: 'Node.js web server (this container)',
      port: 3000,
      status: 'running',
    },
    {
      name: 'MongoDB',
      description: 'NoSQL document database',
      port: 27017,
      status: statusMap[mongoStatus] || 'error',
    },
    // ── ADD NEW SERVICES HERE (see README) ──
  ];

  const healthy = services.filter(s => ['connected', 'running'].includes(s.status)).length;
  const issues  = services.filter(s => s.status === 'error').length;

  res.json({
    total: services.length,
    healthy,
    issues,
    services,
    build: {
      count:   BUILD_INFO.count,
      history: BUILD_INFO.history,
    },
  });
});

// ─────────────────────────────────────────────
// Start
// ─────────────────────────────────────────────
const PORT = process.env.PORT || 3000;
app.listen(PORT, () => console.log(`🚀 Server running on port ${PORT}`));
