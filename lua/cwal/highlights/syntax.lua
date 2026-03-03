local M = {}
local utils = require("cwal.utils")

local function get_highlights(colors)
	local bg = colors.background

	return {
		Comment = { fg = utils.readable(utils.lighten(colors.color8, 0.5), bg, 4.9), italic = true },
		Constant = { fg = utils.readable(utils.lighten(colors.color5, 0.25), bg), bold = true },
		String = { fg = utils.readable(utils.lighten(colors.color2, 0.2), bg), italic = true },
		Character = { fg = utils.readable(utils.lighten(colors.color2, 0.15), bg) },
		Number = { fg = utils.readable(utils.lighten(colors.color5, 0.2), bg), bold = true },
		Boolean = { fg = utils.readable(utils.lighten(colors.color5, 0.3), bg), bold = true },
		Float = { fg = utils.readable(utils.lighten(colors.color5, 0.25), bg), bold = true },

		Identifier = { fg = utils.readable(utils.lighten(colors.foreground, 0.15), bg, 4.9) },
		Function = { fg = utils.readable(utils.lighten(colors.color4, 0.15), bg), italic = true, bold = true },

		Statement = { fg = utils.readable(utils.lighten(colors.color3, 0.12), bg), bold = true },
		Conditional = { fg = utils.readable(utils.lighten(colors.color3, 0.16), bg), bold = true },
		Repeat = { fg = utils.readable(utils.lighten(colors.color3, 0.16), bg), bold = true },
		Label = { fg = utils.readable(utils.lighten(colors.color4, 0.08), bg) },
		Operator = { fg = utils.readable(utils.lighten(colors.color6, 0.15), bg) },
		Keyword = { fg = utils.readable(utils.lighten(colors.color3, 0.22), bg), bold = true, italic = true },
		Exception = { fg = utils.readable(utils.lighten(colors.color1, 0.18), bg) },

		PreProc = { fg = utils.readable(utils.lighten(colors.color5, 0.12), bg) },
		Include = { fg = utils.readable(utils.lighten(colors.color5, 0.17), bg), underline = true, bold = true },
		Define = { fg = utils.readable(utils.lighten(colors.color5, 0.14), bg), bold = true },
		Macro = { fg = utils.readable(utils.lighten(colors.color5, 0.14), bg) },
		PreCondit = { fg = utils.readable(utils.lighten(colors.color5, 0.14), bg) },

		Type = { fg = utils.readable(utils.lighten(colors.color3, 0.23), bg), bold = true },
		StorageClass = { fg = utils.readable(utils.lighten(colors.color3, 0.2), bg) },
		Structure = { fg = utils.readable(utils.lighten(colors.color9, 0.08), bg) },
		Typedef = { fg = utils.readable(utils.lighten(colors.color9, 0.08), bg) },

		Special = { fg = utils.readable(utils.lighten(colors.color6, 0.14), bg) },
		SpecialChar = { fg = utils.readable(utils.lighten(colors.color6, 0.2), bg) },
		Tag = { fg = utils.readable(utils.lighten(colors.color1, 0.28), bg) },
		Delimiter = { fg = utils.readable(utils.lighten(colors.color8, 0.38), bg, 4.9) },
		SpecialComment = { fg = utils.readable(utils.lighten(colors.color8, 0.6), bg, 4.9), italic = true },
		Debug = { fg = utils.readable(utils.lighten(colors.color14, 0.1), bg), bold = true },

		Underlined = { fg = utils.readable(utils.lighten(colors.color4, 0.3), bg, 4.9), underline = true },
		Ignore = { fg = utils.readable(utils.lighten(colors.color8, 0.5), bg, 4.9) },
		Error = { fg = utils.readable(utils.lighten(colors.color1, 0.37), bg, 4.9), bold = true, undercurl = true },
		Todo = { fg = utils.readable(utils.lighten(colors.color11, 0.43), bg, 4.9), bold = true, italic = true },

		htmlTag = { fg = utils.readable(utils.lighten(colors.color1, 0.23), bg) },
		htmlTagName = { fg = utils.readable(utils.lighten(colors.color4, 0.13), bg) },
		htmlArg = { fg = utils.readable(utils.lighten(colors.color4, 0.13), bg) },
		cssProp = { fg = utils.readable(utils.lighten(colors.color6, 0.28), bg) },
	}
end

function M.apply(colors)
	for group, settings in pairs(get_highlights(colors)) do
		vim.api.nvim_set_hl(0, group, settings)
	end
end

return M
