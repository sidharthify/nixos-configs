{ config, pkgs, lib, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./homelab/docker-containers.nix
    ./homelab/cloudflared.nix
    ./zsh/zsh.nix
    ./zerotier/zerotier-config.nix
    ./steam/steam.nix
    ./hardware/nvidia.nix
    ./hardware/bluetooth.nix
    ./hardware/sata.nix
    ./hardware/intel.nix
    ./bootloader/bootloader.nix
    ./kernel/kernel.nix
    ./openssh/openssh.nix
    ./pipewire/pipewire.nix
    ./networking/networking.nix
    ./opengl/opengl.nix
    ./xdg-portal/xdg-portal.nix
  ];

  environment.systemPackages = import ./packages/packages.nix pkgs;
  system.stateVersion = "25.11";

  # Set your time zone.
  time.timeZone = "Asia/Kolkata";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_IN";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_IN";
    LC_IDENTIFICATION = "en_IN";
    LC_MEASUREMENT = "en_IN";
    LC_MONETARY = "en_IN";
    LC_NAME = "en_IN";
    LC_NUMERIC = "en_IN";
    LC_PAPER = "en_IN";
    LC_TELEPHONE = "en_IN";
    LC_TIME = "en_IN";
  };

  programs.ssh.askPassword = lib.mkForce "${pkgs.kdePackages.ksshaskpass}/bin/ksshaskpass";

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    displayManager.sddm.enable = true;
    desktopManager.plasma6.enable = true;
    desktopManager.cinnamon.enable = true;
    desktopManager.gnome.enable = false;
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Define a user account.
  users.users.sidharthify = {
    isNormalUser = true;
    description = "sidharthify";
    shell = pkgs.zsh;
    extraGroups = [ "networkmanager" "wheel" "libvirtd" "dialout" "docker" ];
    packages = with pkgs; [
      kdePackages.kate
    ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Fonts
  fonts.packages = with pkgs; [
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
  ];

  # Adding user to audio group
  users.extraUsers.sidharthify = {
    extraGroups = [ "audio" ];
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # gamemode
  programs.gamemode.enable = true;

  # qemu/kvm
  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;

  # flatpaks
  services.flatpak.enable = true;

  # coolercontrol
  programs.coolercontrol.enable = true;
  programs.coolercontrol.nvidiaSupport = true;

  # waydroid
  virtualisation.waydroid.enable = true;

  # tmate
  services.tmate-ssh-server.enable = true;

  # docker
  virtualisation.docker.enable = true;

  # zram
  zramSwap.enable = true;
  zramSwap.memoryPercent = 100;
  zramSwap.priority = 100;

  # firewall
  networking.firewall.enable = false;

  # kde-connect
  programs.kdeconnect.enable = true;

  # security.sudo
  security.sudo.enable = true;
  nix.settings.trusted-users = [ "root" "sidharthify" ];

  # nix-ld
  programs.nix-ld.enable = true;

  # openrgb
  services.hardware.openrgb.enable = true;


  # auto updates
  system.autoUpgrade.enable = true;
  system.autoUpgrade.allowReboot = true;

}
