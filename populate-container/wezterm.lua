-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices.

-- For example, changing the initial geometry for new windows:
config.initial_cols = 120
config.initial_rows = 30

-- or, changing the font size and color scheme.
config.font = wezterm.font("FiraCode Nerd Font Propo", {weight="Regular", stretch="Normal", style="Normal"})
config.font_size = 16
config.color_scheme = 'Symfonic'

-- Finally, return the configuration to wezterm:
return config
