const express = require('express');
const fs = require('fs');
const path = require('path');
const cors = require('cors');
const http = require('http');
const WebSocket = require('ws');

const app = express();
const PORT = 3001;

// Enable CORS
app.use(cors());
app.use(express.json());

const logFilePath = path.join(__dirname, 'log.json');

// Ensure log file exists
if (!fs.existsSync(logFilePath)) {
  fs.writeFileSync(logFilePath, JSON.stringify([]), { flag: 'w' });
}

// Create HTTP server & WebSocket server
const server = http.createServer(app);
const wss = new WebSocket.Server({ server });

// Broadcast function to send data to all connected clients
function broadcastLogs() {
  fs.readFile(logFilePath, 'utf8', (err, data) => {
    if (!err) {
      try {
        const logs = JSON.parse(data || '[]');
        wss.clients.forEach(client => {
          if (client.readyState === WebSocket.OPEN) {
            client.send(JSON.stringify({ type: 'logs', data: logs }));
          }
        });
      } catch (parseError) {
        console.error("Error parsing log file: ", parseError);
      }
    }
  });
}

// Watch log.json for changes and broadcast updates
try {
  fs.watchFile(logFilePath, () => {
    console.log("log.json updated, sending data to clients...");
    broadcastLogs();
  });
} catch (watchError) {
  console.error("Error watching file: ", watchError);
}

// WebSocket connection
wss.on('connection', (ws) => {
  console.log('New WebSocket connection');
  broadcastLogs();

  ws.on('message', (message) => {
    console.log("Received:", message);
    const parsedMessage = JSON.parse(message);

    if (parsedMessage.type === 'mood') {
      // Broadcast mood to all connected clients
      wss.clients.forEach(client => {
        if (client.readyState === WebSocket.OPEN) {
          client.send(JSON.stringify({ type: 'mood', data: parsedMessage.data }));
        }
      });
    }
  });

  ws.on('close', () => {
    console.log('WebSocket client disconnected');
  });
});

// API Endpoint to fetch logs manually
app.get('/get-logs', (req, res) => {
  fs.readFile(logFilePath, 'utf8', (err, data) => {
    if (err) {
      return res.status(500).json({ error: 'Unable to fetch logs' });
    }
    res.json({ logs: JSON.parse(data || '[]') });
  });
});

// API Endpoint to log a new detected keyword
app.post('/log-keyword', (req, res) => {
  const { keyword, query, time } = req.body;

  if (!keyword || !query || !time) {
    return res.status(400).json({ success: false, message: 'Missing fields' });
  }

  const logEntry = { keyword, query, time };

  fs.readFile(logFilePath, 'utf8', (err, data) => {
    let logs = [];
    if (!err) {
      try {
        logs = JSON.parse(data || '[]');
      } catch {
        logs = [];
      }
    }

    logs.push(logEntry);

    fs.writeFile(logFilePath, JSON.stringify(logs, null, 2), (writeErr) => {
      if (writeErr) {
        return res.status(500).json({ success: false, message: 'Error writing log' });
      }

      broadcastLogs();
      res.status(200).json({ success: true, message: 'Logged successfully', data: logEntry });
    });
  });
});

// Start server
server.listen(PORT, () => {
  console.log(`Server running on http://localhost:${PORT}`);
});
