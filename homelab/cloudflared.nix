# cloudflared.nix

{ config, pkgs, ... }:

{

services.cloudflared = {
  enable = true;
  
  tunnels.multi = {
    credentialsFile = "/var/lib/cloudflared/multi.json";
    default = "http_status:404";
    ingress = {
      "music.sidharthify.me" = "http://localhost:4533";
      "nicotine.sidharthify.me" = "http://localhost:6080";
    };
  };
};

}
