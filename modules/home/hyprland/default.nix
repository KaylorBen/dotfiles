{ config, inputs, lib, pkgs, osConfig, ... }:
let cfg = config.Wotan.desktop.hyprland;
in {
  options.Wotan.desktop.hyprland = {
    enable = lib.mkOption {
      type = lib.types.bool;
      description = "hyprland";
      default = osConfig.Wotan.desktop.hyprland.enable or false;
    };
    extraAutoStart = lib.mkOption {
      # list of strings
      type = with lib.types; listof str;
      default = if builtins.hasAttr "Wotan" osConfig then
        osConfig.Wotan.desktop.hyprland.extraAutoStart
      else
        [ ];
    };
    extraSettings = lib.mkOption {
      type = lib.types.attrs;
      default = if builtins.hasAttr "Wotan" osConfig then
        osConfig.Wotan.desktop.hyprland.extraSettings
      else
        { };
    };
  };

  config = lib.mkIf cfg.enable {
    Wotan.programs.waybar.enable = true;
    programs.rofi = {
      enable = true;
      package = pkgs.wofi;
    home.file.".config/rofi/config.rasi".source = ./rose-pine.rasi
    services = {
      mako.enable = true;
      playerctld.enable = true;
      swayidle = {
        enable = true;
        events = [
          {
            event = "before-sleep";
            command = "${pkgs.swaylock-effects}/bin/swaylock";
          }
          {
            event = "after-resume";
            command = "${
                lib.getExe' config.wayland.windowManager.hyprland.package "hyprctl"
              } dispatch dpms on";
          }
          {
            event = "lock";
            command = "${pkgs.swaylock-effects}/bin/swaylock";
          }
        ];
        timeouts = [{
          timeout = 300;
          command = "${pkgs.systemd}/bin/loginctl lock-session";
        }];
      };
    };

    home.packages = with pkgs; [
      rofi-wayland
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
        # font = config.stylix.fonts.monospace.name;
        clock = true;
        timestr = "%r";
        datestr = "%A, %d %B";
        fade-in = 0.2;
        effect-blur = "20x2";
        indicator = true;
        indicator-radius = 240;
        indicator-thickness = 20;
        indicator-caps-lock = true;

        disable-caps-lock-text = true;

        inside-color = lib.mkForce "00000000";
      };
    };

    wayland.windowManager.hyprland = let
      self = config.wayland.windowManager.hyprland;
    in {
      enable = true;
      xwayland = { enable = true; };
      systemd.enable = true;
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
          "gdk_scale,2"
          # Not using stylix
          # "xcursor_size,${lib.tostring config.stylix.cursor.size}"
        ];
        xwayland = { force_zero_scaling = true; };
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
          gaps_in = lib.mkDefault 5;
          gaps_out = lib.mkDefault 8;
          border_size = lib.mkDefault 3;
          layout = "dwindle"; # master | dwindle
        };
        dwindle = {
          no_gaps_when_only = false;
          force_split = 0;
          special_scale_factor = 0.8;
          split_width_multiplier = 1.0;
          use_active_for_splits = true;
          pseudotile = true;
          preserve_split = true;
        };
        decoration = {
          active_opacity = 1.0;
          inactive_opacity = 0.85;
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
            "windows, 1, 4, easeInOutCubic, slide"
            "windowsOut, 1, 5, default, popin 80%"
            "border, 1, 5, default"
            "fade, 1, 8, default"
            "workspaces, 1, 6, easeInOutCubic, slidevert"
          ];
        };
        # No stylix or styling set up or wallpaper engine
        # exec-once = [
        #   "mako &"
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
        ];
      } // (import ./keybinds.nix {
        inherit lib;
        inherit pkgs;
        inherit (self.settings.general) gaps_in;
        inherit (self.settings.general) gaps_out;
      }) // cfg.extraSettings;
    };
  };
}
