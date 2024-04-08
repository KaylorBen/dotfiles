-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

config.color_scheme = 'Rose-Pine';
config.hide_tab_bar_if_only_one_tab = true;
config.enable_wayland = false;

-- and finally, return the configuration to wezterm
return config
