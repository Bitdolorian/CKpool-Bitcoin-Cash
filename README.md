<p align="center">
<img src="assets/main.jpg" width="700" alt="CKPool-DigiByte Stack">
</p>

CKPool‑Bitcoin-Cash: Solo Mining
A fully integrated, deterministic solo‑mining pool for Bitcoin‑Cash (BCH), combining:

CKPool — optimized CKPool fork for Bitcoin‑Cash

Bitcoin Cash Node (BCHN) — full node providing consensus, mempool, and block validation

CKStats — modern Next.js dashboard for real‑time pool monitoring

Systemd services — production‑grade orchestration

Artifact‑free configs — clean, reproducible, deterministic setup

This repository provides everything required to run a self‑hosted, autonomous Bitcoin‑Cash solo‑mining pool.

🚀 Features
CKPool
Lightweight, high‑performance solo mining pool

Supports ASICs

Custom BCH‑specific patches

Clean configuration (ckpool.conf)

Built‑in stratum server

Coinbase tag support via btcsig

Bitcoin Cash Node (BCHN)
Full BCH node

Provides block templates to CKPool

Validates mined blocks

Exposes RPC for pool operations

Unbuilt BCHN source included for deterministic builds

CKStats Dashboard
Next.js + Tailwind + TypeORM

Real‑time miner stats

Worker performance

Pool health

Block submissions

PostgreSQL backend

Clean .env.example included

Systemd Integration
ckpool.service

bitcoincash.service

ckstats.service

Automatic restart

Log rotation ready

🔧 Build Instructions
Bitcoin Cash Node (BCHN)
This repository includes the full BCHN source tree unbuilt.
BCHN does NOT use Autotools.
Do NOT run:

Code
./autogen.sh  
./configure  
make
Install Dependencies (Ubuntu/Debian)
bash
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
Build BCHN
bash
cd bitcoin-cash
mkdir build
cd build
cmake -GNinja ..
ninja
This produces:

Code
src/bitcoind
src/bitcoin-cli
src/bitcoin-tx
Install Binaries
bash
mkdir -p ~/Bitcoincash/bin
cp src/bitcoind src/bitcoin-cli src/bitcoin-tx ~/Bitcoincash/bin/
CKPool
bash
sudo apt-get install -y build-essential yasm libzmq3-dev
cd ckpool
./configure
make
CKStats Dashboard
Install pnpm:

bash
curl -fsSL https://get.pnpm.io/install.sh | bash
Build CKStats:

bash
cd ckstats
cp .env.example .env
pnpm install
pnpm build
pnpm start
⭐ One‑Click BCHN Build Script
This repository includes a full automated build script:

bash
bash build-bchn.sh
This script:

installs all dependencies

configures CMake

builds BCHN

installs binaries into ~/Bitcoincash/bin

⚙️ Systemd Setup (Manual Creation)
Bitcoin‑Cash Node
Code
sudo nano /etc/systemd/system/bitcoincash.service
Code
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
CKPool‑BCH
Code
sudo nano /etc/systemd/system/ckpoolbch.service
Code
[Unit]
Description=CKPool-BCH Solo Pool
After=network.target bitcoincash.service

[Service]
ExecStart=/home/umbrel/bitcoin-cash/ckpool/src/ckpool -c /home/umbrel/bitcoin-cash/ckpool/ckpool.conf
User=umbrel
Restart=always
Type=simple

[Install]
WantedBy=multi-user.target
CKStats Dashboard
Code
sudo nano /etc/systemd/system/ckstatsbch.service
Code
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
Enable and Start All Services
bash
sudo systemctl daemon-reload
sudo systemctl enable bitcoincash ckpoolbch ckstatsbch
sudo systemctl start bitcoincash ckpoolbch ckstatsbch
🔥 PM2 Setup (Alternative to Systemd)
Install PM2
bash
sudo npm install -g pm2
Bitcoin‑Cash Node
bash
pm2 start /home/umbrel/bitcoin-cash/src/bitcoind --name bitcoin-cash -- \
  -conf=/home/umbrel/bitcoin-cash/data/bitcoin.conf \
  -daemon=0
CKPool‑BCH
bash
pm2 start /home/umbrel/bitcoin-cash/ckpool/src/ckpool --name ckpool-bch -- \
  -c /home/umbrel/bitcoin-cash/ckpool/ckpool.conf
CKStats
bash
cd /home/umbrel/bitcoin-cash/ckstats
pm2 start pnpm --name ckstats-bch -- start
PM2 Persistence
bash
pm2 save
pm2 startup
🛡️ Security Notes
Never expose CKPool or BCHN RPC to the public internet

Use firewall rules

Keep .env private

Only .env.example is committed

📜 License
CKPool‑BCH: GPLv2

BCHN: MIT

CKStats: MIT

🤝 Contributing
Pull requests welcome.
Open an issue for major changes.
