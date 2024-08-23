{ config, lib, inputs, ... }:
with lib;
let cfg = config.Wotan.programs.nixcord;
in {
  options.Wotan.programs.nixcord.enable =
    mkEnableOption "Discord + Vencord config";

  imports = [ inputs.nixcord.homeManagerModules.nixcord ];
  config = mkIf cfg.enable {
    services.arrpc.enable = true;
    programs.nixcord = {
      enable = true;
      vesktop.enable = true;
      config = {
        themeLinks = [
          "https://raw.githubusercontent.com/rose-pine/discord/main/rose-pine.theme.css"
        ];
        frameless = true;
        disableMinSize = true;
        plugins = {
          alwaysTrust.enable = true;
          anonymiseFileNames.enable = true;
          automodContext.enable = true;
          betterFolders = {
            enable = true;
            sidebar = true;
            sidebarAnim = false;
            closeAllFolders = true;
            closeAllHomeButton = true;
            closeOthers = true;
            forceOpen = false;
            keepIcons = false;
            showFolderIcon = "moreThanOne";
          };
          betterGifAltText.enable = true;
          betterGifPicker.enable = true;
          betterNotesBox.enable = true;
          # BetterNotesBox = {
          #   enable = true;
          #   hide = true;
          #   noSpellCheck = true;
          # };
          betterRoleContext.enable = true;
          betterRoleDot.enable = true;
          betterSessions.enable = true;
          betterSettings.enable = true;
          betterUploadButton.enable = true;
          biggerStreamPreview.enable = true;
          blurNSFW.enable = true;
          callTimer = {
            enable = true;
            format = "human";
          };
          clearURLs.enable = true;
          colorSighted.enable = true;
          consoleJanitor.enable = true;
          consoleShortcuts.enable = true;
          copyEmojiMarkdown.enable = true;
          copyUserURLs.enable = true;
          customRPC = {
            enable = false; # TODO
          };
          dearrow.enable = true;
          decor.enable = true;
          disableCallIdle.enable = true;
          dontRoundMyTimestamps.enable = true;
          emoteCloner.enable = true;
          experiments = {
            enable = true;
            toolbarDevMenu = true;
          };
          f8Break.enable = true;
          fakeProfileThemes.enable = true;
          favoriteEmojiFirst.enable = true;
          favoriteGifSearch.enable = true;
          fixCodeblockGap.enable = true;
          fixSpotifyEmbeds.enable = true;
          fixYoutubeEmbeds.enable = true;
          forceOwnerCrown.enable = true;
          friendInvites.enable = true;
          friendsSince.enable = true;
          gameActivityToggle.enable = true;
          gifPaste.enable = true;
          greetStickerPicker.enable = true;
          hideAttachments.enable = true;
          iLoveSpam.enable = true;
          imageLink.enable = true;
          imageZoom = {
            enable = true;
            nearestNeighbour = true;
          };
          implicitRelationships.enable = true;
          invisibleChat.enable = true;
          keepCurrentChannel.enable = true;
          memberCount.enable = true;
          mentionAvatars.enable = true;
          messageClickActions = {
            enable = true;
            enableDoubleClickToEdit = false;
            enableDoubleClickToReply = false;
          };
          messageLatency = {
            enable = true;
            latency = 4;
          };
          messageLinkEmbeds.enable = true;
          messageLogger.enable = true;
          messageTags.enable = true;
          moreCommands.enable = true;
          moreKaomoji.enable = true;
          moreUserTags.enable = true;
          mutualGroupDMs.enable = true;
          newGuildSettings = {
            enable = true;
            messages = "only@Mentions";
            role = false;
          };
          noBlockedMessages.enable = true;
          noDefaultHangStatus.enable = true;
          noDevtoolsWarning.enable = true;
          noF1.enable = true;
          noMosaic.enable = true;
          noOnboardingDelay.enable = true;
          noPendingCount.enable = true;
          noScreensharePreview.enable = true;
          noTypingAnimation.enable = true;
          noUnblockToJump.enable = true;
          normalizeMessageLinks.enable = true;
          nsfwGateBypass.enable = true;
          openInApp.enable = true;
          overrideForumDefaults.enable = true;
          permissionFreeWill.enable = true;
          permissionsViewer.enable = true;
          petpet.enable = true;
          pictureInPicture.enable = true;
          pinDMs.enable = true;
          platformIndicators.enable = true;
          previewMessage.enable = true;
          quickMention.enable = true;
          quickReply.enable = true;
          reactErrorDecoder.enable = true;
          readAllNotificationsButton.enable = true;
          relationshipNotifier.enable = true;
          replaceGoogleSearch.enable = true;
          replyTimestamp.enable = true;
          revealAllSpoilers.enable = true;
          reverseImageSearch.enable = true;
          roleColorEverywhere.enable = true;
          searchReply.enable = true;
          summaries.enable = true;
          sendTimestamps.enable = true;
          serverInfo.enable = true;
          serverListIndicators = {
            enable = true;
            mode = "both";
          };
          shikiCodeblocks.enable = true;
          showAllMessageButtons.enable = true;
          showAllRoles.enable = true;
          showConnections.enable = true;
          showHiddenChannels = {
            enable = true;
            showMode = "muted";
          };
          showHiddenThings.enable = true;
          showTimeoutDuration.enable = true;
          silentMessageToggle.enable = true;
          sortFriendRequests.enable = true;
          spotifyControls.enable = true;
          spotifyCrack.enable = true;
          spotifyShareCommands.enable = true;
          startupTimings.enable = true;
          streamerModeOnStream.enable = true;
          themeAttributes.enable = true;
          timeBarAllActivities.enable = true;
          translate.enable = true;
          typingIndicator.enable = true;
          typingTweaks.enable = true;
          unindent.enable = true;
          unlockedAvatarZoom.enable = true;
          unsuppressEmbeds.enable = true;
          userVoiceShow.enable = true;
          validReply.enable = true;
          validUser.enable = true;
          voiceChatDoubleClick.enable = true;
          vencordToolbox.enable = true;
          viewIcons.enable = true;
          viewRaw.enable = true;
          voiceDownload.enable = true;
          voiceMessages.enable = true;
          volumeBooster.enable = true;
          youtubeAdblock.enable = true;
        };
      };
      vesktopConfig = {
        plugins = {
          webKeybinds.enable = true;
          webRichPresence.enable = true;
          webScreenShareFixes.enable = true;
        };
      };
      extraConfig = {
        plugins = {
          betterActivities.enable = true;
          blockKrisp.enable = true;
          ignoreTerms.enable = true;
          serverProfilesToolbox.enable = true;
          voiceChatUtilities.enable = true;
        };
      };
      userPlugins = {
        betterActivities = "github:D3SOX/vc-betterActivities/044b504666b8b753ab45d82c0cd0d316b1ea7e60";
        blockKrisp = "github:D3SOX/vc-blockKrisp/91964150e5ba42e45bf4bc514c2616abe7cdca53";
        ignoreTerms = "github:D3SOX/vc-ignoreTerms/7e63e599e7f8918dda6b4ec4c2ea1a6f6e1879e2";
        serverProfilesToolbox = "github:D3SOX/vc-serverProfilesToolbox/3178aed3dbf8f95dce439d2fa97bdd4d997bc2f3";
        voiceChatUtilities = "github:D3SOX/vc-voiceChatUtilities/251a18a0e4afed197cebe6bfaac9b534c243d094";
      };
    };
  };
}
