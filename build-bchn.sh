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
  python3

echo "=== Entering BCHN source directory ==="
cd CKpool-Bitcoin-Cash/bitcoin-cash

echo "=== Creating build directory ==="
rm -rf build
mkdir build
cd build

echo "=== Configuring BCHN with CMake ==="
cmake -GNinja ..

echo "=== Building BCHN (bitcoind, bitcoin-cli, bitcoin-tx) ==="
ninja

echo "=== Installing binaries to ~/Bitcoincash/bin ==="
mkdir -p ~/Bitcoincash/bin
cp src/bitcoind src/bitcoin-cli src/bitcoin-tx ~/Bitcoincash/bin/

echo "=== Build complete ==="
echo "Binaries installed to: ~/Bitcoincash/bin"
echo "Run your node with:"
echo "~/Bitcoincash/bin/bitcoind -datadir=~/Bitcoincash/data"
