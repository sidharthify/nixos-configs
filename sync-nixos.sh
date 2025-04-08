#!/usr/bin/env zsh
set -e

cd /etc/nixos

# pull latest changes
sudo git pull origin main

# rebuild with the new config
sudo nixos-rebuild switch

# add + commit any local changes (optional)
sudo git add .
sudo git commit -m "local update: $(date '+%Y-%m-%d %H:%M:%S')" || true

# push to GitHub
sudo git push origin main || true
