local M = {}
local utils = require("cwal.utils")

local function get_highlights(colors)
	local normal_fg = utils.ensure_contrast(colors.foreground, colors.background, 4.9)
	local panel_bg = utils.lighten(colors.background, 0.08)
	local subtle_bg = utils.lighten(colors.background, 0.05)
	local float_bg = colors.color0
	local float_fg = utils.ensure_contrast(normal_fg, float_bg, 4.9)
	local border_fg = utils.lighten(colors.color8, 0.25)
	local muted_fg = utils.ensure_contrast(utils.lighten(colors.color8, 0.23), colors.background, 4.9)
	local subtle_fg = utils.ensure_contrast(utils.lighten(colors.color8, 0.34), colors.background, 4.9)
	local popup_bg = utils.lighten(float_bg, 0.04)
	local popup_fg = utils.ensure_contrast(normal_fg, popup_bg, 4.9)
	local popup_bg_alt = utils.lighten(popup_bg, 0.08)
	local popup_border_fg = utils.ensure_contrast(colors.color9 or colors.color1, float_bg, 4.9)
	local popup_muted_fg = utils.ensure_contrast(utils.lighten(colors.color8, 0.26), popup_bg, 4.9)
	local popup_match_fg = popup_fg
	local popup_kind_fg = utils.ensure_contrast(colors.color10 or colors.color2, popup_bg, 4.9)
	local popup_kind_blue_fg = utils.ensure_contrast(colors.color12 or colors.color4, popup_bg, 4.9)
	local popup_kind_cyan_fg = utils.ensure_contrast(colors.color14 or colors.color6, popup_bg, 4.9)
	local popup_kind_yellow_fg = utils.ensure_contrast(colors.color11, popup_bg, 4.9)
	local popup_kind_magenta_fg = utils.ensure_contrast(colors.color13 or colors.color5, popup_bg, 4.9)
	local popup_kind_orange_fg = utils.ensure_contrast(colors.color9 or colors.color3, popup_bg, 4.9)
	local popup_sel_bg = utils.lighten(popup_bg, 0.28)
	local popup_sel_fg = utils.ensure_contrast(popup_fg, popup_sel_bg, 4.9)
	local search_bg = utils.lighten(colors.color11, 0.34)
	local search_fg = utils.ensure_contrast(colors.background, search_bg, 4.9)
	local incsearch_bg = utils.lighten(colors.color11, 0.4)
	local incsearch_fg = utils.ensure_contrast(colors.background, incsearch_bg, 4.9)
	local substitute_bg = utils.lighten(colors.color1, 0.4)
	local substitute_fg = utils.ensure_contrast(colors.background, substitute_bg, 4.9)
	local matchparen_bg = utils.lighten(colors.background, 0.3)
	local matchparen_fg = utils.ensure_contrast(utils.lighten(colors.foreground, 0.1), matchparen_bg, 4.9)
	local visual_bg = utils.lighten(colors.background, 0.30)
	local visual_fg = utils.ensure_contrast(normal_fg, visual_bg, 4.9)
	local tabline_sel_bg = utils.lighten(colors.background, 0.33)
	local tabline_sel_fg = utils.ensure_contrast(normal_fg, tabline_sel_bg, 4.9)
	local wildmenu_bg = utils.lighten(colors.color4, 0.36)
	local wildmenu_fg = utils.ensure_contrast(colors.background, wildmenu_bg, 4.9)
	local gitsigns_add_fg = utils.ensure_contrast(colors.color10 or colors.color2, colors.background, 4.9)
	local gitsigns_change_fg = utils.ensure_contrast(colors.color12 or colors.color6, colors.background, 4.9)
	local gitsigns_delete_fg = utils.ensure_contrast(colors.color9 or colors.color1, colors.background, 4.9)

	return {
		Normal = { fg = normal_fg, bg = colors.background },
		NormalNC = { link = "Normal" },
		NormalSB = { fg = normal_fg, bg = colors.color8 },
		NormalFloat = { fg = float_fg, bg = float_bg },
		FloatBorder = { fg = popup_border_fg, bg = float_bg },
		FloatTitle = { fg = float_fg, bg = float_bg, bold = true },
		FloatFooter = { fg = muted_fg, bg = float_bg },

		ColorColumn = { bg = utils.lighten(colors.background, 0.12) },
		Conceal = { fg = muted_fg },
		Cursor = { fg = colors.background, bg = colors.foreground },
		lCursor = { fg = colors.background, bg = colors.color3 },
		CursorIM = { fg = colors.background, bg = colors.color1 },
		CursorColumn = { bg = utils.lighten(colors.background, 0.12) },
		CursorLine = { bg = utils.lighten(colors.background, 0.12) },
		CursorLineFold = { link = "FoldColumn" },
		CursorLineSign = { link = "SignColumn" },

		Directory = { fg = utils.ensure_contrast(utils.lighten(colors.color4, 0.16), colors.background, 4.9) },
		EndOfBuffer = { fg = subtle_fg },
		VertSplit = { fg = border_fg },
		WinSeparator = { link = "VertSplit" },

		Folded = { fg = subtle_fg, bg = subtle_bg },
		FoldColumn = { fg = subtle_fg, bg = subtle_bg },
		LineNr = { fg = utils.lighten(colors.color8, 0.19) },
		CursorLineNr = { fg = utils.lighten(colors.color4, 0.36), bold = true },
		SignColumn = { fg = muted_fg, bg = colors.background },
		SignColumnSB = { fg = muted_fg, bg = subtle_bg },

		MatchParen = {
			fg = matchparen_fg,
			bg = matchparen_bg,
			bold = true,
		},

		Search = { fg = search_fg, bg = search_bg },
		IncSearch = { fg = incsearch_fg, bg = incsearch_bg, bold = true },
		CurSearch = { link = "IncSearch" },
		Substitute = { fg = substitute_fg, bg = substitute_bg },
		Visual = { fg = visual_fg, bg = visual_bg, bold = true },
		VisualNOS = { link = "Visual" },

		ErrorMsg = { fg = utils.lighten(colors.color1, 0.5), bold = true },
		WarningMsg = { fg = utils.lighten(colors.color11, 0.54), bold = true },
		ModeMsg = { fg = utils.lighten(colors.color13, 0.24), bold = true },
		MoreMsg = { fg = utils.lighten(colors.color13, 0.21) },
		Question = { fg = utils.lighten(colors.color11, 0.5), bold = true },
		MsgSeparator = { link = "StatusLineNC" },

		StatusLine = { fg = normal_fg, bg = utils.lighten(colors.background, 0.21) },
		StatusLineNC = { fg = utils.lighten(normal_fg, 0.1), bg = utils.lighten(colors.background, 0.1) },
		WinBar = { link = "Normal" },
		WinBarNC = { link = "NormalNC" },

		TabLine = { fg = utils.lighten(colors.color8, 0.27), bg = panel_bg },
		TabLineFill = { bg = panel_bg },
		TabLineSel = { fg = tabline_sel_fg, bg = tabline_sel_bg, bold = true },

		Pmenu = { fg = popup_fg, bg = popup_bg },
		PmenuSel = { fg = popup_sel_fg, bg = popup_sel_bg, bold = true },
		PmenuSbar = { bg = popup_bg_alt },
		PmenuThumb = { bg = utils.lighten(colors.color1, 0.14) },
		PmenuBorder = { fg = popup_border_fg, bg = popup_bg },
		PmenuExtra = { fg = popup_muted_fg, bg = popup_bg },
		PmenuExtraSel = { fg = popup_sel_fg, bg = popup_sel_bg, bold = true },
		PmenuKind = { fg = popup_kind_fg, bg = popup_bg },
		PmenuKindSel = { fg = popup_sel_fg, bg = popup_sel_bg, bold = true },
		PmenuMatch = { fg = popup_match_fg, bg = popup_bg, bold = true, underline = true },
		PmenuMatchSel = { fg = popup_sel_fg, bg = popup_sel_bg, bold = true, underline = true },
		PmenuCursorLine = { link = "PmenuSel" },

		CmpDocumentation = { fg = float_fg, bg = float_bg },
		CmpDocumentationBorder = { fg = popup_border_fg, bg = float_bg },
		CmpItemAbbr = { fg = popup_fg, bg = popup_bg },
		CmpItemAbbrDeprecated = { fg = popup_muted_fg, bg = popup_bg, strikethrough = true },
		CmpItemAbbrMatch = { fg = popup_match_fg, bg = popup_bg, bold = true, underline = true },
		CmpItemAbbrMatchFuzzy = { fg = popup_match_fg, bg = popup_bg, bold = true, italic = true, underline = true },
		CmpItemKind = { fg = popup_kind_fg, bg = popup_bg },
		CmpItemMenu = { fg = popup_muted_fg, bg = popup_bg, italic = true },

		CmpItemKindText = { fg = popup_fg, bg = popup_bg },
		CmpItemKindMethod = { fg = popup_kind_blue_fg, bg = popup_bg },
		CmpItemKindFunction = { fg = popup_kind_blue_fg, bg = popup_bg },
		CmpItemKindConstructor = { fg = popup_kind_blue_fg, bg = popup_bg },
		CmpItemKindField = { fg = popup_kind_cyan_fg, bg = popup_bg },
		CmpItemKindVariable = { fg = popup_fg, bg = popup_bg },
		CmpItemKindClass = { fg = popup_kind_magenta_fg, bg = popup_bg },
		CmpItemKindInterface = { fg = popup_kind_cyan_fg, bg = popup_bg },
		CmpItemKindModule = { fg = popup_kind_blue_fg, bg = popup_bg },
		CmpItemKindProperty = { fg = popup_kind_cyan_fg, bg = popup_bg },
		CmpItemKindUnit = { fg = popup_kind_yellow_fg, bg = popup_bg },
		CmpItemKindValue = { fg = popup_kind_yellow_fg, bg = popup_bg },
		CmpItemKindEnum = { fg = popup_kind_cyan_fg, bg = popup_bg },
		CmpItemKindKeyword = { fg = popup_kind_orange_fg, bg = popup_bg },
		CmpItemKindSnippet = { fg = popup_kind_fg, bg = popup_bg },
		CmpItemKindColor = { fg = popup_kind_magenta_fg, bg = popup_bg },
		CmpItemKindFile = { fg = popup_kind_blue_fg, bg = popup_bg },
		CmpItemKindReference = { fg = popup_kind_magenta_fg, bg = popup_bg },
		CmpItemKindFolder = { fg = popup_kind_blue_fg, bg = popup_bg },
		CmpItemKindEnumMember = { fg = popup_kind_cyan_fg, bg = popup_bg },
		CmpItemKindConstant = { fg = popup_kind_magenta_fg, bg = popup_bg },
		CmpItemKindStruct = { fg = popup_kind_magenta_fg, bg = popup_bg },
		CmpItemKindEvent = { fg = popup_kind_magenta_fg, bg = popup_bg },
		CmpItemKindOperator = { fg = popup_kind_cyan_fg, bg = popup_bg },
		CmpItemKindTypeParameter = { fg = popup_kind_orange_fg, bg = popup_bg },

		BlinkCmpMenu = { fg = popup_fg, bg = popup_bg },
		BlinkCmpMenuBorder = { fg = popup_border_fg, bg = popup_bg },
		BlinkCmpDoc = { fg = float_fg, bg = float_bg },
		BlinkCmpDocBorder = { fg = popup_border_fg, bg = float_bg },
		BlinkCmpLabel = { fg = popup_fg, bg = popup_bg },
		BlinkCmpLabelMatch = { fg = popup_match_fg, bg = popup_bg, bold = true, underline = true },
		BlinkCmpKind = { fg = popup_kind_fg, bg = popup_bg },
		BlinkCmpSource = { fg = popup_muted_fg, bg = popup_bg },
		BlinkCmpSignatureHelp = { fg = float_fg, bg = float_bg },
		BlinkCmpSignatureHelpBorder = { fg = popup_border_fg, bg = float_bg },

		QuickFixLine = { bg = utils.lighten(colors.color13, 0.23) },
		WildMenu = { fg = wildmenu_fg, bg = wildmenu_bg },
		Title = { fg = utils.lighten(colors.color11, 0.23), bold = true },

		NonText = { fg = utils.lighten(colors.color8, 0.29) },
		SpecialKey = { fg = utils.lighten(colors.color8, 0.38) },
		Whitespace = { fg = muted_fg },

		SpellBad = { undercurl = true, sp = utils.lighten(colors.color1, 0.53) },
		SpellCap = { undercurl = true, sp = utils.lighten(colors.color4, 0.37) },
		SpellLocal = { undercurl = true, sp = utils.lighten(colors.color14, 0.35) },
		SpellRare = { undercurl = true, sp = utils.lighten(colors.color13, 0.28) },

		TermCursor = { fg = colors.background, bg = colors.foreground },
		TermCursorNC = { fg = colors.background, bg = utils.lighten(colors.color8, 0.45) },
		Terminal = { fg = normal_fg, bg = colors.background },

		DiffAdd = { bg = utils.lighten(colors.color2, 0.2) },
		DiffChange = { bg = utils.lighten(colors.color3, 0.16) },
		DiffDelete = { bg = utils.lighten(colors.color1, 0.17) },
		DiffText = { bg = utils.lighten(colors.color10, 0.18) },

		GitSignsAdd = { fg = gitsigns_add_fg, bg = colors.background },
		GitSignsChange = { fg = gitsigns_change_fg, bg = colors.background },
		GitSignsDelete = { fg = gitsigns_delete_fg, bg = colors.background },
	}
end

function M.apply(colors)
	for group, settings in pairs(get_highlights(colors)) do
		vim.api.nvim_set_hl(0, group, settings)
	end
end

return M
