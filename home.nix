{ config, pkgs, spicetify-nix, ... }:

{

  imports = [
    spicetify-nix.homeManagerModules.spicetify
  ];

  home.stateVersion = "25.05";

  # Vencord (Nixcord)
  programs.nixcord = {
    enable = true;
    config = {
      useQuickCss = true; 
      themeLinks = [
        "https://raw.githubusercontent.com/refact0r/midnight-discord/refs/heads/master/themes/flavors/midnight-catppuccin-mocha.theme.css"
      ];
plugins = {
  hideAttachments.enable = true;
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
  emoteCloner.enable = true;
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
  pronounDB.enable = true;
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
};
  };
};

  # Spicetify (spicetify-nix)
  programs.spicetify = {
    enable = true;
    theme = spicetify-nix.legacyPackages.${pkgs.system}.themes.catppuccin;
    colorScheme = "mocha";
    enabledExtensions = with spicetify-nix.legacyPackages.${pkgs.system}.extensions; [
      fullAppDisplay
      shuffle
      adblock
      bookmark
      songStats
      history
      lastfm
      copyLyrics
      volumePercentage
      beautifulLyrics
      betterGenres
      copyToClipboard
    ];
  };
}
