{
  config,
  lib,
  ...
}:
let
  cfg = config.Wotan.programs.qutebrowser;
  inherit (lib)
    mkEnableOption
    mkIf;
in {
  options.Wotan.programs.qutebrowser.enable = mkEnableOption "Vim Browser";

  config = mkIf cfg.enable {
    programs.qutebrowser = {
      enable = true;
      settings = {
        colors.webpage.darkmode.enabled = true;
      };
      searchEngines = {
        w = "https://en.wikipedia.org/wiki/Special:Search?search={}&go=Go&ns0=1";
        aw = "https://wiki.archlinux.org/?search={}";
        nw = "https://wiki.nixos.org/index.php?search={}";
        np = "https://search.nixos.org/packages?channel=unstable&from=0&size=50&sort=relevance&type=packages&query={}";
        no = "https://search.nixos.org/options?channel=unstable&from=0&size=50&sort=relevance&type=packages&query={}";
        g = "https://www.google.com/search?hl=en&q={}";
      };
    };
  };
}
