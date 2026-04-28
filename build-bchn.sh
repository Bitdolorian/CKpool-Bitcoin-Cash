#!/bin/bash
set -e

echo "=== Updating system and installing dependencies ==="
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
  libgmp-dev \
  python3 \
  git

echo "=== Entering BCHN source directory ==="
cd ~/CKpool-Bitcoin-Cash

# Check if bitcoin-cash or bitcoin-cash-node directory exists
if [ -d "bitcoin-cash" ]; then
    cd bitcoin-cash
elif [ -d "bitcoin-cash-node" ]; then
    cd bitcoin-cash-node
else
    echo "ERROR: Could not find bitcoin-cash or bitcoin-cash-node directory!"
    ls -la
    exit 1
fi

echo "=== Creating fresh build directory ==="
rm -rf build
mkdir build
cd build

echo "=== Configuring BCHN with safe flags (no GUI, no tests, no packaging issues) ==="
cmake -GNinja .. \
  -DBUILD_BITCOIN_QT=OFF \
  -DBUILD_BITCOIN_WALLET=OFF \
  -DBUILD_BITCOIN_TESTS=OFF \
  -DBUILD_PACKAGE=OFF \
  -DENABLE_QRCODE=OFF \
  -DCMAKE_POLICY_DEFAULT_CMP0167=OLD

echo "=== Building BCHN (this may take 30-90 minutes) ==="
ninja

echo "=== Installing binaries to ~/Bitcoincash/bin ==="
mkdir -p ~/Bitcoincash/bin
cp src/bitcoind src/bitcoin-cli src/bitcoin-tx ~/Bitcoincash/bin/ 2>/dev/null || true

# Also copy to /usr/local/bin for easier access (optional but convenient)
sudo cp src/bitcoind src/bitcoin-cli src/bitcoin-tx /usr/local/bin/ 2>/dev/null || true

echo "=== Build complete! ==="
echo "Binaries installed to: ~/Bitcoincash/bin"
echo "Also available system-wide in /usr/local/bin"
echo ""
echo "Next steps:"
echo "1. Create data directory: mkdir -p ~/Bitcoincash/data"
echo "2. Create config: nano ~/.bitcoin/bitcoin.conf   (or ~/Bitcoincash/data/bitcoin.conf)"
echo "3. Start node: ~/Bitcoincash/bin/bitcoind -daemon -datadir=~/Bitcoincash/data"
