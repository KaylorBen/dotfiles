{ config, lib, ... }:
with lib;
let cfg = config.Wotan.programs.chromium;
in {
  options.Wotan.programs.chromium.enable = mkEnableOption "Chromium Browser";

  config = mkIf cfg.enable {
    programs.chromium = {
      enable = true;
      extensions = [
        { id = "cjpalhdlnbpafiamejdnhcphjbkeiagm"; } # Ublock Origin
        { id = "eimadpbcbfnmbkopoojfekhnkhdbieeh"; } # Dark Reader
        { id = "dbepggeogbaibhgnhhndojpepiihcmeb"; } # Vimium
        { id = "mnjggcdmjocbbbhaepdhchncahnbgone"; } # SponsorBlock
        { id = "lckanjgmijmafbedllaakclkaicjfmnk"; } # ClearURLs
      ];
    };
  };
}
