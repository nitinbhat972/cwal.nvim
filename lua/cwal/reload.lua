local M = {}

local highlights = require("cwal.highlights")
local colors = require("cwal.colors")

local uv = vim.uv

local watcher = nil
local watched_file = vim.fn.expand("~/.config/cwal/cwal.ini")
local debounce_timer = nil

-- Function to reload the colors and apply highlights
local function reload()
	local loaded_colors, err = colors.load_colors()
	if not loaded_colors then
		vim.notify("[cwal] Failed to reload colors: " .. err, vim.log.levels.ERROR)
		return
	end
	highlights.apply_highlights(loaded_colors)

	-- Reload Lualine theme if it's loaded and using cwal theme
	if package.loaded.lualine and package.loaded.lualine.get_config then
		local lualine_config = require("lualine").get_config()
		if lualine_config and lualine_config.options and lualine_config.options.theme == "cwal" then
			-- Invalidate the cached modules to force a reload of the theme and colors
			package.loaded["cwal.highlights.integration.lualine_integration"] = nil
			package.loaded["lualine.themes.cwal"] = nil
			require("lualine").setup(lualine_config)
		end
	end
end

-- Starts watching the file for changes
function M.watch_and_reload()
	if watcher then
		return
	end

	local dir = vim.fn.fnamemodify(watched_file, ":h")
	if vim.fn.isdirectory(dir) == 0 then
		vim.notify("[cwal] Error: Directory for watched file does not exist: " .. dir, vim.log.levels.ERROR)
		return
	end

	watcher = uv.new_fs_event()
	if not watcher then
		vim.notify("[cwal] Failed to create file system watcher.", vim.log.levels.ERROR)
		return
	end

	uv.fs_event_start(watcher, watched_file, {}, function(err)
		if err then
			vim.notify("[cwal] Watcher error: " .. err, vim.log.levels.ERROR)
			return
		end

		-- Debounce the reload
		if debounce_timer then
			debounce_timer:close()
		end

		debounce_timer = uv.new_timer()
		if not debounce_timer then
			return
		end
		debounce_timer:start(100, 0, function()
			if debounce_timer then
				debounce_timer:close()
				debounce_timer = nil
			end
			vim.schedule(reload)
		end)
	end)
end

return M
