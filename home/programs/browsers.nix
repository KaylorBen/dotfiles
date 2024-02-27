{pkgs, inputs, ...}:
{
  programs.firefox = {
    enable = true;
    profiles.ben = {
      name = "ben";
      search = {
        default = "DuckDuckGo";
        privateDefault = "DuckDuckGo";
        engines = {
          "Nix Packages" = {
            urls = [{
              template = "https://search.nixos.org/packages";
              params = [
                { name = "type"; value = "packages"; }
                { name = "query"; value = "{searchTerms}"; }
              ];
            }];

            icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            definedAliases = [ "@np" ];
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
        ublock-origin
        sponsorblock
        darkreader
        vimium
        firenvim
      ];
      settings = {
        "browser.startup.homepage" = "https://nixos.org";
        "browser.newtabpage.pinned" = [{
          title = "NixOS";
          url = "https://nixos.org";
        }];
      };
      userChrome = ''
        :root {
          --sfwindow: #19171a;
          --sfsecondary: #201e21;
        }
        .urlbarView {
          display: none !important;
        }
        :root {
          --toolbar-bgcolor: var(--sfsecondary) !important;
          --tabs-border-color: var(--sfsecondary) !important;
          --lwt-sidebar-background-color: var(--sfwindow) !important;
          --lwt-toolbar-field-focus: var(--sfsecondary) !important;
        }
        .tab-close-button {
          display: none;
        }
        .tabbrowser-tab:not([pinned]) .tab-icon-image {
          display: none !important;
        }
        :root {
          --toolbarbutton-border-radius: 0 !important;
          --tab-border-radius: 0 !important;
          --tab-block-margin: 0 !important;
        }
        .tab-background {
          border-right: 0px solid rgba(0, 0, 0, 0) !important;
          margin-left: -4px !important;
        }
        .tabbrowser-tab:is([visuallyselected='true'], [multiselected])
          > .tab-stack
          > .tab-background {
          box-shadow: none !important;
        }
        .tabbrowser-tab[last-visible-tab='true'] {
          padding-inline-end: 0 !important;
        }
        .bookmark-item .toolbarbutton-icon {
          display: none;
        }
        toolbarbutton.bookmark-item:not(.subviewbutton) {
          min-width: 1.6em;
        }
        .tab-secondary-label {
          display: none !important;
        }
        .urlbarView-url {
          color: #dedede !important;
        }
      '';
      userContent = ''
        :root {
          scrollbar-width: none !important;
        }
        @-moz-document url(about:privatebrowsing) {
          :root {
            scrollbar-width: none !important;
          }
        }
      '';
    };
  };
}
