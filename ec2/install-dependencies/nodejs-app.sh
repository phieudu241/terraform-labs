#!/bin/bash
sudo apt install -y curl
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
sudo apt install -y nodejs
npm install --global yarn
npm install --global pm2
sudo apt install -y unzip
