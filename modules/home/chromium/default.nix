{ config, lib, ... }:
{
  options.Wotan.programs.chromium.enable = lib.mkEnableOption "Chromium Browser";

  config = lib.mkIf config.Wotan.programs.chromium.enable {
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
