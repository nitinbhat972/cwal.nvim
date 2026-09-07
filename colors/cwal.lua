vim.cmd[[hi clear]]
require("cwal").setup()

vim.g.colors_name = "cwal"
require("cwal.reload").reload()
require("cwal.reload").watch_and_reload()

local cwal_watcher_group = vim.api.nvim_create_augroup("CwalWatcher", { clear = true })

vim.api.nvim_create_autocmd("ColorScheme", {
	pattern = "*",
	group = cwal_watcher_group,
	callback = function()
		if vim.g.colors_name == "cwal" then
			require("cwal.reload").watch_and_reload()
		else
			require("cwal.reload").stop()
		end
	end,
})
