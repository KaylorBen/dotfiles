{
  config,
  inputs,
  lib,
  pkgs,
  osConfig,
  ...
}:
with lib;
let
  cfg = config.Wotan.desktop.hyprland;
in
{
  options.Wotan.desktop.hyprland = {
    enable = mkOption {
      type = types.bool;
      description = "hyprland";
      default = osConfig.Wotan.desktop.hyprland.enable or false;
    };
    extraAutoStart = mkOption {
      # list of strings
      type = with types; listof str;
      default =
        if builtins.hasAttr "Wotan" osConfig then osConfig.Wotan.desktop.hyprland.extraAutoStart else [ ];
    };
    extraSettings = mkOption {
      type = types.attrs;
      default =
        if builtins.hasAttr "Wotan" osConfig then osConfig.Wotan.desktop.hyprland.extraSettings else { };
    };
    plugins = mkOption {
      type = with types; listOf package;
      default = [];
    };
    splitBinds = mkEnableOption "split keybindings instead";
    bar = mkOption {
      type = types.str;
      default = "waybar";
    };
  };

  config = mkIf cfg.enable {
    Wotan.programs.${cfg.bar}.enable = true;

    # programs.rofi = {
    #   enable = true;
    #   package = pkgs.wofi;
    # };
    home.file.".config/rofi/config.rasi".source = ./rose-pine.rasi;
    services = {
      playerctld.enable = true;
      swayidle = {
        enable = true;
        events = [
          {
            event = "before-sleep";
            command = "${pkgs.swaylock-effects}/bin/swaylock -f";
          }
          {
            event = "after-resume";
            command = "${getExe' config.wayland.windowManager.hyprland.package "hyprctl"} dispatch dpms on";
          }
          {
            event = "lock";
            command = "${pkgs.swaylock-effects}/bin/swaylock -f";
          }
        ];
        timeouts = [
          {
            timeout = 300;
            command = "${pkgs.systemd}/bin/loginctl lock-session";
          }
        ];
      };
      hyprpaper = {
        enable = true;
        package = inputs.hyprpaper.packages.${pkgs.system}.hyprpaper;
        settings = {
          preload = [
            "${lib.Wotan.wallpaper1}"
            "${lib.Wotan.wallpaper2}"
          ];
          wallpaper = [
            "DP-1, ${lib.Wotan.wallpaper1}"
            "HDMI-A-1, ${lib.Wotan.wallpaper2}"
          ];
          splash = true;

          ipc = "off";
        };
      };
    };
    stylix.targets.hyprpaper.enable = lib.mkForce false;

    home.packages = with pkgs; [
      rofi-wayland
      wofi
      pamixer
      inputs.hyprwm-contrib.packages.${pkgs.system}.grimblast
      networkmanager
      wl-clipboard
      wl-clipboard-x11
    ];

    programs.swaylock = {
      enable = true;
      package = pkgs.swaylock-effects;
      settings = {
        ignore-empty-password = true;
        # Not using stylix
        font = "Fantasque Sans Mono";
        screenshots = true;
        clock = true;
        timestr = "%r";
        datestr = "%A, %d %B";
        fade-in = 0.2;
        effect-blur = "20x2";
        indicator = true;
        indicator-radius = 100;
        indicator-thickness = 10;
        indicator-x-position = 175;
        indicator-y-position = 1000;
        indicator-caps-lock = true;

        disable-caps-lock-text = true;

        key-hl-color = mkForce "31748f";
        bs-hl-color = mkForce "eb6f92";
        caps-lock-key-hl-color = mkForce "c4a7e7";
        caps-lock-bs-hl-color = mkForce "eb6f92";

        inside-color = mkForce "00000000";
        inside-clear-color = mkForce "00000000";
        inside-caps-lock-color = mkForce "00000000";
        inside-ver-color = mkForce "00000000";
        inside-wrong-color = mkForce "00000000";

        line-uses-inside = true;

        ring-color = mkForce "26233a";
        ring-clear-color = mkForce "ebbcba";
        ring-caps-lock-color = mkForce "f6c177";
        ring-ver-color = mkForce "31748f";
        ring-wrong-color = mkForce "eb6f92";
      };
    };

    wayland.windowManager.hyprland =
      let
        self = config.wayland.windowManager.hyprland;
      in {
        enable = true;
        package = inputs.hyprland.packages.${pkgs.system}.hyprland;
        xwayland = {
          enable = true;
        };
        systemd.enable = true;
        plugins = cfg.plugins;
        settings = {
            source = "${./keybinds.conf}";
            "$mainMod" = "super";
            input = {
              kb_layout = "us";
              kb_options = "caps:escape";
              touchpad = {
                natural_scroll = true;
                clickfinger_behavior = true;
              };
              follow_mouse = 1;
              float_switch_override_focus = 2;
              sensitivity = 0; # -1.0 to 1.0
            };
            gestures = {
              workspace_swipe = true;
              workspace_swipe_fingers = 4;
              workspace_swipe_distance = 250;
              workspace_swipe_invert = true;
              workspace_swipe_min_speed_to_force = 15;
              workspace_swipe_cancel_ratio = 0.5;
              workspace_swipe_create_new = true;
            };
            env = [
              # "gdk_scale,2"
              # Not using stylix
              # "xcursor_size,${tostring config.stylix.cursor.size}"
            ];
            xwayland = {
              force_zero_scaling = true;
            };

            render.explicit_sync = 0;

            misc = {
              disable_autoreload = true;
              disable_hyprland_logo = true;
              vrr = 2;
              focus_on_activate = true;
              always_follow_on_dnd = true;
              layers_hog_keyboard_focus = true;
              animate_manual_resizes = false;
            };
            general = {
              gaps_in = mkDefault 5;
              gaps_out = mkDefault 8;
              border_size = mkDefault 3;
              layout = "dwindle"; # master | dwindle
              # "col.active_border" = "0xffebbcba";
              # "col.inactive_border" = "0xff6e6a86";
              allow_tearing = true;
            };
            dwindle = {
              force_split = 0;
              special_scale_factor = 0.8;
              split_width_multiplier = 1.0;
              use_active_for_splits = true;
              pseudotile = true;
              preserve_split = true;
            };
            decoration = {
              active_opacity = 1.0;
              inactive_opacity = 0.9;
              rounding = 10;

              blur = {
                size = 3;
                passes = 1;
                new_optimizations = true;
              };
              drop_shadow = true;
              shadow_range = 4;
              shadow_render_power = 3;
              shadow_ignore_window = true;

              dim_inactive = false;
              dim_strength = 0.3;
            };
            animations = {
              enabled = true;
              bezier = "easeInOutCubic, 0.65, 0, 0.35, 1";
              animation = [
                "windows, 1, 2, easeInOutCubic, slide"
                "windowsOut, 1, 5, default, popin 80%"
                "border, 1, 3, default"
                "fade, 1, 4, default"
                "workspaces, 1, 1, easeInOutCubic, slidevert"
              ];
            };
            # No stylix or styling set up or wallpaper engine
            # exec-once = [
            #   "hyprctl setcursor '${config.stylix.cursor.name}' ${
            #     tostring config.stylix.cursor.size
            #   }"
            #   "${pkgs.swaybg}/bin/swaybg -i ${config.stylix.image} -m fill"
            #   "border_color &"
            #   "${pkgs.networkmanagerapplet}/bin/nm-applet --indicator &"
            #   "${wallpaper-engine} &"
            # ] ++ cfg.extraautostart;
            # `hyprctl clients` get class、title...
            windowrule = [
              "float,title:^(picture-in-picture)$"
              "size 960 540,title:^(picture-in-picture)$"
              "move 25%-,title:^(picture-in-picture)$"
              "float,imv"
              "move 25%-,imv"
              "size 960 540,imv"
              "float,mpv"
              "move 25%-,mpv"
              "size 960 540,mpv"
              "float,danmufloat"
              "move 25%-,danmufloat"
              "pin,danmufloat"
              "rounding 5,danmufloat"
              "size 960 540,danmufloat"
              "float,termfloat"
              "move 25%-,termfloat"
              "size 960 540,termfloat"
              "rounding 5,termfloat"
              "float,nemo"
              "move 25%-,nemo"
              "size 960 540,nemo"
              "opacity 0.95,title:telegram"
              "animation slide right,kitty"
              "float,ncmpcpp"
              "move 25%-,ncmpcpp"
              "size 960 540,ncmpcpp"
              "noblur,^(firefox)$"
            ];
            windowrulev2 = [
              "opacity 0.0 override 0.0 override,class:^(xwaylandvideobridge)$"
              "noanim,class:^(xwaylandvideobridge)$"
              "nofocus,class:^(xwaylandvideobridge)$"
              "noinitialfocus,class:^(xwaylandvideobridge)$"
              "opacity 0.0 override 0.0 override,class:ffxiv_dx11.exe"
              "noblur, class:ffxiv_dx11.exe"
              "fullscreen, class:ffxiv_dx11.exe"
              "workspace 11, class:ffxiv_dx11.exe"
            ];
          }
          // (import (if cfg.splitBinds then ./split-window-binds.nix else ./keybinds.nix) {
            inherit lib;
            inherit pkgs;
            inherit (self.settings.general) gaps_in;
            inherit (self.settings.general) gaps_out;
          })
          // cfg.extraSettings;
      };
  };
}
