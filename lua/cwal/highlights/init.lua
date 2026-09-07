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
	local overrides = (opts and opts.overrides) or {}
	if type(overrides) == "table" then
		for group, override in pairs(overrides) do
			if type(override) == "table" then
				local current = vim.api.nvim_get_hl(0, { name = group })
				vim.api.nvim_set_hl(0, group, vim.tbl_deep_extend("force", current, override))
			end
		end
	end
end

return M
