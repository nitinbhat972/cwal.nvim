local M = {}

local ui = require("cwal.highlights.ui")
local syntax = require("cwal.highlights.syntax")
local integration = require("cwal.highlights.integration")

function M.apply_highlights(colors)
	ui.apply(colors)
	syntax.apply(colors)
	integration.apply(colors)
end

return M
