### nixos-configs
This is my personal /etc/nixos directory 

The main configuration lies in configuration.nix 

### sync-nixos.sh?
The file basically pushes changes whenever I rebuild nixos. I did this so I don't have to manually edit this repository. Feel free to copy it and use it as an executable if you'd like!

### why have a repo for just your configs?
It's simple. It's so that I can come back to my system anytime I want. And since this is NixOS, the system configuration runs on a few text files and so they are easily reproducable.

If I brick my installation, get a new PC, or if anything happens which forces me to reinstall my system. I can clone this repository and just have a working system :)
