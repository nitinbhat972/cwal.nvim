local M = {}

function M.get_config_path()
	local path = vim.fn.expand("~/.config/cwal/cwal.ini")
	if vim.fn.filereadable(path) == 1 then
		return path
	end

	return nil, "cwal.ini not found at: " .. path
end

local function get_out_dir(config_path)
	local file = io.open(config_path, "r")
	if not file then
		return nil, "Unable to open cwal config: " .. config_path
	end

	local in_general = false
	for line in file:lines() do
		local section = line:match("^%s*%[(.-)%]%s*$")
		if section then
			in_general = section == "general"
		elseif in_general then
			local value = line:match("^%s*out_dir%s*=%s*(.-)%s*$")
			if value and value ~= "" then
				file:close()
				value = value:gsub('^"(.*)"$', "%1")
				value = value:gsub("^'(.*)'$", "%1")
				return vim.fn.expand(value)
			end
		end
	end

	file:close()
	return nil, "out_dir not found in [general] of: " .. config_path
end

function M.get_colors_path()
	local config_path, config_err = M.get_config_path()
	if not config_path then
		return nil, config_err
	end

	local out_dir, out_err = get_out_dir(config_path)
	if not out_dir then
		return nil, out_err
	end

	local clean_out_dir = out_dir:gsub("/+$", "")
	return clean_out_dir .. "/colors-nvim.lua"
end

function M.load_colors()
	local path, path_err = M.get_colors_path()
	if not path then
		return nil, path_err
	end

	if vim.fn.filereadable(path) == 0 then
		return nil, "Color file not found: " .. path
	end

	local ok, colors = pcall(dofile, path)
	if not ok then
		return nil, "Failed to load color file: " .. colors
	end

	if type(colors) ~= "table" then
		return nil, "Color file did not return a table: " .. path
	end

	return colors
end

return M
