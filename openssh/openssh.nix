{ config, pkgs, ... }:  

{
  services.openssh = {
  enable = true;
  permitRootLogin = "no";
  passwordAuthentication = true;
};
}
