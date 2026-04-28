<p align="center">
<img src="assets/main.jpg" width="700" alt="CKPool-DigiByte Stack">
</p>

# CKPool‑Bitcoin-Cash: Solo Mining
A fully integrated, deterministic solo‑mining pool for Bitcoin-Cash (BCH), combining:

-CKPool — optimized CKPool fork for Bitcoin-Cash

-Bitcoin-Cash Core — full node providing consensus, mempool, and block validation

-CKStats — modern Next.js dashboard for real‑time pool monitoring

-Systemd services — production‑grade orchestration

-Artifact‑free configs — clean, reproducible, deterministic setup

-This repository provides everything required to run a self‑hosted, autonomous Bitcoin cash solo‑mining pool.

---
## 🚀 Features

### CKPool
-Lightweight, high‑performance solo mining pool

-Supports ASICs

-Custom BCH‑specific patches

-Clean configuration (ckpool.conf)

-Built‑in stratum server

-Coinbase tag support via btcsig

-Bitcoin-Cash Core

-Full Bitcoin-BCH node

-Provides block templates to CKPool

-Validates mined blocks

-Exposes RPC for pool operations

-Clean, unbuilt source included for reproducibility

-Either build the node manually or use the automatic build named buil-bchn.sh 

## CKStats Dashboard
-Next.js + Tailwind + TypeORM

-Real‑time miner stats

-Worker performance

-Pool health

-Block submissions

-PostgreSQL backend

-Clean .env.example included

-Systemd Integration
-ckpool.service

-bitcoin.service

-ckstats.service

-Automatic restart

-Log rotation ready

## 🔧 Build Instructions
``
-Bitcoin-Cash Core
-This repository includes the full unbuilt Bitcoin Cash Node (BCHN) source.
-BCHN does NOT use Autotools.
-Do NOT run ./autogen.sh, ./configure, or make.
``
## Install dependencies:
``
sudo apt update
sudo apt install -y \
  build-essential \
  cmake \
  ninja-build \
  pkg-config \
  libssl-dev \
  libevent-dev \
  libboost-all-dev \
  libzmq3-dev \
  libsqlite3-dev \
  python3
``

## Build BCHN:
``
cd bitcoin-cash
mkdir build
cd build
cmake -GNinja ..
ninja
``
## Install binaries:
``
mkdir -p ~/Bitcoincash/bin
cp src/bitcoind src/bitcoin-cli src/bitcoin-tx ~/Bitcoincash/bin/
CKPool
Code
sudo apt-get install build-essential yasm libzmq3-dev
./configure
make
``
## CKStats Dashboard
-Install Dependencies:

-Install pnpm if not already available:
``
curl -fsSL https://get.pnpm.io/install.sh | bash
``
``
cp .env.example .env  
pnpm install  
pnpm build  
pnpm start
``
## ⚙️ Systemd Setup (Manual Creation)
-Create Bitcoin-Cash service
``
sudo nano /etc/systemd/system/bitcoincash.service
``

``
[Unit]
Description=Bitcoin-Cash Daemon
After=network.target

[Service]
ExecStart=/home/umbrel/bitcoin-cash/src/bitcoind -conf=/home/umbrel/bitcoin-cash/ckpool/configs/bitcoin.conf
User=umbrel
Restart=always
TimeoutStopSec=90
Type=simple

[Install]
WantedBy=multi-user.target
``
## Create CKPool‑BCH service
``
sudo nano /etc/systemd/system/ckpoolbch.service
Code
[Unit]
Description=CKPool-BCH Solo Pool
After=network.target bitcoin.service

[Service]
ExecStart=/home/umbrel/bitcoin-cash/ckpool/src/ckpool -c /home/umbrel/bitcoin-cash/ckpool/ckpool.conf
User=umbrel
Restart=always
Type=simple

[Install]
WantedBy=multi-user.target
``
## Create CKStats Dashboard service
``
sudo nano /etc/systemd/system/ckstatsbch.service
``
[Unit]
Description=CKStats Dashboard
After=network.target postgresql.service

[Service]
WorkingDirectory=/home/umbrel/bitcoin-cash/ckstats
ExecStart=/usr/bin/pnpm start
User=umbrel
Restart=always
Environment=NODE_ENV=production
Type=simple

[Install]
WantedBy=multi-user.target
``
## Enable and start all services
``
sudo systemctl daemon-reload
sudo systemctl enable bitcoin-cash ckpool ckstatsbch
sudo systemctl start bitcoin-cash ckpool ckstatsbch
``
## 🔥 PM2 Setup (Alternative to Systemd)
PM2 is a lightweight process manager that can supervise Bitcoin-Cash Core, CKPool‑BCH, and CKStats.

1. Install PM2
``
sudo npm install -g pm2
pm2 -v
``
## 2. Start Bitcoin-sv Core under PM2

``
pm2 start /home/umbrel/bitcoin-cash/src/bitcoind --name bitcoin-cash -- \
  -conf=/home/umbrel/bitcoin-cash/data/bitcoin.conf \
  -daemon=0
 `` 
## Logs:

``
pm2 logs bitcoin-cash
``
## 3. Start CKPool‑BCH under PM2
pm2 start /home/umbrel/bitcoin-cash/ckpool-bch/ --name ckpool-bch -- \
  -c /home/umbrel/bitcoin-cash/ckpool/ckpool.conf
``
## Logs:

``
pm2 logs ckpool-bch
``
## 4. Start CKStats under PM2

cd /home/umbrel/bitcoin-cash/ckstats
``
pm2 start pnpm --name ckstats-bch -- start
``
## Logs:
``
pm2 logs ckstats
``
## 5. Save PM2 Process List
``
pm2 save
``
## 6. Enable PM2 Startup on Boot
``
pm2 startup
``
## Follow the printed command.

## 7. PM2 Management Commands
Status:

``
pm2 status
``
## Restart:

``
pm2 restart bitcoin-cash
pm2 restart ckpool-bch
pm2 restart ckstats-bch
``
## Stop:

``
pm2 stop bitcoin-cash
pm2 stop ckpool-bch
pm2 stop ckstats-bch
``
## Delete:

``
pm2 delete bitcoin-cash
pm2 delete ckpool-bch
pm2 delete ckstats-bch
``
## Check CKStats:
Open browser:

http://<your-ip>:3001
🛡️ Security Notes
Never expose CKPool or Bitcoin-Cash RPC to the public internet

Use firewall rules to restrict access

Keep .env files private

Only .env.example is committed

## 📜 License
CKPool‑BCH: GPLv2

Bitcoin-BCH Core: MIT

## CKStats: MIT

## 🤝 Contributing
Pull requests are welcome.
For major changes, open an issue first to discuss what you’d like to modify.
