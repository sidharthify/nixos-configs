 { config, pkgs, ... }:  

{ 
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelParams = [ "nvidia-modeset.hdmi_deepcolor=0" "nvidia.NVreg_EnableGpuFirmware=0" "nvidia_drm.fbdev=1" "nvidia_drm.modeset=1"];
}
