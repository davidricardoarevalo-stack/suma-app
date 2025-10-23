module.exports = {
  apps: [{
    name: "suma-app",
    script: "backend/server.js",
    cwd: "/var/www/suma-app",
    env: {
      NODE_ENV: "production",
      PORT: 5000
    },
    env_production: {
      NODE_ENV: "production",
      PORT: 5000
    },
    instances: "max",
    exec_mode: "cluster",
    watch: false,
    max_memory_restart: "500M",
    error_file: "/var/log/suma-app/error.log",
    out_file: "/var/log/suma-app/access.log",
    log_file: "/var/log/suma-app/combined.log",
    time: true,
    autorestart: true,
    max_restarts: 10,
    min_uptime: "10s",
    kill_timeout: 5000
  }]
};