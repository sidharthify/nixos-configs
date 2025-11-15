{ config, pkgs, ... }:

{
  services.zerotierone = {
    enable = true;
    joinNetworks = [
      "8850338390d46d0b"
      "8850338390eb9eaa"
    ];
  };
}
