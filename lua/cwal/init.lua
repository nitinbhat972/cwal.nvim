local M = {}

-- Required modules
local config = require("cwal.config")

function M.setup(opts)
	if opts ~= nil then
		config.setup(opts)
	end
	-- Configure-only: applying happens via :colorscheme cwal (see colors/cwal.lua)
end

return M
