-- Pull in the wezterm API
local wezterm = require 'wezterm'
local act = wezterm.action


-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices.

-- For example, changing the initial geometry for new windows:
config.initial_cols = 120
config.initial_rows = 28

-- or, changing the font size and color scheme.
-- config.font_size = 10
-- config.color_scheme = 'AdventureTime'

-- Enable prompt navigation
config.keys = {
  { key = 'UpArrow', mods = 'SHIFT', action = act.ScrollToPrompt(-1) },
  { key = 'DownArrow', mods = 'SHIFT', action = act.ScrollToPrompt(1) },
}

-- Finally, return the configuration to wezterm:
return config

