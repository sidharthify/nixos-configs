#!/usr/bin/env zsh
set -e

cd /etc/nixos

# rebuild
sudo nixos-rebuild switch

# commit any local changes
if [[ -n $(git status --porcelain) ]]; then
  git add .
  git commit -m "local-update: $(date '+%Y-%m-%d %H:%M:%S')"
  git push origin main
  echo "pushed!"
else
  echo "oopsies, no changes to commit :("
fi
