final: prev: {
  myLib = import ../lib/default.nix;
  star-citizen = prev.star-citizen.override {
    preCommands = ''
      export DXVK_LOG_LEVEL=debug
      export WINEDEBUG=
    '';
    inherit (final) wineprefix-preparer;
    wine = final.wine-astral;
  };
  rsi-launcher = prev.rsi-launcher.override {
      disableEac = false;
      extraEnvVars = {
        DXVK_HUD = "compiler";
        MANGO_HUD = 1;
        NVPRESENT_ENABLE_SMOOTH_MOTION = 1;
      };
      preCommands = ''
        export DXVK_LOG_LEVEL=debug
        export WINEDEBUG=
      '';
      inherit (final) wineprefix-preparer;
      wine = final.wine-astral;
    };
}
