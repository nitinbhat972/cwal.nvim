vim.cmd[[hi clear]]
require("cwal").setup()
vim.g.colors_name = "cwal"
require("cwal.reload").reload()
require("cwal.reload").watch_and_reload()
