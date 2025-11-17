{ config, pkgs, ... }:

{
  systemd.user.services.orca = {
    enable = false;
    unitConfig = {
      ConditionPathExists = "/dev/null";
    };
  };
}
