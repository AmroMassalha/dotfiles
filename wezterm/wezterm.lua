-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
config.colors = {
	-- Set foreground and background from the [colors.primary] section
	foreground = "#edecee",  -- colors.primary.foreground
	background = "#15141b",  -- colors.primary.background

	-- Cursor colors from the [colors.cursor] section
	cursor_bg = "#a277ff",    -- colors.cursor.cursor
	cursor_border = "#a277ff", -- colors.cursor.cursor
	cursor_fg = "#15141b",     -- Set to background color for contrast

	-- Selection colors from the [colors.selection] section
	selection_bg = "#29263c",  -- colors.selection.background
	selection_fg = "#edecee",  -- Set to foreground for legibility

	-- ANSI colors from the [colors.normal] section
	ansi = {
		"#110f18", -- black
		"#ff6767", -- red
		"#61ffca", -- green
		"#ffca85", -- yellow
		"#a277ff", -- blue
		"#a277ff", -- magenta
		"#61ffca", -- cyan
		"#edecee", -- white
	},

	-- Bright ANSI colors from the [colors.bright] section
	brights = {
		"#4d4d4d", -- bright black
		"#ff6767", -- bright red
		"#61ffca", -- bright green
		"#ffca85", -- bright yellow
		"#a277ff", -- bright blue
		"#a277ff", -- bright magenta
		"#61ffca", -- bright cyan
		"#edecee", -- bright white
	},
}

config.keys = {
	-- Make Option-Left equivalent to Alt-b which many line editors interpret as backward-word
	{ key = "LeftArrow", mods = "OPT", action = wezterm.action({ SendString = "\x1bb" }) },
	-- Make Option-Right equivalent to Alt-f; forward-word
	{ key = "RightArrow", mods = "OPT", action = wezterm.action({ SendString = "\x1bf" }) },
}

config.font = wezterm.font("ComicShannsMono Nerd Font")
config.font_size = 21

config.enable_tab_bar = false

config.window_decorations = "RESIZE"
config.window_background_opacity = 0.75
config.macos_window_background_blur = 8

-- and finally, return the configuration to wezterm
return config
