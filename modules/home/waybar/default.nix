{ lib, config, pkgs, osConfig, ... }:
{
  options.Wotan.programs.waybar.enable = lib.mkEnableOption "Waybar";

  config = lib.mkIf config.Wotan.programs.waybar.enable {
    programs.waybar = {
      package = pkgs.waybar.overrideAttrs (prev: {
        mesonFlags = (prev.mesonFlags or [ ]) ++ [ "-Dexperimental=true" ];
      });
      enable = true;
      systemd.enable = true;
      settings = {
        main-bar = {
          layer = "top";
          position = "top";
          modules-left = [ "hyprland/workspaces" ];
          modules-center = [ "clock" "idle_inhibitor" ];
          modules-right = [
            "mpris"
            "tray"
            "gamemode"
            "pulseaudio"
            "temperature"
            "battery"
            "network"
            "custom/power"
          ];
          network = {
            format-wifi = "{essid}({signal_strength}%) ";
            format-ethernet = "{ifname} ";
            format-disconnected = "";
            max-length = 50;
            on-click =
              "${pkgs.wezterm}/bin/wezterm -e ${pkgs.networkmanager}/bin/nmtui";
          };
          idle_inhibitor = {
            format = "{icon}";
            format-icons = {
              activated = "";
              deactivated = "";
            };
            # TODO: Set this lol
            on-click = "";
          };
          tray = {
            icon-size = 15;
            spacing = 5;
          };
          clock = {
            timezone = if builtins.hasAttr "time" osConfig then
              osConfig.time.timeZone
            else
              "US/Mountain";
            format = "{:%H:%M:%S} ";
            tooltip-format = ''
              <big>{:%Y %b}</big>
              <tt><small>{calander}</small></tt>'';
            interval = 1;
          };
          cpu = {
            format = "{usage}% ";
            tooltip = false;
            interval = 15;
          };
          memory = {
            format = "{}% ";
            tooltip = false;
            interval = 15;
          };
          battery = {
            states = {
              good = 95;
              warning = 20;
              critical = 10;
            };
            format = "{capacity}% {icon}";
            format-charging = "{capacity}% ";
            format-plugged = "{capacity}% ";
            format-alt = "{time} {icon}";
            format-full = "";
            format-icons = [ "" "" "" "" "" ];
          };
          pulseaudio = {
            format = "{volume}% {icon}";
            format-bluetooth = "{volume}% {icon} {format_source}";
            # prepend muted icon at front
            format-bluetooth-muted = "!{icon} {format_source}";
            format-muted = "0% {icon}";
            format-source = "{volume}% ";
            format-source-muted = "";
            format-icons = {
              headphone = "";
              hands-free = "";
              headset = "";
              phone = "";
              portable = "";
              car = "";
              default = [ "" "" "" ];
            };
            on-click = "${pkgs.pavucontrol}/bin/pavucontrol";
          };
          mpris = {
            format = "{player_icon} ({status}) {dynamic}";
            format-paused = "{player_icon} {status_icon} <i>{dynamic}</i>";
            player-icons = {
              spotify = "";
              chromium = "";
              firefox = "";
              vlc = "";
              default = "";
            };
            ignored-players = [ "firefox" "chromium" ];
            status-icons = {
              playing = "";
              paused = "";
              stopped = "";
            };
            interval = 1;
          };
          "custom/power" = {
            format = "";
            on-click = let
              power-menu = pkgs.writeScript "wofi-powermenu.sh" ''
                entries="⇠ Logout\n⏾ Suspend\n⭮ Reboot\n⭮ Firmware \n⏻ Shutdown"
                selected=$(echo -e $entries|${pkgs.wofi}/bin/wofi --width 250 --height 210 --dmenu --cache-file /dev/null | awk '{print tolower($2)}')

                case $selected in
                  logout)
                    hyprctl dispatch exit;;
                  suspend)
                    exec systemctl suspend;;
                  reboot)
                    exec systemctl reboot;;
                  firmware)
                    exec systemctl reboot --firmware-setup;;
                  shutdown)
                    exec systemctl poweroff -i;;
                esac
              '';
            in "${power-menu}";
          };
        };
      };
      style = with config.colorScheme.palette;
        ''
          * {
            border: none;
            font-family: Font Awesome, Monocraft Nerd Font, FreeSans, FreeSerif;
            font-size: 14;
            color: #ffffff;
            border-radius: 20px;
          }

          window {
            font-weight: bold;
          }

          window#waybar {
            background: rgba(0, 0, 0, 0);
          }

          .modules-right {
            background-color: ${style.base00};
            margin: 2px 10px 0 0;
          }

          .modules-center {
            background-color: ${style.base00};
            margin: 2px 0 0 0;
          }
          .modules-left {
            background-color: ${style.base04};
            margin: 2px 0 0 5px;
          }

          #workspaces button {
            padding: 1px 5px;
            background-color: transparent;
          }

          /* TODO: Style these */
          #workspaces button:hover {
            box-shadow: inherit;
            background-color: rgba(0,153,153,1);
          }

          #workspaces button.active {
            background-color: rgba(0,43,51,0.85);
          }

          #clock,
          #battery,
          #cpu,
          #memory,
          #temperature,
          #network,
          #pulseaudio,
          #custom-power,
          #idle_inhibitor {
            padding: 0 10px;
          }
          #custom-power {
              background-color: rgba(0,119,179,0.6);
              border-radius: 50px;
              margin: 5px 5px;
              padding: 1px 3px;
          }
          # Catppuccinix these too
          /*-----Indicators----*/
          #idle_inhibitor.activated {
              color: #2dcc36;
          }
          #pulseaudio.muted {
              color: #cc3436;
          }
          #battery.charging {
              color: #2dcc36;
          }
          #battery.warning:not(.charging) {
            color: #e6e600;
          }
          #battery.critical:not(.charging) {
              color: #cc3436;
          }
          #temperature.critical {
              color: #cc3436;
          }
        '';
    };
  };
}
