# zsh.nix

{ config, pkgs, ... }:

{
  programs.zsh = {
  enable = true;
  enableCompletion = true;
  autosuggestions.enable = true;
  syntaxHighlighting.enable = true;

  shellAliases = {
    ll = "ls -l";
    fuckoff = "shutdown now";
    mic-loopback = "pw-loopback --capture-props=node.name=MicLoopback --playback-props=node.target=51";  
};

  histSize = 10000;

interactiveShellInit = ''
  # setfanspeed
  setfanspeed() {
    if [[ -z $1 ]]; then
      echo "usage: setfanspeed <0-100>"
      return 1
    fi

    if ! [[ $1 =~ ^[0-9]+$ ]] || (( $1 < 0 || $1 > 100 )); then
      echo "fan speed must be an integer between 0 and 100"
      return 1
    fi

    echo "setting GPU fan speed to $1%"
    sudo DISPLAY=$DISPLAY XAUTHORITY=$XAUTHORITY nvidia-settings -a GPUFanControlState=1 -a GPUTargetFanSpeed=$1
  }

 # syncnix
 syncnix() {
 /etc/nixos/scripts/sync-nixos.sh "$@"
 }
'';
  };

}
