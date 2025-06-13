#!/usr/bin/env zsh
set -e

cd /etc/nixos || exit 1

# run nixos-rebuild, bail if it fails
if ! sudo nixos-rebuild switch --impure; then
  echo "nixos-rebuild failed. not committing."
  exit 1
fi

# commit & push if there are changes
if [[ -n $(git status --porcelain) ]]; then
  sudo git add .
  sudo git commit -m "local-update: $(date '+%Y-%m-%d %H:%M:%S')"
  sudo git push origin main
  echo "pushed!"
else
  echo "no changes to commit."
fi
