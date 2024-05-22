{ config, lib, ... }:
let cfg = config.Wotan.programs.chromium;
in {
  options.Wotan.programs.chromium.enable = lib.mkEnableOption "Chromium Browser";

  config = lib.mkIf cfg.enable {
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
