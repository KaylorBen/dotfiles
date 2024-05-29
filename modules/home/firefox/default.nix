{ config, lib, pkgs, inputs, ... }:
with lib;
let cfg = config.Wotan.programs.firefox;
in {
  options.Wotan.programs.firefox.enable =
    mkEnableOption "A web browser built from Firefox source tree";

    config = mkIf cfg.enable {
      programs.firefox = {
        enable = true;
        policies = {
          DisableAppUpdate = true;
          DisableTelemetry = true;
        };
        profiles.ben = {
          name = "ben";
          search = {
            default = "DuckDuckGo";
            engines = {
              "Brave Search" = {
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
            return-youtube-dislikes
            sponsorblock
            stylus
            ublock-origin
            vimium
          ];
          settings = {
            "browser.startup.homepage" = "https://nixos.org";
            "browser.newtabpage.pinned" = [{
              title = "NixOS";
              url = "https://nixos.org";
            }];
          };
          userChrome = ''
            /*
             * This theme uses code from
             * - https://github.com/JarnotMaciej/Essence
            */ 

            /* Navbar size calc stuff */
            :root{
            --tab-border-radius: 6px !important; /*  Tab border radius -- Changes the tabs rounding  *//*  Default: 6px  */
            --NavbarWidth: 43; /*  Default values: 36 - 43  */
            --TabsHeight: 36; /*  Minimum: 30  *//*  Default: 36  */
            --TabsBorder: 8; /*  Doesnt do anything on small layout  *//*  Default: 8  */
            --NavbarHeightSmall: calc(var(--TabsHeight) + var(--TabsBorder))  /*  Only on small layout  *//*  Default: calc(var(--TabsHeight) + var(--TabsBorder))  *//*  Default as a number: 44  */}

            @media screen and (min-width:1325px)    /*  Only the tabs space will grow from here  */
            {:root #nav-bar{margin-top: calc(var(--TabsHeight) * -1px - var(--TabsBorder) * 1px)!important; height: calc(var(--TabsHeight) * 1px + var(--TabsBorder) * 1px)} #TabsToolbar{margin-left: calc(1325px / 100 * var(--NavbarWidth)) !important} #nav-bar{margin-right: calc(100vw - calc(1325px / 100 * var(--NavbarWidth))) !important; vertical-align: center !important} #urlbar-container{min-width: 0px !important;  flex: auto !important} toolbarspring{display: none !important}}

            @media screen and (min-width:950px) and (max-width:1324px)    /*  Both the tabs space and the navbar will grow  */
            {:root #nav-bar{margin-top: calc(var(--TabsHeight) * -1px - var(--TabsBorder) * 1px) !important; height: calc(var(--TabsHeight) * 1px + var(--TabsBorder) * 1px)} #TabsToolbar{margin-left: calc(var(--NavbarWidth) * 1vw) !important} #nav-bar{margin-right: calc(100vw - calc(var(--NavbarWidth) * 1vw)) !important; vertical-align: center !important} #urlbar-container{min-width: 0px !important;  flex: auto !important} toolbarspring{display: none !important} #TabsToolbar, #nav-bar{transition: margin-top .25s !important}}

            @media screen and (max-width:949px)    /*  The window is not enough wide for a one line layout  */
            {:root #nav-bar{padding: 0 5px 0 5px!important; height: calc(var(--NavbarHeightSmall) * 1px) !important} toolbarspring{display: none !important;} #TabsToolbar, #nav-bar{transition: margin-top .25s !important}}
            #nav-bar, #PersonalToolbar{background-color: #0000 !important;background-image: none !important; box-shadow: none !important} #nav-bar{margin-left: 3px;} .tab-background, .tab-stack { min-height: calc(var(--TabsHeight) * 1px) !important}

            /* Remove close window button*/
            .titlebar-buttonbox-container{
              display:none !important
            }

            /* Removes foward/back buttons */
            #back-button, #forward-button {
              display: none !important
            }

            /* Turning this off for now */
            /* Remove extensions button */
            /* #unified-extensions-button { */
            /*   display: none !important */
            /* } */

            /* Remove icons from urlbar */ 
            /* #identity-permission-box
            */
            #star-button-box,
            #alltabs-button,
            #identity-icon-box,
            #picture-in-picture-button,
            #tracking-protection-icon-container,
            #reader-mode-button,
            #translations-button {
              display: none !important
            }

            /* Hide Extension Name in the identity area */
            #identity-box.extensionPage #identity-icon-label {
              visibility: collapse !important
            }

            /* Panel/menu position */
            #PanelUI-button {
              -moz-box-ordinal-group: 0 !important;
              order: -2 !important;
              margin: 2px !important;
            }

            /* Fades window while not in focus */
            #navigator-toolbox-background:-moz-window-inactive {
              filter: contrast(90%)
            }

            /*  Removes urlbar border/background  */
            #urlbar-background {
              border: none !important;
              outline: none !important;
              transition: .15s !important;
            }

            /* Remove "This time search with:..." */
            #urlbar .search-one-offs {
              display: none !important
            }

            /* Remove fullscreen warning border */
            #fullscreen-warning {
              border: none !important;
              background: -moz-Dialog !important;
            }

            /*  X-button on the tabs  */
            .tabbrowser-tab:not(:hover) .tab-close-button {
                opacity: 0% !important;
                transition: 0.3s !important;
                display: -moz-box !important;
            }
            .tab-close-button[selected]:not(:hover) {
                opacity: 45% !important;
                transition: 0.3s !important;
                display: -moz-box !important;
            }
            .tabbrowser-tab:hover .tab-close-button {
                opacity: 50%;
                transition: 0.3s !important;
                background: none !important;
                cursor: pointer;
                display: -moz-box !important;
            }
            .tab-close-button:hover {
                opacity: 100% !important;
                transition: 0.3s !important;
                background: none !important;
                cursor: pointer;
                display: -moz-box !important;
            }
            .tab-close-button[selected]:hover {
                opacity: 100% !important;
                transition: 0.3s !important;
                background: none !important;
                cursor: pointer;
                display: -moz-box !important;
            }

            /*  Removes annoying border  */
            #navigator-toolbox {
                border: none !important
            }

            /*  Removes the background from the urlbar while not in use  */
            #urlbar:not(:hover):not([breakout][breakout-extend]) > #urlbar-background {
                box-shadow: none !important;
                background: #0000 !important;
            }
          '';
        };
      };
    };
}
