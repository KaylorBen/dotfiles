{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.Wotan.chinese-lang;
  inherit (lib)
    mkEnableOption
    mkIf
    ;
in
{
  options.Wotan.chinese-lang.enable = mkEnableOption "Chinese language keyboard support through fcitx5";

  config = mkIf cfg.enable {
    i18n = {
      inputMethod = {
        type = "fcitx5";
        enable = true;
        fcitx5.addons = with pkgs; [
          fcitx5-gtk
          fcitx5-chinese-addons
          fcitx5-tokyonight
        ];
      };
    };
  };
}
