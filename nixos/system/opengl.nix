{ config, pkgs, ... }: 

{
  hardware.graphics = {
  enable = true;
  extraPackages = with pkgs; [
    vulkan-loader
    vulkan-validation-layers
    vulkan-tools
  ];

  extraPackages32 = with pkgs.pkgsi686Linux; [
    vulkan-loader
  ];
};
}
