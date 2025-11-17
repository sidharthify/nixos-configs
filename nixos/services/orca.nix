{ config, pkgs, ... }:

{
  systemd.user.services.orca = {
    enable = false;
    unitConfig = {
      ConditionPathExists = "/dev/null";
    };
  };

services.orca.enable = false;
services.speechd.enable = false;

}
