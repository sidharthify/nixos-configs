### nixos-configs
This is my personal /etc/nixos directory 

### Modular Setup! (13 June 2025)
I've just made these configs modular, which means configuration.nix is way smaller and there's a folder for everything that DOESN'T necessarily need to be in one configuration file.
for example, 
/hardware has NVIDIA drivers, some Intel related kernel modules, a config to mount my SATA drive in /mnt/sda1/ and bluetooth configs.
