local M = {}

-- Required modules
local colors = require("cwal.colors")
local config = require("cwal.config")
local highlights = require("cwal.highlights")
local reload = require("cwal.reload")

function M.setup(opts)
	if opts ~= nil then
		config.setup(opts)
	end
	-- Load colors and apply highlights using the central reload function
	reload.reload()

	-- Start watching for changes
	reload.watch_and_reload()
end

return M
