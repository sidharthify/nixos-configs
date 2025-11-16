{ config, pkgs, spicetify-nix, ... }:

let
  spicePkgs = spicetify-nix.legacyPackages.${pkgs.system};
in

{
  imports = [
    spicetify-nix.homeManagerModules.spicetify
  ];

  home.stateVersion = "25.11";

  # Spicetify (spicetify-nix)
  programs.spicetify = {
    enable = true;
    theme = spicePkgs.themes.catppuccin;
    colorScheme = "mocha";
    enabledCustomApps = with spicePkgs.apps; [
      lyricsPlus
      reddit
      marketplace
    ];
    enabledExtensions = with spicePkgs.extensions; [
      adblockify
      hidePodcasts
      shuffle
      betterGenres
      simpleBeautifulLyrics
    ];
    experimentalFeatures = true;
    alwaysEnableDevTools = true;
  };

  # VSCodium  
  programs.vscode = {
  enable = true;
  package = pkgs.vscodium;
  mutableExtensionsDir = true;
  profiles.default = {
    extensions = with pkgs.vscode-extensions; [
      catppuccin.catppuccin-vsc
      dbaeumer.vscode-eslint
      esbenp.prettier-vscode
      ritwickdey.liveserver
      eamodio.gitlens
      formulahendry.auto-rename-tag
      formulahendry.auto-close-tag
      ms-python.python
      ms-python.vscode-pylance
      ms-toolsai.jupyter
      ms-toolsai.jupyter-keymap
      ms-toolsai.jupyter-renderers
      ms-toolsai.vscode-jupyter-cell-tags
      ms-toolsai.vscode-jupyter-slideshow
      ms-vscode.cmake-tools
      twxs.cmake
      rust-lang.rust-analyzer
      serayuzgur.crates
      tamasfe.even-better-toml
      streetsidesoftware.code-spell-checker
      pkief.material-icon-theme
    ];
    userSettings = {
      "workbench.colorTheme" = "Catppuccin Mocha";
      "workbench.iconTheme" = "material-icon-theme";
    };
  };
};
}
