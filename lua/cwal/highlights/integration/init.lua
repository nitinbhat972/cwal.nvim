local M = {}

local bufferline = require("cwal.highlights.integration.bufferline")
local treesitter = require("cwal.highlights.integration.treesitter")
local lsp = require("cwal.highlights.integration.lsp")

function M.apply(colors)
	bufferline.apply(colors)
	treesitter.apply(colors)
	lsp.apply(colors)
end

return M
