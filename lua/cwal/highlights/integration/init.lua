local M = {}

local bufferline = require("cwal.highlights.integration.bufferline")
local treesitter = require("cwal.highlights.integration.treesitter")
local lsp = require("cwal.highlights.integration.lsp")

function M.apply(colors, opts)
	bufferline.apply(colors, opts)
	treesitter.apply(colors, opts)
	lsp.apply(colors, opts)
end

return M
