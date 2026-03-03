local M = {}

local function normalize_hex(hex, fallback)
    if type(hex) ~= "string" then
        return fallback or "#000000"
    end

    local cleaned = hex:lower():match("^%s*(.-)%s*$")
    if cleaned:match("^#%x%x%x%x%x%x$") then
        return cleaned
    end
    if cleaned:match("^%x%x%x%x%x%x$") then
        return "#" .. cleaned
    end

    return fallback or "#000000"
end

-- Helper to convert hex color to RGB table
local function hex_to_rgb(hex, fallback)
    local safe_hex = normalize_hex(hex, fallback)
    safe_hex = safe_hex:gsub("#", "")

    local r = tonumber(safe_hex:sub(1, 2), 16) or 0
    local g = tonumber(safe_hex:sub(3, 4), 16) or 0
    local b = tonumber(safe_hex:sub(5, 6), 16) or 0

    return { r = r, g = g, b = b }
end

local function channel_to_linear(channel)
    channel = channel / 255
    if channel <= 0.03928 then
        return channel / 12.92
    end
    return ((channel + 0.055) / 1.055) ^ 2.4
end

local function relative_luminance(hex)
    local rgb = hex_to_rgb(hex)
    local r = channel_to_linear(rgb.r)
    local g = channel_to_linear(rgb.g)
    local b = channel_to_linear(rgb.b)
    return (0.2126 * r) + (0.7152 * g) + (0.0722 * b)
end

-- Helper to convert RGB table to hex color
local function rgb_to_hex(rgb)
    return string.format("#%02x%02x%02x", rgb.r, rgb.g, rgb.b)
end

-- Lighten a hex color by a given percentage
function M.lighten(hex, amount)
    amount = math.max(0, math.min(1, amount or 0))
    local rgb = hex_to_rgb(hex)

    rgb.r = math.floor(math.min(255, rgb.r + (255 - rgb.r) * amount) + 0.5)
    rgb.g = math.floor(math.min(255, rgb.g + (255 - rgb.g) * amount) + 0.5)
    rgb.b = math.floor(math.min(255, rgb.b + (255 - rgb.b) * amount) + 0.5)

    return rgb_to_hex(rgb)
end

-- Darken a hex color by a given percentage
function M.darken(hex, amount)
    amount = math.max(0, math.min(1, amount or 0))
    local rgb = hex_to_rgb(hex)

    rgb.r = math.floor(math.max(0, rgb.r - rgb.r * amount) + 0.5)
    rgb.g = math.floor(math.max(0, rgb.g - rgb.g * amount) + 0.5)
    rgb.b = math.floor(math.max(0, rgb.b - rgb.b * amount) + 0.5)

    return rgb_to_hex(rgb)
end

function M.contrast_ratio(hex_a, hex_b)
    hex_a = normalize_hex(hex_a, "#000000")
    hex_b = normalize_hex(hex_b, "#000000")

    local luminance_a = relative_luminance(hex_a)
    local luminance_b = relative_luminance(hex_b)
    local lighter = math.max(luminance_a, luminance_b)
    local darker = math.min(luminance_a, luminance_b)
    return (lighter + 0.05) / (darker + 0.05)
end

function M.ensure_contrast(fg, bg, min_ratio)
    min_ratio = min_ratio or 4.9
    bg = normalize_hex(bg, "#000000")

    local bg_is_dark = relative_luminance(bg) < 0.5
    local fallback_fg = bg_is_dark and "#ffffff" or "#000000"
    fg = normalize_hex(fg, fallback_fg)

    if M.contrast_ratio(fg, bg) >= min_ratio then
        return fg
    end

    local function try_adjust(base_fg, adjust)
        for step = 1, 20 do
            local amount = step * 0.05
            local candidate = adjust(base_fg, amount)
            if M.contrast_ratio(candidate, bg) >= min_ratio then
                return candidate
            end
        end
        return nil
    end

    local primary_adjust = bg_is_dark and M.lighten or M.darken
    local secondary_adjust = bg_is_dark and M.darken or M.lighten

    local candidate = try_adjust(fg, primary_adjust)
    if candidate then
        return candidate
    end

    candidate = try_adjust(fg, secondary_adjust)
    if candidate then
        return candidate
    end

    local alternate_fg = bg_is_dark and "#000000" or "#ffffff"
    if M.contrast_ratio(fallback_fg, bg) >= M.contrast_ratio(alternate_fg, bg) then
        return fallback_fg
    end

    return alternate_fg
end

function M.readable(hex, bg, min_ratio)
    return M.ensure_contrast(hex, bg, min_ratio)
end

function M.readable_tones(hex, backgrounds, min_ratio)
    return {
        default = M.ensure_contrast(hex, backgrounds.default, min_ratio),
        visible = M.ensure_contrast(hex, backgrounds.visible, min_ratio),
        selected = M.ensure_contrast(hex, backgrounds.selected, min_ratio),
    }
end

return M
