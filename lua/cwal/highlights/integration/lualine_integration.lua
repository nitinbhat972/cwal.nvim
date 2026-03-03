local colors_module = require("cwal.colors")
local utils = require("cwal.utils")

local function fallback_colors()
	return {
		background = "#1e1e2e",
		foreground = "#cdd6f4",
		color0 = "#11111b",
		color1 = "#f38ba8",
		color2 = "#a6e3a1",
		color3 = "#f9e2af",
		color4 = "#89b4fa",
		color5 = "#f5c2e7",
		color7 = "#bac2de",
		color8 = "#585b70",
		color9 = "#f38ba8",
		color10 = "#a6e3a1",
		color11 = "#f9e2af",
		color12 = "#89b4fa",
		color13 = "#f5c2e7",
		color15 = "#a6adc8",
	}
end

local colors, err = colors_module.load_colors()
if not colors then
	vim.notify("[cwal] Failed to load colors for lualine: " .. err, vim.log.levels.WARN)
	colors = fallback_colors()
end

local normal_a_bg = utils.readable(colors.color12 or colors.color4, colors.color0, 2.2)
local insert_a_bg = utils.readable(colors.color10 or colors.color2, colors.color0, 2.2)
local command_a_bg = utils.readable(colors.color11 or colors.color3, colors.color0, 2.2)
local visual_a_bg = utils.readable(colors.color13 or colors.color5, colors.color0, 2.2)
local replace_a_bg = utils.readable(colors.color9 or colors.color1, colors.color0, 2.2)

local normal_a_fg = utils.readable(colors.background, normal_a_bg, 4.9)
local insert_a_fg = utils.readable(colors.background, insert_a_bg, 4.9)
local command_a_fg = utils.readable(colors.background, command_a_bg, 4.9)
local visual_a_fg = utils.readable(colors.background, visual_a_bg, 4.9)
local replace_a_fg = utils.readable(colors.background, replace_a_bg, 4.9)

local bar_bg = colors.color0
local normal_b_fg = utils.readable(colors.color12 or colors.color4, bar_bg, 4.9)
local insert_b_fg = utils.readable(colors.color10 or colors.color2, bar_bg, 4.9)
local command_b_fg = utils.readable(colors.color11 or colors.color3, bar_bg, 4.9)
local visual_b_fg = utils.readable(colors.color13 or colors.color5, bar_bg, 4.9)
local replace_b_fg = utils.readable(colors.color9 or colors.color1, bar_bg, 4.9)
local normal_c_fg = utils.readable(colors.foreground, bar_bg, 4.9)
local inactive_a_fg = utils.readable(colors.color8, bar_bg, 4.9)
local inactive_b_fg = utils.readable(colors.color7, bar_bg, 4.9)
local inactive_c_fg = utils.readable(colors.color15 or colors.foreground, bar_bg, 4.9)

return {
	normal = {
		a = { bg = normal_a_bg, fg = normal_a_fg, gui = "bold" },
		b = { bg = bar_bg, fg = normal_b_fg },
		c = { bg = bar_bg, fg = normal_c_fg },
	},
	insert = {
		a = { bg = insert_a_bg, fg = insert_a_fg, gui = "bold" },
		b = { bg = bar_bg, fg = insert_b_fg },
	},
	terminal = {
		a = { bg = insert_a_bg, fg = insert_a_fg, gui = "bold" },
		b = { bg = bar_bg, fg = insert_b_fg },
	},
	command = {
		a = { bg = command_a_bg, fg = command_a_fg, gui = "bold" },
		b = { bg = bar_bg, fg = command_b_fg },
	},
	visual = {
		a = { bg = visual_a_bg, fg = visual_a_fg, gui = "bold" },
		b = { bg = bar_bg, fg = visual_b_fg },
	},
	replace = {
		a = { bg = replace_a_bg, fg = replace_a_fg, gui = "bold" },
		b = { bg = bar_bg, fg = replace_b_fg },
	},
	inactive = {
		a = { bg = bar_bg, fg = inactive_a_fg },
		b = { bg = bar_bg, fg = inactive_b_fg, gui = "bold" },
		c = { bg = bar_bg, fg = inactive_c_fg },
	},
}
