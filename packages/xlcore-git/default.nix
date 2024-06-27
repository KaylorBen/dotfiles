{ lib
, pkgs
, useSteamRun ? true }:
let
  rev = "bc5e8008305790fc28623b1223c58872d010ef60";
in
  pkgs.buildDotnetModule rec {
    pname = "XIVLauncher";
    version = rev;

    src = pkgs.fetchFromGitHub {
      owner = "goatcorp";
      repo = "XIVLauncher.Core";
      inherit rev;
      hash = lib.fakeSha256;
      fetchSubmodules = true;
    };

    nativeBuildInputs = with pkgs; [ copyDesktopItems makeWrapper ];

    buildInputs = with pkgs.gst_all_1; [ gstreamer gst-plugins-base gst-plugins-good gst-plugins-bad gst-plugins-ugly gst-libav ];

    projectFile = "src/XIVLauncher.Core/XIVLauncher.Core.csproj";
    nugetDeps = ./deps.nix; # File generated with `nix-build -A xivlauncher.passthru.fetch-deps`

    dotnetFlags = [
      "-p:BuildHash=${rev}"
      "-p:PublishSingleFile=false"
    ];

    postPatch = ''
      substituteInPlace lib/FFXIVQuickLauncher/src/XIVLauncher.Common/Game/Patch/Acquisition/Aria/AriaHttpPatchAcquisition.cs \
        --replace 'ariaPath = "aria2c"' 'ariaPath = "${pkgs.aria2}/bin/aria2c"'
    '';

    postInstall = ''
      mkdir -p $out/share/pixmaps
      cp src/XIVLauncher.Core/Resources/logo.png $out/share/pixmaps/xivlauncher.png
    '';

    postFixup = lib.optionalString useSteamRun (let
      steam-run = (pkgs.steam.override {
        extraPkgs = pkgs: [ pkgs.libunwind ];
        extraProfile = ''
          unset TZ
        '';
      }).run;
    in ''
      substituteInPlace $out/bin/XIVLauncher.Core \
        --replace 'exec' 'exec ${steam-run}/bin/steam-run'
    '') + ''
      wrapProgram $out/bin/XIVLauncher.Core --prefix GST_PLUGIN_SYSTEM_PATH_1_0 ":" "$GST_PLUGIN_SYSTEM_PATH_1_0"
      # the reference to aria2 gets mangled as UTF-16LE and isn't detectable by nix: https://github.com/NixOS/nixpkgs/issues/220065
      mkdir -p $out/nix-support
      echo ${pkgs.aria2} >> $out/nix-support/depends
    '';

    executables = [ "XIVLauncher.Core" ];

    runtimeDeps = with pkgs; [ SDL2 libsecret glib gnutls ];

    desktopItems = [
      (pkgs.makeDesktopItem {
        name = "xivlauncher";
        exec = "XIVLauncher.Core";
        icon = "xivlauncher";
        desktopName = "XIVLauncher";
        comment = meta.description;
        categories = [ "Game" ];
        startupWMClass = "XIVLauncher.Core";
      })
    ];

    meta = with lib; {
      description = "Custom launcher for FFXIV";
      homepage = "https://github.com/goatcorp/XIVLauncher.Core";
      license = licenses.gpl3;
      maintainers = with maintainers; [ sersorrel witchof0x20 ];
      platforms = [ "x86_64-linux" ];
      mainProgram = "XIVLauncher.Core";
    };
  }
