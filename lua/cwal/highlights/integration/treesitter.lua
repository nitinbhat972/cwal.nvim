local M = {}
local utils = require("cwal.utils")

local function get_highlights(colors)
	local bg = colors.background

	local text_fg = utils.readable(colors.foreground, bg, 4.9)
	local comment_fg = utils.readable(utils.lighten(colors.color8, 0.2), bg, 4.9)
	local subtle_fg = utils.readable(colors.color8, bg, 4.9)

	local red_fg = utils.readable(colors.color9 or colors.color1, bg, 4.9)
	local orange_fg = utils.readable(colors.color10 or colors.color3, bg, 4.9)
	local yellow_fg = utils.readable(colors.color11, bg, 4.9)
	local blue_fg = utils.readable(colors.color12 or colors.color4, bg, 4.9)
	local magenta_fg = utils.readable(colors.color13 or colors.color5, bg, 4.9)
	local cyan_fg = utils.readable(colors.color14 or colors.color6, bg, 4.9)
	local green_fg = utils.readable(colors.color10 or colors.color2, bg, 4.9)
	local quote_fg = utils.readable(colors.color7, bg, 4.9)

	return {
		["@comment"] = { fg = comment_fg, italic = true },
		["@comment.documentation"] = { link = "@comment" },
		["@todo"] = { fg = yellow_fg, bold = true },
		["@note"] = { fg = blue_fg, bold = true },
		["@warning"] = { fg = orange_fg, bold = true },
		["@error"] = { fg = red_fg, bold = true, italic = true },

		["@constant"] = { fg = magenta_fg, bold = true },
		["@constant.builtin"] = { fg = magenta_fg, italic = true },
		["@constant.macro"] = { fg = magenta_fg, bold = true },

		["@module"] = { fg = blue_fg },
		["@module.builtin"] = { fg = blue_fg, italic = true },
		["@label"] = { fg = blue_fg },

		["@variable"] = { fg = text_fg },
		["@variable.builtin"] = { fg = cyan_fg, italic = true },
		["@variable.parameter"] = { fg = quote_fg },
		["@variable.member"] = { fg = cyan_fg },
		["@field"] = { link = "@variable.member" },
		["@property"] = { link = "@variable.member" },

		["@function"] = { fg = blue_fg, italic = true },
		["@function.builtin"] = { fg = blue_fg, bold = true },
		["@function.call"] = { link = "@function" },
		["@function.macro"] = { fg = blue_fg, underline = true },
		["@function.method"] = { link = "@function" },
		["@function.method.call"] = { link = "@function" },
		["@method"] = { link = "@function" },
		["@method.call"] = { link = "@function" },
		["@constructor"] = { fg = blue_fg, bold = true },

		["@keyword"] = { fg = orange_fg, italic = true },
		["@keyword.function"] = { fg = orange_fg, bold = true },
		["@keyword.operator"] = { fg = orange_fg },
		["@keyword.return"] = { fg = orange_fg },
		["@keyword.import"] = { fg = orange_fg },
		["@keyword.conditional"] = { fg = orange_fg, bold = true },
		["@keyword.repeat"] = { fg = orange_fg, bold = true },
		["@keyword.exception"] = { fg = red_fg, italic = true },
		["@keyword.type"] = { fg = orange_fg },
		["@keyword.modifier"] = { fg = blue_fg },
		["@keyword.debug"] = { fg = yellow_fg },
		["@conditional"] = { link = "@keyword.conditional" },
		["@repeat"] = { link = "@keyword.repeat" },
		["@operator"] = { fg = cyan_fg },

		["@type"] = { fg = yellow_fg },
		["@type.builtin"] = { fg = yellow_fg, italic = true },
		["@type.definition"] = { fg = yellow_fg, underline = true },
		["@type.qualifier"] = { fg = blue_fg },
		["@namespace"] = { fg = blue_fg },
		["@attribute"] = { fg = magenta_fg },
		["@attribute.builtin"] = { fg = magenta_fg, italic = true },
		["@class"] = { fg = magenta_fg },
		["@struct"] = { fg = magenta_fg },
		["@interface"] = { fg = cyan_fg },
		["@enum"] = { fg = cyan_fg },
		["@enumMember"] = { fg = cyan_fg },

		["@number"] = { fg = magenta_fg },
		["@number.float"] = { link = "@number" },
		["@boolean"] = { fg = magenta_fg, bold = true },
		["@character"] = { fg = green_fg },
		["@string"] = { fg = green_fg, italic = true },
		["@string.documentation"] = { link = "@string" },
		["@string.escape"] = { fg = yellow_fg },
		["@string.regex"] = { fg = yellow_fg },

		["@punctuation.delimiter"] = { fg = text_fg },
		["@punctuation.bracket"] = { fg = text_fg },
		["@punctuation.special"] = { fg = cyan_fg },

		["@tag"] = { fg = red_fg },
		["@tag.attribute"] = { fg = blue_fg },
		["@tag.delimiter"] = { fg = subtle_fg },

		["@markup.heading"] = { fg = blue_fg, bold = true },
		["@markup.link"] = { fg = blue_fg, underline = true },
		["@markup.link.url"] = { link = "@markup.link" },
		["@markup.link.label"] = { fg = cyan_fg },
		["@markup.raw"] = { fg = green_fg },
		["@markup.raw.block"] = { link = "@markup.raw" },
		["@markup.list"] = { fg = blue_fg },
		["@markup.list.checked"] = { fg = green_fg },
		["@markup.list.unchecked"] = { fg = subtle_fg },
		["@markup.strong"] = { bold = true },
		["@markup.italic"] = { italic = true },

		["@text"] = { fg = text_fg },
		["@text.title"] = { link = "@markup.heading" },
		["@text.literal"] = { link = "@markup.raw" },
		["@text.reference"] = { link = "@markup.link" },
		["@text.uri"] = { link = "@markup.link" },
		["@text.emphasis"] = { italic = true },
		["@text.strong"] = { bold = true },
		["@text.quote"] = { fg = quote_fg, italic = true },
		["@text.environment"] = { fg = text_fg },
		["@text.environment.name"] = { fg = yellow_fg },

		["@diff.plus"] = { fg = green_fg },
		["@diff.minus"] = { fg = red_fg },
		["@diff.delta"] = { fg = blue_fg },

		["@lsp.type.variable"] = { link = "@variable" },
		["@lsp.type.parameter"] = { link = "@variable.parameter" },
		["@lsp.type.property"] = { link = "@property" },
		["@lsp.type.function"] = { link = "@function" },
		["@lsp.type.method"] = { link = "@function" },
		["@lsp.type.class"] = { link = "@class" },
		["@lsp.type.interface"] = { link = "@interface" },
		["@lsp.type.enum"] = { link = "@enum" },
		["@lsp.type.type"] = { link = "@type" },
		["@lsp.type.keyword"] = { link = "@keyword" },
		["@lsp.type.namespace"] = { link = "@namespace" },
		["@lsp.type.comment"] = { link = "@comment" },
		["@lsp.type.string"] = { link = "@string" },
		["@lsp.type.number"] = { link = "@number" },
		["@lsp.type.operator"] = { link = "@operator" },
		["@lsp.type.macro"] = { link = "@constant.macro" },
		["@lsp.mod.readonly"] = { fg = yellow_fg },
		["@lsp.mod.deprecated"] = { fg = subtle_fg, strikethrough = true },
		["@lsp.mod.static"] = { fg = blue_fg },
		["@lsp.typemod.variable.readonly"] = { fg = yellow_fg },
		["@lsp.typemod.property.readonly"] = { fg = yellow_fg },
		["@lsp.typemod.function.defaultLibrary"] = { fg = blue_fg, bold = true },

		["@variable.javascript"] = { fg = cyan_fg },
		["@property.json"] = { fg = blue_fg },
		["@type.python"] = { fg = magenta_fg },

		RainbowDelimiterRed = { fg = red_fg },
		RainbowDelimiterYellow = { fg = yellow_fg },
		RainbowDelimiterBlue = { fg = blue_fg },
		RainbowDelimiterOrange = { fg = orange_fg },
		RainbowDelimiterGreen = { fg = green_fg },
		RainbowDelimiterViolet = { fg = cyan_fg },
	}
end

function M.apply(colors)
	for group, settings in pairs(get_highlights(colors)) do
		vim.api.nvim_set_hl(0, group, settings)
	end
end

return M
