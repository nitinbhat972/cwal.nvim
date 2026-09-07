local M = {}

M.defaults = {
	transparent = false,
	styles = {
		comments = { italic = true },
		keywords = { italic = true },
		functions = {},
		variables = {},
		sidebars = "dark",
		floats = "dark",
	},
	overrides = {},
}

M.opts = vim.deepcopy(M.defaults)

local valid_sides = { dark = true, normal = true, transparent = true }

function M.setup(opts)
	if type(opts) ~= "table" then
		opts = {}
	end
	M.opts = vim.tbl_deep_extend("force", vim.deepcopy(M.defaults), opts)
	local raw_styles = type(opts.styles) == "table" and opts.styles or {}

	M.opts.transparent = M.opts.transparent == true

	if type(M.opts.styles) ~= "table" then
		M.opts.styles = {}
	end
	for _, key in ipairs({ "sidebars", "floats" }) do
		local val = M.opts.styles[key]
		if val == nil then
			M.opts.styles[key] = "dark"
		elseif not valid_sides[val] then
			M.opts.styles[key] = "dark"
			vim.notify('[cwal] Invalid styles.' .. key .. ' "' .. tostring(val) .. '", falling back to "dark".', vim.log.levels.WARN)
		end
	end
	for _, key in ipairs({ "comments", "keywords", "functions", "variables" }) do
		if type(raw_styles[key]) == "table" then
			M.opts.styles[key] = vim.deepcopy(raw_styles[key])
		elseif M.opts.styles[key] == nil then
			M.opts.styles[key] = {}
		elseif type(M.opts.styles[key]) ~= "table" then
			M.opts.styles[key] = {}
		end
	end

	if type(M.opts.overrides) ~= "table" then
		M.opts.overrides = {}
	end
end

function M.validate(colors)
	local required = { "background", "foreground" }
	for i = 0, 15 do
		required[#required + 1] = "color" .. i
	end
	local missing = {}
	for _, key in ipairs(required) do
		if type(colors) ~= "table" or colors[key] == nil then
			missing[#missing + 1] = key
		end
	end
	if #missing > 0 then
		vim.notify("[cwal] Missing color keys: " .. table.concat(missing, ", "), vim.log.levels.ERROR)
		return false
	end
	return true
end

return M
