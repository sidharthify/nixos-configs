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
  cat << "EOF"
# ++------------------------------------------------------------------------++
# ++------------------------------------------------------------------------++
# || ________  ___  ___  ________  ___  ___  _______   ________  ___        ||
# |||\   __  \|\  \|\  \|\   ____\|\  \|\  \|\  ___ \ |\   ___ \|\  \       ||
# ||\ \  \|\  \ \  \\\  \ \  \___|\ \  \\\  \ \   __/|\ \  \_|\ \ \  \      ||
# || \ \   ____\ \  \\\  \ \_____  \ \   __  \ \  \_|/_\ \  \ \\ \ \  \     ||
# ||  \ \  \___|\ \  \\\  \|____|\  \ \  \ \  \ \  \_|\ \ \  \_\\ \ \__\    ||
# ||   \ \__\    \ \_______\____\_\  \ \__\ \__\ \_______\ \_______\|__|    ||
# ||    \|__|     \|_______|\_________\|__|\|__|\|_______|\|_______|   ___  ||
# ||                       \|_________|                               |\__\ ||
# ||                                                                  \|__| ||
# ||                                                                        ||
# ||     ________                                                           ||
# || ___|\_____  \                                                          ||
# |||\__\|____|\ /_                                                         ||
# ||\|__|     \|\  \                                                        ||
# ||    ___  __\_\  \                                                       ||
# ||   |\__\|\_______\                                                      ||
# ||   \|__|\|_______|                                                      ||
# ||                                                                        ||
# ++------------------------------------------------------------------------++
# ++------------------------------------------------------------------------++
EOF
else
  echo "oopsies, no changes to commit :("
fi
