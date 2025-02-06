#!/usr/bin/env bash

# initializing wallpaper daemon
swww init &

# networkmanagerapplet
nm-applet --indicator &

# waybar
waybar &

# mako
mako
