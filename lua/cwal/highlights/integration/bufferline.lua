local M = {}
local utils = require("cwal.utils")

local function get_highlights(colors)
	local default_bg = colors.color0
	local visible_bg = utils.lighten(colors.color0, 0.08)
	local selected_bg = utils.lighten(colors.color0, 0.22)
	local backgrounds = {
		default = default_bg,
		visible = visible_bg,
		selected = selected_bg,
	}

	local base = utils.readable_tones(colors.color8, backgrounds, 4.9)
	local selected_fg = utils.readable(colors.foreground, selected_bg, 4.9)
	local trunc_fg = utils.readable(colors.color8, default_bg, 4.9)

	local pick = utils.readable_tones(colors.color11, backgrounds, 4.9)
	local info = utils.readable_tones(colors.color12 or colors.color4, backgrounds, 4.9)
	local hint = utils.readable_tones(colors.color14 or colors.color6, backgrounds, 4.9)
	local warn = utils.readable_tones(colors.color11 or colors.color3, backgrounds, 4.9)
	local err = utils.readable_tones(colors.color9 or colors.color1, backgrounds, 4.9)
	local modified = utils.readable_tones(colors.color11 or colors.color3, backgrounds, 4.9)

	return {
		BufferLineFill = { bg = default_bg },
		BufferLineBackground = { fg = base.default, bg = default_bg },
		BufferLineBufferVisible = { fg = base.visible, bg = visible_bg },
		BufferLineBufferSelected = { fg = selected_fg, bg = selected_bg, bold = true, italic = true },

		BufferLineTab = { fg = base.default, bg = default_bg },
		BufferLineTabSelected = { fg = selected_fg, bg = selected_bg, bold = true },
		BufferLineTabClose = { fg = err.default, bg = default_bg },
		BufferLineCloseButton = { fg = base.default, bg = default_bg },
		BufferLineCloseButtonVisible = { fg = base.visible, bg = visible_bg },
		BufferLineCloseButtonSelected = { fg = err.selected, bg = selected_bg },

		BufferLineSeparator = { fg = default_bg, bg = default_bg },
		BufferLineSeparatorVisible = { fg = visible_bg, bg = visible_bg },
		BufferLineSeparatorSelected = { fg = selected_bg, bg = selected_bg },
		BufferLineIndicatorSelected = { fg = info.selected, bg = selected_bg },
		BufferLineOffsetSeparator = { fg = default_bg, bg = default_bg },
		BufferLineTruncMarker = { fg = trunc_fg, bg = default_bg },

		BufferLineModified = { fg = modified.default, bg = default_bg },
		BufferLineModifiedVisible = { fg = modified.visible, bg = visible_bg },
		BufferLineModifiedSelected = { fg = modified.selected, bg = selected_bg },

		BufferLineDuplicate = { fg = base.default, bg = default_bg, italic = true },
		BufferLineDuplicateVisible = { fg = base.visible, bg = visible_bg, italic = true },
		BufferLineDuplicateSelected = { fg = selected_fg, bg = selected_bg, italic = true },

		BufferLinePick = { fg = pick.default, bg = default_bg, bold = true },
		BufferLinePickVisible = { fg = pick.visible, bg = visible_bg, bold = true },
		BufferLinePickSelected = { fg = pick.selected, bg = selected_bg, bold = true },

		BufferLineFileIcon = { fg = info.default, bg = default_bg },
		BufferLineFileIconVisible = { fg = info.visible, bg = visible_bg },
		BufferLineFileIconSelected = { fg = info.selected, bg = selected_bg },
		BufferLineNumbers = { fg = base.default, bg = default_bg },
		BufferLineNumbersVisible = { fg = base.visible, bg = visible_bg },
		BufferLineNumbersSelected = { fg = selected_fg, bg = selected_bg },

		BufferLineDiagnostic = { fg = base.default, bg = default_bg, italic = true },
		BufferLineDiagnosticVisible = { fg = base.visible, bg = visible_bg, italic = true },
		BufferLineDiagnosticSelected = { fg = selected_fg, bg = selected_bg, italic = true },

		BufferLineHint = { fg = hint.default, bg = default_bg },
		BufferLineHintVisible = { fg = hint.visible, bg = visible_bg },
		BufferLineHintSelected = { fg = hint.selected, bg = selected_bg },
		BufferLineHintDiagnostic = { fg = hint.default, bg = default_bg },
		BufferLineHintDiagnosticVisible = { fg = hint.visible, bg = visible_bg },
		BufferLineHintDiagnosticSelected = { fg = hint.selected, bg = selected_bg },

		BufferLineInfo = { fg = info.default, bg = default_bg },
		BufferLineInfoVisible = { fg = info.visible, bg = visible_bg },
		BufferLineInfoSelected = { fg = info.selected, bg = selected_bg },
		BufferLineInfoDiagnostic = { fg = info.default, bg = default_bg },
		BufferLineInfoDiagnosticVisible = { fg = info.visible, bg = visible_bg },
		BufferLineInfoDiagnosticSelected = { fg = info.selected, bg = selected_bg },

		BufferLineWarning = { fg = warn.default, bg = default_bg },
		BufferLineWarningVisible = { fg = warn.visible, bg = visible_bg },
		BufferLineWarningSelected = { fg = warn.selected, bg = selected_bg },
		BufferLineWarningDiagnostic = { fg = warn.default, bg = default_bg },
		BufferLineWarningDiagnosticVisible = { fg = warn.visible, bg = visible_bg },
		BufferLineWarningDiagnosticSelected = { fg = warn.selected, bg = selected_bg },

		BufferLineError = { fg = err.default, bg = default_bg },
		BufferLineErrorVisible = { fg = err.visible, bg = visible_bg },
		BufferLineErrorSelected = { fg = err.selected, bg = selected_bg },
		BufferLineErrorDiagnostic = { fg = err.default, bg = default_bg },
		BufferLineErrorDiagnosticVisible = { fg = err.visible, bg = visible_bg },
		BufferLineErrorDiagnosticSelected = { fg = err.selected, bg = selected_bg },
	}
end

local function resolve_style(opts, key)
	local val = opts and opts.styles and opts.styles[key]
	if val == "dark" or val == "normal" or val == "transparent" then
		return val
	end
	if val ~= nil then
		vim.notify('[cwal] Invalid styles.' .. key .. ' "' .. tostring(val) .. '", falling back to "dark".', vim.log.levels.WARN)
	end
	return "dark"
end

function M.apply(colors, opts)
	local sidebars = resolve_style(opts, "sidebars")
	for group, settings in pairs(get_highlights(colors)) do
		if group:sub(1, 10) == "BufferLine" then
			if sidebars == "normal" then
				settings.bg = colors.background
			elseif sidebars == "transparent" then
				settings.bg = nil
			end
		end
		vim.api.nvim_set_hl(0, group, settings)
	end
end

return M
