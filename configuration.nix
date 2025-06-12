
{ config, pkgs, lib, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix 
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  
  # Kernel
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelParams = [ "nvidia-modeset.hdmi_deepcolor=0" "nvidia.NVreg_EnableGpuFirmware=0" ];

  # Networking
  networking.hostName = "nixos"; # Define your hostname.
  networking.networkmanager.enable = true;
  networking.interfaces.wlp3s0.useDHCP = false;
  networking.interfaces."wlp3s0".ipv4.addresses = [{
  address = "192.168.1.184";
  prefixLength = 24;
  }];
  networking.defaultGateway = "192.168.1.1";
  networking.resolvconf.enable = false;
  networking.nameservers = [ "192.168.1.1" ];
  networking.interfaces."wlp3s0".mtu = 1500;
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
  };

  # Define a user account.
  users.users.sidharthify = {
    isNormalUser = true;
    description = "sidharthify";
    shell = pkgs.zsh;
    extraGroups = [ "networkmanager" "wheel" "libvirtd" "dialout" "docker"];
    packages = with pkgs; [
      kdePackages.kate
    #  thunderbird
    ];
  };

  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile.
  environment.systemPackages = with pkgs; [
    vim 
    sudo
    sof-firmware
    wget
    neofetch
    git
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
    zenity
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
    zip
    jdk21
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
    bfg-repo-cleaner
    clang-tools
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    ghostty
    direnv
    rustc
    python312Packages.pip
    interception-tools
    kew
    arduino-ide
    busybox
    arduino-cli
    platformio
    element-desktop
    cloudflared
];

  # Fonts
  fonts.packages = with pkgs; [
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
];

  # Enable the OpenSSH daemon.
  services.openssh = {
  enable = true;
  permitRootLogin = "no";
  passwordAuthentication = true;
};

  system.stateVersion = "24.11";

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

  # NVIDIA Drivers
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
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
  remotePlay.openFirewall = true;
  dedicatedServer.openFirewall = true;
  localNetworkGameTransfers.openFirewall = true;
};

  # XDG portal
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  xdg.portal.xdgOpenUsePortal = true;
  services.dbus.enable = true;

  # Flakes
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

  # kde partition manager
  programs.partition-manager.enable = true;

  # tmate
  services.tmate-ssh-server.enable = true;

  # docker
  virtualisation.docker.enable = true;
 
  # declarative navidrome container
  virtualisation.oci-containers = {
    backend = "docker";
    containers.navidrome = {
      image = "deluan/navidrome:latest";
      user = "1000:1000";
      ports = [ "127.0.0.1:4533:4533" ];
      volumes = [
        "/mnt/sda1/music:/music:ro"
        "/mnt/sda1/navidrome:/data"
      ];
      environment = {
        ND_LOGLEVEL = "info";
        ND_SCANINTERVAL = "1h";
        ND_MUSICFOLDER = "/music";
      };
    };
  };

  # declarative nicotineplus container
  virtualisation.oci-containers = {
  containers = {
    nicotine-plus = {
      image = "ghcr.io/fletchto99/nicotine-plus-docker:latest";
      extraOptions = [ "--security-opt" "seccomp=unconfined" ]; # optional
      environment = {
        PUID = "1000";
        PGID = "1000";
        TZ = "Asia/Kolkata";
        PASSWORD = "sidpid098";
      };
      volumes = [
        "/mnt/sda1/nicotineplus:/config"
        "/mnt/sda1/music:/data/downloads"
        "/mnt/sda1/music:/data/incomplete_downloads"
      ];
      ports = [
        "127.0.0.1:6080:6080"
        "127.0.0.1:2234-2239:2234-2239"
      ];
    };
  };
};
 
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
    update = "syncnix switch";  
    edit = "sudo nvim /etc/nixos/configuration.nix";
    edit-flake = "sudo nvim /etc/nixos/flake.nix";
    edit-home = "sudo nvim /etc/nixos/home.nix";
    mic-loopback = "pw-loopback --capture-props=node.name=MicLoopback --playback-props=node.target=52";  
};

  histSize = 10000;

  interactiveShellInit = ''
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
    
    syncnix() {
      sudo /usr/bin/nixos-rebuild-sync "$@"
    }
  '';
  };

  # zerotier
  services.zerotierone = {
  enable = true;
  joinNetworks = [
  "8850338390d46d0b"
  "8850338390eb9eaa"
    ];
  };

  # SATA
  fileSystems."/mnt/sda1" = {
  device = "/dev/sda1";
  fsType = "btrfs";
  options = [ "defaults" ];
  };

# Cloudflared
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
