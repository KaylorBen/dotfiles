{ config, lib, inputs, ... }:
with lib;
let cfg = config.Wotan.programs.nixcord;
in {
  options.Wotan.programs.nixcord.enable =
    mkEnableOption "Discord + Vencord config";
  imports = [ inputs.nixcord.homeManagerModules.nixcord ];
  config = mkIf cfg.enable {
    programs.nixcord = {
      enable = true;
      config = {
        themeLinks = [
          "https://raw.githubusercontent.com/rose-pine/discord/main/rose-pine.theme.css"
        ];
        frameless = true;
        disableMinSize = true;
        plugins = {
          AlwaysTrust.enabled = true;
          AnonymiseFileNames.enabled = true;
          AutomodContext.enabled = true;
          BetterFolders = {
            enabled = true;
            sidebar = true;
            sidebarAnim = false;
            closeAllFolders = true;
            closeAllHomeButton = true;
            closeOthers = true;
            forceOpen = false;
            keepIcons = false;
            showFolderIcon = 2;
          };
          BetterGifAltText.enabled = true;
          BetterGifPicker.enabled = true;
          # BetterNotesBox = {
          #   enabled = true;
          #   hide = true;
          #   noSpellCheck = true;
          # };
          BetterRoleContext.enabled = true;
          BetterRoleDot.enabled = true;
          BetterSessions.enabled = true;
          BetterSettings.enabled = true;
          BetterUploadButton.enabled = true;
          BiggerStreamPreview.enabled = true;
          BlurNSFW.enabled = true;
          CallTimer = {
            enabled = true;
            format = "human";
          };
          ClearURLs.enabled = true;
          ColorSighted.enabled = true;
          ConsoleJanitor.enabled = true;
          ConsoleShortcuts.enabled = true;
          CopyEmojiMarkdown.enabled = true;
          CopyUserURLs.enabled = true;
          CustomRPC = {
            enabled = false; # TODO
          };
          Dearrow.enabled = true;
          Decor.enabled = true;
          DisableCallIdle.enabled = true;
          DontRoundMyTimestamps.enabled = true;
          EmoteCloner.enabled = true;
          Experiments = {
            enabled = true;
            toolbarDevMenu = true;
          };
          F8Break.enabled = true;
          FakeProfileThemes.enabled = true;
          FavoriteEmojiFirst.enabled = true;
          FavoriteGifSearch.enabled = true;
          FixCodeblockGap.enabled = true;
          FixSpotifyEmbeds.enabled = true;
          FixYoutubeEmbeds.enabled = true;
          ForceOwnerCrown.enabled = true;
          FriendInvites.enabled = true;
          FriendsSince.enabled = true;
          GameActivityToggle.enabled = true;
          GifPaste.enabled = true;
          GreetStickerPicker.enabled = true;
          HideAttachments.enabled = true;
          iLoveSpam.enabled = true;
          ImageLink.enabled = true;
          ImageZoom = {
            enabled = true;
            nearestNeighbour = true;
          };
          ImplicitRelationships.enabled = true;
          InvisibleChat.enabled = true;
          KeepCurrentChannel.enabled = true;
          MaskedLinkPaste.enabled = true;
          MemberCount.enabled = true;
          MentionAvatars.enabled = true;
          MessageClickActions = {
            enabled = true;
            enableDoubleClickToEdit = false;
            enableDoubleClickToReply = false;
          };
          MessageLatency = {
            enabled = true;
            latency = 4;
          };
          MessageLinkEmbeds.enabled = true;
          MessageLogger.enabled = true;
          MessageTags.enabled = true;
          MoreCommands.enabled = true;
          MoreKaomoji.enabled = true;
          MoreUserTags.enabled = true;
          MutualGroupDMs.enabled = true;
          NewGuildSettings = {
            enabled = true;
            messages = 1;
            role = false;
          };
          NoBlockedMessages.enabled = true;
          NoDefaultHangStatus.enabled = true;
          NoDevtoolsWarning.enabled = true;
          NoF1.enabled = true;
          NoMosaic.enabled = true;
          NoOnboardingDelay.enabled = true;
          NoPendingCount.enabled = true;
          NoScreensharePreview.enabled = true;
          NoTypingAnimation.enabled = true;
          NoUnblockToJump.enabled = true;
          NormalizeMessageLinks.enabled = true;
          NSFWGateBypass.enabled = true;
          OpenInApp.enabled = true;
          OverrideForumDefaults.enabled = true;
          PermissionFreeWill.enabled = true;
          PermissionsViewer.enabled = true;
          petpet.enabled = true;
          PictureInPicture.enabled = true;
          PinDMs.enabled = true;
          PlatformIndicators.enabled = true;
          PreviewMessage.enabled = true;
          QuickMention.enabled = true;
          QuickReply.enabled = true;
          ReactErrorDecoder.enabled = true;
          ReadAllNotificationsButton.enabled = true;
          RelationshipNotifier.enabled = true;
          ReplaceGoogleSearch.enabled = true;
          ReplyTimestamp.enabled = true;
          RevealAllSpoilers.enabled = true;
          ReverseImageSearch.enabled = true;
          RoleColorEverywhere.enabled = true;
          SearchReply.enabled = true;
          Summaries.enabled = true;
          SendTimestamps.enabled = true;
          ServerInfo.enabled = true;
          ServerListIndicators = {
            enabled = true;
            mode = 3;
          };
          ShikiCodeblocks.enabled = true;
          ShowAllMessageButtons.enabled = true;
          ShowAllRoles.enabled = true;
          ShowConnections.enabled = true;
          ShowHiddenChannels = {
            enabled = true;
            showMode = 1;
          };
          ShowHiddenThings.enabled = true;
          ShowTimeoutDuration.enabled = true;
          SilentMessageToggle.enabled = true;
          SortFriendRequests.enabled = true;
          SpotifyControls.enabled = true;
          SpotifyCrack.enabled = true;
          SpotifyShareCommands.enabled = true;
          StartupTimings.enabled = true;
          StreamerModeOnStream.enabled = true;
          ThemeAttributes.enabled = true;
          TimeBarAllActivities.enabled = true;
          Translate.enabled = true;
          TypingIndicator.enabled = true;
          TypingTweaks.enabled = true;
          Unindent.enabled = true;
          UnlockedAvatarZoom.enabled = true;
          UnsuppressEmbeds.enabled = true;
          UserVoiceShow.enabled = true;
          ValidReply.enabled = true;
          ValidUser.enabled = true;
          VoiceChatDoubleClick.enabled = true;
          VencordToolbox.enabled = true;
          ViewIcons.enabled = true;
          ViewRaw.enabled = true;
          VoiceDownload.enabled = true;
          VoiceMessages.enabled = true;
          WatchTogetherAdblock.enabled = true;
        };
      };
    };
  };
}
