{
  config,
  lib,
  pkgs,
  osConfig,
  ...
}:
let
  inherit (lib)
    mkOption
    mkIf
    types
    ;
  cfg = config.Wotan.desktop.sway;
in
{
  options.Wotan.desktop.sway = {
    enable = mkOption {
      type = types.bool;
      description = "sway";
      default = osConfig.Wotan.desktop.sway.enable or false;
    };
    extraSettings = mkOption {
      type = types.attrs;
      default =
        if builtins.hasAttr "Wotan" osConfig then osConfig.Wotan.desktop.sway.extraSettings else { };
    };
  };

  config = mkIf cfg.enable {
    home.file.".config/rofi/config.rasi".source = ../hyprland/rose-pine.rasi;
    home.packages = with pkgs; [
      rofi
      wofi
      grimblast
      networkmanager
      wl-clipboard
      wl-clipboard-x11
      wlr-randr
    ];

    Wotan.programs.eww.enable = true;

    services.mako.enable = true;

    # Wotan.programs.${cfg.bar}.enable = true;

    wayland.windowManager.sway = {
      enable = true;
      package = pkgs.swayfx;
      checkConfig = false;
      config = {
        bars = [ ];

        input = {
          "type:keyboard" = {
            xkb_layout = "us,us(3l)";
            xkb_options = "grp:ralt_rshift_toggle,caps:escape";
          };
        };

        gaps = {
          outer = 5;
          inner = 8;
        };

        keybindings =
          let
            modifier = "Mod4";
            cmd-screenshot = pkgs.writeShellScriptBin "cmd-screenshot" ''
              OUTPUT_DIR="$HOME/Pictures"

              if [[ ! -d "$OUTPUT_DIR" ]]; then
                ${pkgs.libnotify}/bin/notify-send "Screenshot directory does not exist: $OUTPUT_DIR" -u critical -t 3000
                exit 1
              fi

              pkill slurp || ${pkgs.hyprshot}/bin/hyprshot -m ''${1:-region} --raw |
                ${pkgs.satty}/bin/satty --filename - \
                  --output-filename "$OUTPUT_DIR/screenshot-$(date +'%Y-%m-%d_%H-%M-%S').png" \
                  --early-exit \
                  --actions-on-enter save-to-clipboard \
                  --save-after-copy \
                  --copy-command 'wl-copy'
            '';
            cmd-screenrecord = pkgs.writeShellScriptBin "cmd-screenrecord" ''
              OUTPUT_DIR="$HOME/Videos"

              if [[ ! -d "$OUTPUT_DIR" ]]; then
                ${pkgs.libnotify}/bin/notify-send "Screen recording directory does not exist: $OUTPUT_DIR" -u critical -t 3000
                exit 1
              fi

              SCOPE="$1"

              AUDIO=$([[ $2 == "audio" ]] && echo "--audio")

              start_screenrecording() {
                local filename="$OUTPUT_DIR/screenrecording-$(date +'%Y-%m-%d_%H-%M-%S').mp4"

                if ${pkgs.pciutils}/bin/lspci | grep -qi 'nvidia'; then
                  ${pkgs.wf-recorder}/bin/wf-recorder $AUDIO -f "$filename" -c libx264 -p crf=23 -p preset=medium -p movflags=+faststart "$@" &
                else
                  ${pkgs.wl-screenrec}/bin/wl-screenrec $AUDIO -f "$filename" --ffmpeg-encoder-options="-c:v libx264 -crf 23 -preset medium -movflags +faststart" "$@" &
                fi

                toggle_screenrecording_indicator
              }

              stop_screenrecording() {
                pkill -x wl-screnrec
                pkill -x wf-recorder

                ${pkgs.libnotify}/bin/notify-send "Screen recording saved to $OUTPUT_DIR" -t 2000

                sleep 0.2
                toggle_screenrecording_indicator
              }

              toggle_screenrecording_indicator() {
                pkill -RTMIN+8 waybar
              }

              screenrecording_active() {
                pgrep -x wl-screenrec > /dev/null || pgrep -x wf-recorder > /dev/null
              }

              if screenrecording_active; then
                stop_screenrecording
              elif [[ "$SCOPE" == "output" ]]; then
                output=$(${pkgs.slurp}/bin/slurp -o) || exit 1
                start_screenrecording -g "$output"
              else
                region=$(${pkgs.slurp}/bin/slurp) || exit 1
                start_screenrecording -g "$region"
              fi
            '';
          in
          lib.mkOptionDefault {
            "${modifier}+Return" = "exec ${pkgs.alacritty}/bin/alacritty";
            "${modifier}+Shift+Return" = "exec ${pkgs.alacritty}/bin/alacritty --class='termfloat'";

            "${modifier}+1" = "exec ${pkgs.swaysome}/bin/swaysome focus 1";
            "${modifier}+2" = "exec ${pkgs.swaysome}/bin/swaysome focus 2";
            "${modifier}+3" = "exec ${pkgs.swaysome}/bin/swaysome focus 3";
            "${modifier}+4" = "exec ${pkgs.swaysome}/bin/swaysome focus 4";
            "${modifier}+5" = "exec ${pkgs.swaysome}/bin/swaysome focus 5";
            "${modifier}+6" = "exec ${pkgs.swaysome}/bin/swaysome focus 6";
            "${modifier}+7" = "exec ${pkgs.swaysome}/bin/swaysome focus 7";
            "${modifier}+8" = "exec ${pkgs.swaysome}/bin/swaysome focus 8";
            "${modifier}+9" = "exec ${pkgs.swaysome}/bin/swaysome focus 9";
            "${modifier}+0" = "exec ${pkgs.swaysome}/bin/swaysome focus 0";

            "${modifier}+Shift+1" = "exec ${pkgs.swaysome}/bin/swaysome move 1";
            "${modifier}+Shift+2" = "exec ${pkgs.swaysome}/bin/swaysome move 2";
            "${modifier}+Shift+3" = "exec ${pkgs.swaysome}/bin/swaysome move 3";
            "${modifier}+Shift+4" = "exec ${pkgs.swaysome}/bin/swaysome move 4";
            "${modifier}+Shift+5" = "exec ${pkgs.swaysome}/bin/swaysome move 5";
            "${modifier}+Shift+6" = "exec ${pkgs.swaysome}/bin/swaysome move 6";
            "${modifier}+Shift+7" = "exec ${pkgs.swaysome}/bin/swaysome move 7";
            "${modifier}+Shift+8" = "exec ${pkgs.swaysome}/bin/swaysome move 8";
            "${modifier}+Shift+9" = "exec ${pkgs.swaysome}/bin/swaysome move 9";
            "${modifier}+Shift+0" = "exec ${pkgs.swaysome}/bin/swaysome move 0";

            "${modifier}+Alt+1" = "exec ${pkgs.swaysome}/bin/swaysome focus-group 1";
            "${modifier}+Alt+2" = "exec ${pkgs.swaysome}/bin/swaysome focus-group 2";
            "${modifier}+Alt+3" = "exec ${pkgs.swaysome}/bin/swaysome focus-group 3";
            "${modifier}+Alt+4" = "exec ${pkgs.swaysome}/bin/swaysome focus-group 4";
            "${modifier}+Alt+5" = "exec ${pkgs.swaysome}/bin/swaysome focus-group 5";
            "${modifier}+Alt+6" = "exec ${pkgs.swaysome}/bin/swaysome focus-group 6";
            "${modifier}+Alt+7" = "exec ${pkgs.swaysome}/bin/swaysome focus-group 7";
            "${modifier}+Alt+8" = "exec ${pkgs.swaysome}/bin/swaysome focus-group 8";
            "${modifier}+Alt+9" = "exec ${pkgs.swaysome}/bin/swaysome focus-group 9";
            "${modifier}+Alt+0" = "exec ${pkgs.swaysome}/bin/swaysome focus-group 0";

            "${modifier}+Alt+Shift+1" = "exec ${pkgs.swaysome}/bin/swaysome move-to-group 1";
            "${modifier}+Alt+Shift+2" = "exec ${pkgs.swaysome}/bin/swaysome move-to-group 2";
            "${modifier}+Alt+Shift+3" = "exec ${pkgs.swaysome}/bin/swaysome move-to-group 3";
            "${modifier}+Alt+Shift+4" = "exec ${pkgs.swaysome}/bin/swaysome move-to-group 4";
            "${modifier}+Alt+Shift+5" = "exec ${pkgs.swaysome}/bin/swaysome move-to-group 5";
            "${modifier}+Alt+Shift+6" = "exec ${pkgs.swaysome}/bin/swaysome move-to-group 6";
            "${modifier}+Alt+Shift+7" = "exec ${pkgs.swaysome}/bin/swaysome move-to-group 7";
            "${modifier}+Alt+Shift+8" = "exec ${pkgs.swaysome}/bin/swaysome move-to-group 8";
            "${modifier}+Alt+Shift+9" = "exec ${pkgs.swaysome}/bin/swaysome move-to-group 9";
            "${modifier}+Alt+Shift+0" = "exec ${pkgs.swaysome}/bin/swaysome move-to-group 0";

            "${modifier}+o" = "exec ${pkgs.swaysome}/bin/swaysome next-output";
            "${modifier}+Shift+o" = "exec ${pkgs.swaysome}/bin/swaysome prev-output";

            "${modifier}+Alt+o" = "exec ${pkgs.swaysome}/bin/swaysome workspace-group-next-output";
            "${modifier}+Alt+Shift+o" = "exec ${pkgs.swaysome}/bin/swaysome workspace-group-prev-output";

            "Print" = "exec ${cmd-screenshot}/bin/cmd-screenshot";
            "Shift+Print" = "exec ${cmd-screenshot}/bin/cmd-screenshot window";
            "Ctrl+Print" = "exec ${cmd-screenshot}/bin/cmd-screenshot output";

            "Alt+Print" = "exec ${cmd-screenrecord}/bin/cmd-screenrecord region";
            "Alt+Shift+Print" = "exec ${cmd-screenrecord}/bin/cmd-screenrecord region audio";
            "Alt+Ctrl+Print" = "exec ${cmd-screenrecord}/bin/cmd-screenrecord output";
            "Alt+Shift+Ctrl+Print" = "exec ${cmd-screenrecord}/bin/cmd-screenrecord output audio";
          };

        window = {
          border = 3;
          titlebar = false;
        };

        startup = [
          { command = "${pkgs.swaysome}/bin/swaysome init 1"; }
          {
            command = "${pkgs.eww}/bin/eww daemon";
            always = true;
          }
          {
            command = "${pkgs.writeShellScriptBin "eww-sway-updater" ''
              ${pkgs.swayfx}/bin/swaymsg -m -t subscribe '[ "workspace" ]' | stdbuf -oL ${pkgs.jq}/bin/jq -r '
                select(.change == "focus") |
                .current.num as $num |
                ($num % 10) as $mod |
                if $mod == 0 then "10" else "\($mod)" end
              ' \
              | while IFS= read -r output; do
                ${pkgs.eww}/bin/eww update current_workspace="$output"
              done
            ''}/bin/eww-sway-updater";
            always = true;
          }
          {
            command = "${pkgs.eww}/bin/eww open bar0";
            always = true;
          }
          {
            command = "${pkgs.eww}/bin/eww open bar1";
            always = true;
          }
        ];

        modifier = "Mod4";
      } // cfg.extraSettings;
      extraConfig = ''
        blur enable
        blur_passes 2
        blur_radius 2
        corner_radius 10
        shadows on
        shadow_blur_radius 20
        default_dim_inactive 0.05
      '';
    };
  };
}
