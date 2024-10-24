{
  pkgs,
  gaps_out,
  gaps_in,
  ...
}:
{
  bind = [
    "$mainMod, Return, exec, ${pkgs.alacritty}/bin/alacritty"
    "$mainMod SHIFT, Return, exec, alacritty --class='termfloat'"
    "$mainMod SHIFT, Q, killactive"
    "$mainMod SHIFT, E, exit"
    "$mainMod SHIFT, SPACE, togglefloating"
    "$mainMod SHIFT, SPACE, centerwindow"

    "$mainMod, F, fullscreen"
    "$mainMod, y, pin"
    "$mainMod, P, pseudo"
    "$mainMod, S, togglesplit"

    # Grouped layout
    "$mainMod, B, togglegroup"
    "$mainMod, Tab, changegroupactive, f"
    # Gap adjustment
    "$mainMod SHIFT, G,exec,hyprctl --batch 'keyword general:gaps_out ${builtins.toString gaps_out};keyword general:gaps_in ${builtins.toString gaps_in}'"
    "$mainMod , G,exec,hyprctl --batch 'keyword general:gaps_out 0;keyword general:gaps_in 0'"
    # Move focus with mainMod + arrow keys
    "$mainMod, H, movefocus, l"
    "$mainMod, J, movefocus, d"
    "$mainMod, K, movefocus, u"
    "$mainMod, L, movefocus, r"
    # Switch workspaces with mainMod + [0-9]
    "$mainMod, 1, split-workspace, 1"
    "$mainMod, 2, split-workspace, 2"
    "$mainMod, 3, split-workspace, 3"
    "$mainMod, 4, split-workspace, 4"
    "$mainMod, 5, split-workspace, 5"
    "$mainMod, 6, split-workspace, 6"
    "$mainMod, 7, split-workspace, 7"
    "$mainMod, 8, split-workspace, 8"
    "$mainMod, 9, split-workspace, 9"
    "$mainMod, 0, split-workspace, 10"
    "$mainMod, right, split-workspace, +1"
    "$mainMod, left, split-workspace, -1"
    "$mainMod, period, split-workspace, e+1"
    "$mainMod, comma, split-workspace,e-1"

    "$mainMod SHIFT, H ,movewindow, l"
    "$mainMod SHIFT, J ,movewindow, d"
    "$mainMod SHIFT, K ,movewindow, u"
    "$mainMod SHIFT, L ,movewindow, r"

    "$mainMod CTRL, 1, split-movetoworkspace, 1"
    "$mainMod CTRL, 2, split-movetoworkspace, 2"
    "$mainMod CTRL, 3, split-movetoworkspace, 3"
    "$mainMod CTRL, 4, split-movetoworkspace, 4"
    "$mainMod CTRL, 5, split-movetoworkspace, 5"
    "$mainMod CTRL, 6, split-movetoworkspace, 6"
    "$mainMod CTRL, 7, split-movetoworkspace, 7"
    "$mainMod CTRL, 8, split-movetoworkspace, 8"
    "$mainMod CTRL, 9, split-movetoworkspace, 9"
    "$mainMod CTRL, 0, split-movetoworkspace, 10"
    "$mainMod CTRL, left, split-movetoworkspace, -1"
    "$mainMod CTRL, right, split-movetoworkspace, +1"
    # same as above, but doesnt switch to the workspace
    "$mainMod SHIFT, 1, split-movetoworkspacesilent, 1"
    "$mainMod SHIFT, 2, split-movetoworkspacesilent, 2"
    "$mainMod SHIFT, 3, split-movetoworkspacesilent, 3"
    "$mainMod SHIFT, 4, split-movetoworkspacesilent, 4"
    "$mainMod SHIFT, 5, split-movetoworkspacesilent, 5"
    "$mainMod SHIFT, 6, split-movetoworkspacesilent, 6"
    "$mainMod SHIFT, 7, split-movetoworkspacesilent, 7"
    "$mainMod SHIFT, 8, split-movetoworkspacesilent, 8"
    "$mainMod SHIFT, 9, split-movetoworkspacesilent, 9"
    "$mainMod SHIFT, 0, split-movetoworkspacesilent, 10"
    # Scroll through existing workspaces with mainMod + scroll
    "$mainMod, mouse_down, split-workspace, e+1"
    "$mainMod, mouse_up, split-workspace, e-1"

    "$mainMod,slash,split-workspace,previous"

    # Monitor bindings
    "$mainMod CTRL, j, split-changemonitor, -1"
    "$mainMod CTRL, k, split-changemonitor, +1"

    "$mainMod, o, split-cycleworkspaces, +1"

    "$mainMod SHIFT,X,exec,swaylock -f"
    "$mainMod, bracketleft,exec,grimblast --notify --cursor  copysave area ~/Pictures/$(date '+%Y-%m-%d'T'%H:%M:%S_no_watermark').png"
    "$mainMod, bracketright,exec, grimblast --notify --cursor  copy area"
    "$mainMod, A,exec, grimblast_watermark"
    ",Super_L, exec, pkill rofi || ~/.config/rofi/launcher.sh"
    "$mainMod, Super_L,exec, bash ~/.config/rofi/powermenu.sh"
    "$mainMod, SPACE, exec, rofi -show drun"

    # control volume,brightness,media players
    ", XF86AudioRaiseVolume,exec, ${pkgs.wireplumber}/bin/wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 5%+"
    ", XF86AudioLowerVolume,exec, ${pkgs.wireplumber}/bin/wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 5%-"
    ", XF86AudioMute,exec, ${pkgs.wireplumber}/bin/wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
    ", XF86AudioMicMute,exec, ${pkgs.wireplumber}/bin/wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle "
    ", XF86MonBrightnessUp,exec, ${pkgs.light}/bin/light -A 5"
    ", XF86MonBrightnessDown, exec, ${pkgs.light}/bin/light -U 5"
    ", XF86AudioPlay,exec, ${pkgs.playerctl}/bin/playerctl play-pause"
    ", XF86AudioNext,exec, ${pkgs.playerctl}/bin/playerctl next"
    ", XF86AudioPrev,exec, ${pkgs.playerctl}/bin/playerctl previous"

    # Toggle waybar
    "$mainMod, O, exec, killall -SIGUSR1 .waybar-wrapped"
  ];
}
