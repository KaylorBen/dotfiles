{ config, lib, pkgs, inputs, ... }:
{
  options.Wotan.programs.firefox.enable =
    lib.mkEnableOption "A web browser built from Firefox source tree";

    config = lib.mkIf config.Wotan.programs.firefox.enable {
      programs.firefox = {
        enable = true;
        policies = {
          DisableAppUpdate = true;
          DisableTelemetry = true;
        };
        profiles.ben = {
          name = "ben";
          search = {
            default = "Brave Search";
            engines = {
              "Brave Search" = {
                name = "Brave Search";
                url = "https://search.brave.com/search?q={searchTerms}";
                icon = "https://search.brave.com/favicon.ico";
                definedAliases = [ "@bs" ];
              };
              "Nix Packages" = {
                urls = [{
                  template = "https://search.nixos.org/packages?channel=unstable";
                  params = [
                    { name = "type"; value = "packages"; }
                    { name = "query"; value = "{searchTerms}"; }
                  ];
                }];

                icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
                definedAliases = [ "@np" ];
              };
              "Nix Options" = {
                urls = [{
                  template = "https://search.nixos.org/options?channel=unstable";
                  params = [
                    { name = "type"; value = "packages"; }
                    { name = "query"; value = "{searchTerms}"; }
                  ];
                }];

                icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
                definedAliases = [ "@no" ];
              };
              "Nix Flakes" = {
                urls = [{
                  template = "https://search.nixos.org/flakes?channel=unstable";
                  params = [
                    { name = "type"; value = "packages"; }
                    { name = "query"; value = "{searchTerms}"; }
                  ];
                }];

                icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
                definedAliases = [ "@nf" ];
              };

              "NixOS Wiki" = {
                urls = [{ template = "https://nixos.wiki/index.php?search={searchTerms}"; }];
                iconUpdateURL = "https://nixos.wiki/favicon.png";
                updateInterval = 24 * 60 * 60 * 1000; # every day
                definedAliases = [ "@nw" ];
              };
            };
            force = true;
          };
          extensions = with inputs.firefox-addons.packages."x86_64-linux"; [
            auto-tab-discard
            darkreader
            dearrow
            firenvim
            sponsorblock
            vimium
            ublock-origin
          ];
          settings = {
            "browser.startup.homepage" = "https://nixos.org";
            "browser.newtabpage.pinned" = [{
              title = "NixOS";
              url = "https://nixos.org";
            }];
          };
        };
      };
    };
}
