{ config, pkgs, spicetify-nix, ... }:

let
  spicePkgs = spicetify-nix.legacyPackages.${pkgs.system};
in

{
  imports = [
    spicetify-nix.homeManagerModules.spicetify
  ];

  home.stateVersion = "25.11";

  # Vencord (Nixcord)
  programs.nixcord = {
    enable = true;
    config = {
      useQuickCss = true;
      themeLinks = [
        "https://raw.githubusercontent.com/sidharthify/midnight-discord/refs/heads/master/themes/flavors/midnight-catppuccin-mocha.theme.css"
      ];
      plugins = {
        accountPanelServerProfile.enable = true;
        alwaysAnimate.enable = true;
        alwaysExpandRoles.enable = true;
        betterGifPicker.enable = true;
        betterRoleContext.enable = true;
        betterRoleDot.enable = true;
        betterSessions.enable = true;
        betterSettings.enable = true;
        betterUploadButton.enable = true;
        biggerStreamPreview.enable = true;
        blurNSFW.enable = true;
        callTimer.enable = true;
        clientTheme.enable = true;
        copyEmojiMarkdown.enable = true;
        copyFileContents.enable = true;
        copyUserURLs.enable = true;
        customRPC.enable = true;
        disableCallIdle.enable = true;
        dontRoundMyTimestamps.enable = true;
        experiments.enable = true;
        fakeNitro.enable = true;
        favoriteEmojiFirst.enable = true;
        favoriteGifSearch.enable = true;
        fixCodeblockGap.enable = true;
        fixImagesQuality.enable = true;
        fixSpotifyEmbeds.enable = true;
        fixYoutubeEmbeds.enable = true;
        forceOwnerCrown.enable = true;
        friendInvites.enable = true;
        friendsSince.enable = true;
        whoReacted.enable = true;
        volumeBooster.enable = true;
        voiceDownload.enable = true;
        voiceMessages.enable = true;
        viewRaw.enable = true;
        viewIcons.enable = true;
        vencordToolbox.enable = true;
        validUser.enable = true;
        validReply.enable = true;
        typingTweaks.enable = true;
        typingIndicator.enable = true;
        translate.enable = true;
        silentTyping.enable = true;
        showHiddenChannels.enable = true;
        serverInfo.enable = true;
        summaries.enable = true;
        roleColorEverywhere.enable = true;
        reverseImageSearch.enable = true;
        relationshipNotifier.enable = true;
        quickReply.enable = true;
        platformIndicators.enable = true;
        noBlockedMessages.enable = true;
        moreUserTags.enable = true;
        messageLogger.enable = true;
        memberCount.enable = true;
        lastFMRichPresence.enable = true;
        implicitRelationships.enable = true;
        imageZoom.enable = true;
        imageLink.enable = true;
        spotifyShareCommands.enable = true;
        spotifyCrack.enable = true;
        stickerPaste.enable = true;
        streamerModeOnStream.enable = true;
        textReplace.enable = true;
        unlockedAvatarZoom.enable = true;
        voiceChatDoubleClick.enable = true;
        showHiddenThings.enable = true;
        showConnections.enable = true;
        pinDMs.enable = true;
        permissionsViewer.enable = true;
        permissionFreeWill.enable = true;
        pauseInvitesForever.enable = true;
        onePingPerDM.enable = true;
        mutualGroupDMs.enable = true;
        shikiCodeblocks.enable = true;
        spotifyControls.enable = true;
      };
    };
  };

  # Spicetify (spicetify-nix)
  programs.spicetify = {
    enable = true;
    theme = spicePkgs.themes.catppuccin;
    #colorScheme = "custom";
    #customColorScheme = {
      #text = "cdd6f4";
      #subtext = "bac2de";
      #extratext = "a6adc8";
      #main = "1e1e2e";
      #sidebar = "181825";
      #player = "11111b";
      #sec-player = "313244";
      #card = "45475a";
      #sec-card = "585b70";
      #shadow = "000000";
      #selected-row = "585b70";
      #button = "89b4fa";
      #button-active = "b4befe";
      #button-disabled = "6c7086";
      #tab-active = "f38ba8";
      #notification = "94e2d5";
      #notification-error = "f38ba8";
      #misc = "f9e2af";
    #};
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
