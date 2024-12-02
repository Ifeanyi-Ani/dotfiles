local M = {}
local h = require("utils/helpers")

--- M.get_background
-- @param dark (int) Represents the darkness level of the background.
-- @param light (int) Represents the lightness level of the background.
-- @return The computed background color.
M.get_background = function(dark, light)
	return {
		source = {
			Gradient = {
				colors = { h.is_dark() and "#000" or "#000" },
			},
		},
		width = "100%",
		height = "100%",
		opacity = h.is_dark() and dark or light,
	}
end

return M
