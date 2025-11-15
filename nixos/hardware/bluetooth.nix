# bluetooth.nix

{ config, pkgs, ... }:  

{
  hardware.bluetooth.powerOnBoot = true;
  hardware.bluetooth.settings = {
  General = { Experimental = true; };
};
}
