{ config, pkgs, lib, ... }:
{
  programs.nixcord.config.plugins = {
    accountPanelServerProfile.enable = true;
    spotifyShareCommands.enable = true;
    messageClickActions.enable = true;
    gameActivityToggle.enable = true;
    showHiddenChannels.enable = true;
    permissionsViewer.enable = true;
    fixSpotifyEmbeds.enable = true;
    fixImagesQuality.enable = true;
    fixYoutubeEmbeds.enable = true;
    spotifyControls.enable = true;
    disableCallIdle.enable = true;
    friendInvites.enable = true;
    voiceDownload.enable = true;
    voiceMessages.enable = true;
    alwaysAnimate.enable = true;
    spotifyCrack.enable = true;
    memberCount.enable = true;
    validReply.enable = true;
    translate.enable = true;
    callTimer.enable = true;
    fakeNitro.enable = true;
    validUser.enable = true;
    iLoveSpam.enable = true;
    # blurNSFW.enable = true;
    messageLogger = {
      enable = true;
      deleteStyle = "overlay";
    };
  };
}
