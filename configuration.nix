
{ config, pkgs, lib, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix 
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  
  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;
  networking.interfaces.wlp3s0.useDHCP = false;
  networking.resolvconf.enable = false;
  networking.nameservers = [ "192.168.1.1" ];
  networking.interfaces."wlp3s0".mtu = 1458;
  networking.firewall.allowedTCPPorts = [ 25565 ];

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

  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true; 
  services.desktopManager.plasma6.enable = true; 

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.sidharthify = {
    isNormalUser = true;
    description = "sidharthify";
    shell = pkgs.zsh;
    extraGroups = [ "networkmanager" "wheel" "libvirtd"];
    packages = with pkgs; [
      kdePackages.kate
    #  thunderbird
    ];
  };

  # Install firefox.
  programs.firefox.enable = false;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    alacritty
    vim 
    sudo
    sof-firmware
    wget
    neofetch
    git
    vesktop
    telegram-desktop
    python3Full
    hyfetch
    libnotify
    font-awesome
    stow
    nwg-look
    lutris-unwrapped
    wineWowPackages.stable
    killall 
    pywal    
    unzip
    unrar
    catppuccin-gtk
    protonup-qt
    obs-studio
    mangohud
    w3m
    imagemagick
    networkmanager
    networkmanager_dmenu
    picom
    gh
    mgba
    rpcs3
    haruna
    tenacity
    gamescope
    qbittorrent
    dxvk
    vkd3d
    vulkan-tools
    gtk3
    protonvpn-gui
    lm_sensors
    hexyl
    gnome-themes-extra
    zenity
    osu-lazer
    quota
    ani-cli
    drawpile
    mtr-gui
    android-tools
    apktool
    util-linux
    xorg.libX11
    xorg.libXft
    xorg.libXrender
    xorg.libXext
    gcc
    libgcc
    glib
    nss
    fontconfig
    expat
    dbus
    alsa-lib
    pango
    atk
    at-spi2-core
    steam-run
    nss
    fastfetch
    vscodium
    anydesk
    easyeffects
    lsp-plugins
    tmate-ssh-server
    tmate
    pipx
    brave
    blueman
    p7zip
    pavucontrol
    file
    erofs-utils
    edid-decode
    scrcpy
    prismlauncher
    glfw
    glew
    libGL
    libglvnd
    libGLU
    pacman
    xkeyboard_config
    glfw-wayland-minecraft
    spicetify-cli
    zip
    spotify-player
    jdk21
    floorp
    git-repo
    gnumake
    coreutils
    autoconf
    automake
    axel
    bc
    bison
    ccache
    winetricks
    ripgrep    
    openssl
    meld
    git-lfs
    yt-dlp
    vinegar
    rustdesk-flutter
    apple-cursor
    neovim
    binwalk
    tinyxxd
    ghidra
    nodejs_23
];

  # Enable the OpenSSH daemon.
   services.openssh.enable = true;

  system.stateVersion = "24.11"; # Did you read the comment?

# Enable OpenGL
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

  # Load nvidia driver for Xorg and Wayland
  services.xserver.videoDrivers = ["nvidia"];

  hardware.nvidia = {

    # Modesetting is required.
    modesetting.enable = true;

    # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
    # Enable this if you have graphical corruption issues or application crashes after waking
    # up from sleep. This fixes it by saving the entire VRAM memory to /tmp/ instead 
    # of just the bare essentials.
    powerManagement.enable = false;

    # Fine-grained power management. Turns off GPU when not in use.
    # Experimental and only works on modern Nvidia GPUs (Turing or newer).
    powerManagement.finegrained = false;

    # Use the NVidia open source kernel module (not to be confused with the
    # independent third-party "nouveau" open source driver).
    # Support is limited to the Turing and later architectures. Full list of 
    # supported GPUs is at: 
    # https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus 
    # Only available from driver 515.43.04+
    # Currently alpha-quality/buggy, so false is currently the recommended setting.
    open = false;

    # Enable the Nvidia settings menu,
	# accessible via `nvidia-settings`.
    nvidiaSettings = true;

    # Optionally, you may need to select the appropriate driver version for your specific GPU.
    package = pkgs.linuxPackages.nvidia_x11.overrideAttrs (oldAttrs: {
   version = "550.144.03";
   src = pkgs.fetchurl {
    url = "https://in.download.nvidia.com/XFree86/Linux-x86_64/550.144.03/NVIDIA-Linux-x86_64-550.144.03.run";
    sha256 = "6a4838e2cdb26e4c0e07367ac0d3bcf799d56b5286f68fa201be3d3ddb88aac4";
   };
});  
};

# Load snd_hda_intel
boot.kernelModules = [ "snd_hda_intel" ];

# Load snd-hda-codec-realtek
boot.extraModprobeConfig = ''
 options snd-hda-intel model=snd-hda-codec-realtek
'';

# Enable Bluetooth
hardware.bluetooth.enable = true;
hardware.bluetooth.powerOnBoot = true;
hardware.bluetooth.settings = {
  General = { Experimental = true; };
};

# Adding user to audio group
users.extraUsers.sidharthify = {

  extraGroups = [ "audio" ];
};

# Steam
programs.steam = {
  enable = true;
  remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
  dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
};

# XDG portal
xdg.portal.enable = true;
xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
xdg.portal.xdgOpenUsePortal = true;
services.dbus.enable = true;

# Flakes
nix.settings.experimental-features = [ "nix-command" "flakes" ];

# running discord with wayland
  environment.variables = {
    VESKTOP_USE_WAYLAND = "1";
    NATIVE_WAYLAND = "1";
  };

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

# kde partition manager
programs.partition-manager.enable = true;

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

# zsh (with the 'setfanspeed' function)
programs.zsh = {
  enable = true;
  enableCompletion = true;
  autosuggestions.enable = true;
  syntaxHighlighting.enable = true;

  shellAliases = {
    ll = "ls -l";
    update = "sudo nixos-rebuild switch";  
};

  histSize = 10000;

  interactiveShellInit = ''
    setfanspeed() {
      if [[ -z $1 ]]; then
        echo "❌ usage: setfanspeed <0-100>"
        return 1
      fi

      if ! [[ $1 =~ ^[0-9]+$ ]] || (( $1 < 0 || $1 > 100 )); then
        echo "❌ fan speed must be an integer between 0 and 100"
        return 1
      fi

      echo "🌬️ setting GPU fan speed to $1%"
      sudo DISPLAY=$DISPLAY XAUTHORITY=$XAUTHORITY nvidia-settings -a GPUFanControlState=1 -a GPUTargetFanSpeed=$1
    }
    
    syncnix() {
      sudo /usr/bin/nixos-rebuild-sync "$@"
    }
  '';
};

}
