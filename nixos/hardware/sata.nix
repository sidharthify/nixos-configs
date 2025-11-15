# sata.nix

{ config, pkgs, ... }:  

{
  fileSystems."/mnt/sda1" = {
  device = "/dev/sda1";
  fsType = "btrfs";
  options = [ "defaults" ];
  };
}
