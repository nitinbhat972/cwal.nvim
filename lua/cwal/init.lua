local M = {}

-- Required modules
local colors = require("cwal.colors")
local highlights = require("cwal.highlights")
local reload = require("cwal.reload")

function M.setup()
	-- Load colors and apply highlights using the central reload function
	reload.reload()

	-- Set editor options
	vim.opt.fillchars = { eob = " " }

	-- Start watching for changes
	reload.watch_and_reload()
end

return M
