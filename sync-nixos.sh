#!/usr/bin/env zsh
set -e

cd /etc/nixos

# pull latest changes (as your user)
git pull origin main

# rebuild with new config (needs root)
sudo nixos-rebuild switch

# commit any local changes (as your user)
if [[ -n $(git status --porcelain) ]]; then
  git add .
  git commit -m "local update: $(date '+%Y-%m-%d %H:%M:%S')"
  git push origin main
  echo "✅ /etc/nixos changes pushed."
else
  echo "🟢 no changes to commit."
fi
