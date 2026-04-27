module.exports = {
  apps: [{
    name: "ckstats-bch",
    script: "pnpm",
    args: "start",
    cwd: "/home/YOURPATH/bitcoin-cash/ckstats",
    interpreter: "none",
    autorestart: true,
    env: {
      PORT: 3001
    }
  }]
}


// change the yourpath to your actual path
