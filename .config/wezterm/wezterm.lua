--
-- ██╗    ██╗███████╗███████╗████████╗███████╗██████╗ ███╗   ███╗
-- ██║    ██║██╔════╝╚══███╔╝╚══██╔══╝██╔════╝██╔══██╗████╗ ████║
-- ██║ █╗ ██║█████╗    ███╔╝    ██║   █████╗  ██████╔╝██╔████╔██║
-- ██║███╗██║██╔══╝   ███╔╝     ██║   ██╔══╝  ██╔══██╗██║╚██╔╝██║
-- ╚███╔███╔╝███████╗███████╗   ██║   ███████╗██║  ██║██║ ╚═╝ ██║
--  ╚══╝╚══╝ ╚══════╝╚══════╝   ╚═╝   ╚══════╝╚═╝  ╚═╝╚═╝     ╚═╝
-- A GPU-accelerated cross-platform terminal emulator
-- https://wezfurlong.org/wezterm/

local dark_opacity = 0.85
local light_opacity = 0.9

local wallpapers_glob = os.getenv("HOME") .. "/.config/wezterm/wallpapers/**"

local b = require("utils/background")
local cs = require("utils/color_scheme")
local h = require("utils/helpers")
local w = require("utils/wallpaper")

local wezterm = require("wezterm")
local act = wezterm.action

local config = {
	background = {
		w.get_wallpaper(wallpapers_glob),
		b.get_background(dark_opacity, light_opacity),
	},

	font_size = 14,

	line_height = 1,
	font = wezterm.font("MesloLGS Nerd Font Mono"),
	color_scheme = cs.get_color_scheme(),

	window_padding = {
		left = 10,
		right = 10,
		top = 10,
		bottom = 10,
	},

	set_environment_variables = {
		BAT_THEME = h.is_dark() and "Catppuccin-mocha" or "Catppuccin-latte",
		LC_ALL = "en_US.UTF-8",
		-- TODO: audit what other variables are needed
	},

	-- general options
	adjust_window_size_when_changing_font_size = false,
	debug_key_events = false,
	enable_tab_bar = false,
	tab_bar_at_bottom = false,
	use_fancy_tab_bar = false,
	tab_and_split_indices_are_zero_based = true,
	window_close_confirmation = "NeverPrompt",
	window_decorations = "NONE",

	leader = { mods = "CTRL", key = "b" },
	keys = {
		{
			key = "f",
			mods = "CTRL",
			action = wezterm.action.ToggleFullScreen,
		},
		{
			key = "'",
			mods = "CTRL",
			action = wezterm.action.ClearScrollback("ScrollbackAndViewport"),
		},
		-- 	{
		-- 		mods = "LEADER",
		-- 		key = "c",
		-- 		action = act.SpawnTab("CurrentPaneDomain"),
		-- 	},
		-- 	{
		-- 		mods = "CTRL",
		-- 		key = "d",
		-- 		action = act.CloseCurrentPane({ confirm = true }),
		-- 	},
		-- 	{
		-- 		mods = "LEADER",
		-- 		key = "n",
		-- 		action = act.ActivateTabRelative(1),
		-- 	},
		-- 	{
		-- 		mods = "LEADER",
		-- 		key = "p",
		-- 		action = act.ActivateTabRelative(-1),
		-- 	},
		-- 	{
		-- 		mods = "LEADER",
		-- 		key = "-",
		-- 		action = act.SplitVertical({ domain = "CurrentPaneDomain" }),
		-- 	},
		-- 	{
		-- 		mods = "LEADER",
		-- 		key = "v",
		-- 		action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }),
		-- 	},
		-- 	{
		-- 		mods = "CTRL",
		-- 		key = "h",
		-- 		action = wezterm.action.ActivatePaneDirection("Left"),
		-- 	},
		-- 	{
		-- 		mods = "CTRL",
		-- 		key = "j",
		-- 		action = wezterm.action.ActivatePaneDirection("Down"),
		-- 	},
		-- 	{
		-- 		mods = "CTRL",
		-- 		key = "k",
		-- 		action = wezterm.action.ActivatePaneDirection("Up"),
		-- 	},
		-- 	{
		-- 		mods = "CTRL",
		-- 		key = "l",
		-- 		action = wezterm.action.ActivatePaneDirection("Right"),
		-- 	},
		-- 	{
		-- 		mods = "LEADER",
		-- 		key = "h",
		-- 		action = wezterm.action.AdjustPaneSize({ "Left", 5 }),
		-- 	},
		-- 	{
		-- 		mods = "LEADER",
		-- 		key = "l",
		-- 		action = wezterm.action.AdjustPaneSize({ "Right", 5 }),
		-- 	},
		-- 	{
		-- 		mods = "LEADER",
		-- 		key = "j",
		-- 		action = wezterm.action.AdjustPaneSize({ "Down", 5 }),
		-- 	},
		-- 	{
		-- 		mods = "LEADER",
		-- 		key = "k",
		-- 		action = wezterm.action.AdjustPaneSize({ "Up", 5 }),
		-- 	},
	},
}

-- for i = 0, 9 do
-- 	-- leader + number to activate that tab
-- 	table.insert(config.keys, {
-- 		key = tostring(i),
-- 		mods = "LEADER",
-- 		action = wezterm.action.ActivateTab(i),
-- 	})
-- end

wezterm.on("update-right-status", function(window, _)
	local SOLID_LEFT_ARROW = ""
	local ARROW_FOREGROUND = { Foreground = { Color = "#c6a0f6" } }
	local prefix = ""

	if window:leader_is_active() then
		prefix = " " .. utf8.char(0x1f30a) -- ocean wave
		SOLID_LEFT_ARROW = utf8.char(0xe0b2)
	end

	if window:active_tab():tab_id() ~= 0 then
		ARROW_FOREGROUND = { Foreground = { Color = "#1e2030" } }
	end -- arrow color based on if tab is first pane

	window:set_left_status(wezterm.format({
		{ Background = { Color = "#b7bdf8" } },
		{ Text = prefix },
		ARROW_FOREGROUND,
		{ Text = SOLID_LEFT_ARROW },
	}))
end)

wezterm.on("user-var-changed", function(window, pane, name, value)
	-- local appearance = window:get_appearance()
	-- local is_dark = appearance:find("Dark")
	local overrides = window:get_config_overrides() or {}
	wezterm.log_info("name", name)
	wezterm.log_info("value", value)

	if name == "T_SESSION" then
		local session = value
		wezterm.log_info("is session", session)
		overrides.background = {
			w.set_tmux_session_wallpaper(value),
			{
				source = {
					Gradient = {
						colors = { "#000000" },
					},
				},
				width = "100%",
				height = "100%",
				opacity = 0.95,
			},
		}
	end

	if name == "ZEN_MODE" then
		local incremental = value:find("+")
		local number_value = tonumber(value)
		if incremental ~= nil then
			while number_value > 0 do
				window:perform_action(wezterm.action.IncreaseFontSize, pane)
				number_value = number_value - 1
			end
		elseif number_value < 0 then
			window:perform_action(wezterm.action.ResetFontSize, pane)
			overrides.font_size = nil
		else
			overrides.font_size = number_value
		end
	end
	if name == "DIFF_VIEW" then
		local incremental = value:find("+")
		local number_value = tonumber(value)
		if incremental ~= nil then
			while number_value > 0 do
				window:perform_action(wezterm.action.DecreaseFontSize, pane)
				number_value = number_value - 1
			end
			-- overrides.background = {
			-- 	w.set_nvim_wallpaper("Diffview.jpeg"),
			--
			-- 	{
			-- 		source = {
			-- 			Gradient = {
			-- 				colors = { "#000000" },
			-- 			},
			-- 		},
			-- 		width = "100%",
			-- 		height = "100%",
			-- 		opacity = 0.95,
			-- 	},
			-- }
		elseif number_value < 0 then
			window:perform_action(wezterm.action.ResetFontSize, pane)
			overrides.background = nil
			overrides.font_size = nil
		else
			overrides.font_size = number_value
		end
	end
	window:set_config_overrides(overrides)
end)

return config
