-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

config.color_scheme = 'rose-pine';
config.hide_tab_bar_if_only_one_tab = true;
config.enable_wayland = false;
config.font = wezterm.font('Fira Code')

-- and finally, return the configuration to wezterm
return config
