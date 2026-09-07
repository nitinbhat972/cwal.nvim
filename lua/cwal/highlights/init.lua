local M = {}

local ui = require("cwal.highlights.ui")
local syntax = require("cwal.highlights.syntax")
local integration = require("cwal.highlights.integration")
local config = require("cwal.config")

function M.apply_highlights(colors, opts)
	ui.apply(colors, opts)
	syntax.apply(colors, opts)
	integration.apply(colors, opts)
	if config.validate(colors) then
		for i = 0, 15 do
			vim.g["terminal_color_" .. i] = colors["color" .. i]
		end
		vim.g.terminal_color_background = colors.background
		vim.g.terminal_color_foreground = colors.foreground
	end
end

return M
