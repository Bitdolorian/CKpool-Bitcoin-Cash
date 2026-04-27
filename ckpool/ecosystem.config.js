module.exports = {
  apps: [{
    name: "ckpool-bch",
    script: "/home/YOURPATH/bitcoin-cash/ckpool/src/ckpool",
    args: "-c /home/YOURPATH/bitcoin-cash/ckpool/ckpool.conf -n ckpool-bch",
    interpreter: "none",
    autorestart: true,
    watch: false,
    max_restarts: 10,
    log_type: "json",
    out_file: "/home/umbrel/bitcoin-cash/ckpool/logs/pm2-out.log",
    error_file: "/home/umbrel/bitcoin-cash/ckpool/logs/pm2-error.log"
  }]
}

// change yourpath to your actual path
