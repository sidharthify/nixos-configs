{ config, pkgs, ... }: 

{
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  xdg.portal.xdgOpenUsePortal = true;
  services.dbus.enable = true;
}
