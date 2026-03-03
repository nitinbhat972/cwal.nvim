local M = {}
local utils = require("cwal.utils")

local function get_highlights(colors)
	local main_bg = colors.background

	local error_fg = utils.readable(colors.color9 or colors.color1, main_bg, 4.9)
	local warn_fg = utils.readable(colors.color11 or colors.color3, main_bg, 4.9)
	local info_fg = utils.readable(colors.color12 or colors.color4, main_bg, 4.9)
	local hint_fg = utils.readable(colors.color14 or colors.color6, main_bg, 4.9)
	local ok_fg = utils.readable(colors.color10 or colors.color2, main_bg, 4.9)

	local reference_bg = utils.ensure_contrast(utils.lighten(main_bg, 0.12), main_bg, 1.35)
	local inlay_bg = utils.ensure_contrast(utils.lighten(main_bg, 0.08), main_bg, 1.2)
	local inlay_fg = utils.ensure_contrast(colors.color8, inlay_bg, 4.9)

	local signature_bg = utils.ensure_contrast(utils.lighten(main_bg, 0.22), main_bg, 1.55)
	local signature_fg = utils.ensure_contrast(colors.color10 or colors.color2, signature_bg, 4.9)

	local code_lens_fg = utils.readable(colors.color10 or colors.color2, main_bg, 4.9)
	local code_lens_sep_fg = utils.readable(colors.color8, main_bg, 4.9)

	return {
		DiagnosticError = { fg = error_fg },
		DiagnosticWarn = { fg = warn_fg },
		DiagnosticInfo = { fg = info_fg },
		DiagnosticHint = { fg = hint_fg },
		DiagnosticOk = { fg = ok_fg },

		DiagnosticSignError = { fg = error_fg, bg = main_bg },
		DiagnosticSignWarn = { fg = warn_fg, bg = main_bg },
		DiagnosticSignInfo = { fg = info_fg, bg = main_bg },
		DiagnosticSignHint = { fg = hint_fg, bg = main_bg },
		DiagnosticSignOk = { fg = ok_fg, bg = main_bg },

		DiagnosticVirtualTextError = { fg = error_fg, bold = true },
		DiagnosticVirtualTextWarn = { fg = warn_fg, bold = true },
		DiagnosticVirtualTextInfo = { fg = info_fg, bold = true },
		DiagnosticVirtualTextHint = { fg = hint_fg, bold = true },
		DiagnosticVirtualTextOk = { fg = ok_fg, bold = true },

		DiagnosticUnderlineError = { undercurl = true, sp = error_fg },
		DiagnosticUnderlineWarn = { undercurl = true, sp = warn_fg },
		DiagnosticUnderlineInfo = { undercurl = true, sp = info_fg },
		DiagnosticUnderlineHint = { undercurl = true, sp = hint_fg },
		DiagnosticUnderlineOk = { undercurl = true, sp = ok_fg },

		DiagnosticFloatingError = { fg = error_fg },
		DiagnosticFloatingWarn = { fg = warn_fg },
		DiagnosticFloatingInfo = { fg = info_fg },
		DiagnosticFloatingHint = { fg = hint_fg },
		DiagnosticFloatingOk = { fg = ok_fg },

		DiagnosticDeprecated = { fg = utils.readable(colors.color8, main_bg, 4.9), strikethrough = true },
		DiagnosticUnnecessary = { fg = utils.readable(colors.color8, main_bg, 4.9), italic = true },

		LspReferenceText = { fg = utils.ensure_contrast(colors.foreground, reference_bg, 4.9), bg = reference_bg },
		LspReferenceRead = { link = "LspReferenceText" },
		LspReferenceWrite = { link = "LspReferenceText" },

		LspInlayHint = { fg = inlay_fg, bg = inlay_bg, italic = true },
		LspCodeLens = { fg = code_lens_fg, italic = true },
		LspCodeLensSeparator = { fg = code_lens_sep_fg },

		LspSignatureActiveParameter = {
			fg = signature_fg,
			bg = signature_bg,
			bold = true,
		},
		LspRename = { link = "IncSearch" },
		LspInfoBorder = { fg = info_fg, bg = colors.color0 },

		LspDiagnosticsDefaultError = { link = "DiagnosticError" },
		LspDiagnosticsDefaultWarning = { link = "DiagnosticWarn" },
		LspDiagnosticsDefaultInformation = { link = "DiagnosticInfo" },
		LspDiagnosticsDefaultHint = { link = "DiagnosticHint" },

		LspDiagnosticsSignError = { link = "DiagnosticSignError" },
		LspDiagnosticsSignWarning = { link = "DiagnosticSignWarn" },
		LspDiagnosticsSignInformation = { link = "DiagnosticSignInfo" },
		LspDiagnosticsSignHint = { link = "DiagnosticSignHint" },

		LspDiagnosticsVirtualTextError = { link = "DiagnosticVirtualTextError" },
		LspDiagnosticsVirtualTextWarning = { link = "DiagnosticVirtualTextWarn" },
		LspDiagnosticsVirtualTextInformation = { link = "DiagnosticVirtualTextInfo" },
		LspDiagnosticsVirtualTextHint = { link = "DiagnosticVirtualTextHint" },

		LspDiagnosticsUnderlineError = { link = "DiagnosticUnderlineError" },
		LspDiagnosticsUnderlineWarning = { link = "DiagnosticUnderlineWarn" },
		LspDiagnosticsUnderlineInformation = { link = "DiagnosticUnderlineInfo" },
		LspDiagnosticsUnderlineHint = { link = "DiagnosticUnderlineHint" },
	}
end

function M.apply(colors)
	for group, settings in pairs(get_highlights(colors)) do
		vim.api.nvim_set_hl(0, group, settings)
	end
end

return M
