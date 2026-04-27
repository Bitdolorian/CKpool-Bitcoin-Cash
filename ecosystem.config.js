module.exports = {
  apps: [{
    name: 'bitcoin-cash',
    script: '/home/YOURPATH/bitcoin-cash/bin/bitcoind',
    args: '-datadir=/home/YOURPATH/bitcoin-cash/data -daemon=0',
    interpreter: 'none',
    autorestart: true,
    log_type: 'json'
  }]
}

// change YOURPATH to your actual directory
