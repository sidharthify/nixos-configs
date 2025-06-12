# intel.nix

{ config, pkgs, ... }:  
 
{
  boot.kernelModules = [ "snd_hda_intel" ];
 
  boot.extraModprobeConfig = ''
  options snd-hda-intel model=snd-hda-codec-realtek
  '';
}
