local M = {}

-- Required modules
local colors = require("cwal.colors")
local highlights = require("cwal.highlights")
local reload = require("cwal.reload")

function M.setup()
	-- Load colors
	local loaded_colors, err = colors.load_colors()
	if not loaded_colors then
		vim.notify("[cwal] Failed to load colors: " .. err, vim.log.levels.ERROR)
		return
	end

	-- Apply highlights
	highlights.apply_highlights(loaded_colors)

	-- Set editor options
	vim.opt.fillchars = { eob = " " }

	-- Start watching for changes
	reload.watch_and_reload()
end

return M
