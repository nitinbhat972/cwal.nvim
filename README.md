# cwal.nvim

`cwal.nvim` is a dynamic Neovim colorscheme that reads your generated `cwal` palette and applies it across core UI, syntax, Treesitter, diagnostics, completion popups, Bufferline, and Lualine.

> For now, only dark mode is supported.

## 🖼 Preview
<p align="center">
  <video src="https://github.com/user-attachments/assets/aecd76e1-882a-47f5-910c-3deabc40c76b"
alt="cwal.nvim showcase" width="700"/>
</p>
    
## ✨ Features

- Uses your live `cwal` colors from `colors-nvim.lua`
- Automatically reloads highlights when your `cwal.ini` changes
- Extensive highlight coverage for:
  - Core editor/UI groups
  - Vim syntax groups
  - Treesitter and semantic token groups
  - LSP diagnostics (`Diagnostic*` + legacy `LspDiagnostics*` links)
  - Popup/completion UI (`Pmenu*`, `Cmp*`, `BlinkCmp*`)
  - Bufferline (`BufferLine*`)
  - Lualine theme (`theme = "cwal"`)


## 📦 Requirements

- Neovim 0.10+
- [`cwal`](https://github.com/nitinbhat972/cwal)
- A working `cwal` setup that generates:
  - `~/.config/cwal/cwal.ini`
  - `colors-nvim.lua` inside your configured `out_dir`


## 🔧 Installing cwal

Install from the AUR:

```bash
paru -S cwal-git
```

or

```bash
yay -S cwal-git
```

## 🎨 Color Source

`cwal.nvim` reads `out_dir` from your `cwal.ini`, then loads:

```
<out_dir>/colors-nvim.lua
```

## 🚀 Installation

### lazy.nvim

```lua
{
  "nitinbhat972/cwal.nvim",
  priority = 1000,
  config = function()
    require("cwal").setup() -- defaults listed under Configuration below
    vim.cmd.colorscheme("cwal")
  end,
}
```

### vim.pack (Neovim 0.12+)

```lua
vim.pack.add({
  { src = "https://github.com/nitinbhat972/cwal.nvim" },
})

vim.cmd.colorscheme("cwal")
```

## ⚙️ Usage

Set the colorscheme:

```vim
:colorscheme cwal
```

or in Lua:

```lua
vim.cmd.colorscheme("cwal")
```

## 🔌 Lualine Integration

```lua
require("lualine").setup({
  options = {
    theme = "cwal",
  },
})
```

> The colorscheme defines most highlight groups, ensuring compatibility with the majority of plugins.  
> **Note:** Bufferline highlight groups are not refreshed automatically on colorscheme change and may require a Neovim restart.


## 🔄 How Reload Works

`cwal.nvim` watches:

```
<out_dir>/colors-nvim.lua
```

On change, it:

1. Reloads palette values from `colors-nvim.lua`
2. Reapplies all highlight groups
3. Reloads Lualine (if its theme is set to `"cwal"`)
4. Triggers the `CwalReload` `User` event


## 🔔 Events

You can hook into the reload process using the `CwalReload` `User` event. This is useful for refreshing other plugins or custom highlights that depend on the palette.

```lua
vim.api.nvim_create_autocmd("User", {
  pattern = "CwalReload",
  callback = function()
    -- Your custom logic here, e.g., refreshing a custom statusline or plugin
    print("Cwal colors have been reloaded!")
  end,
})
```


## 🛠 Troubleshooting

### `Color file not found: .../colors-nvim.lua`

- Check `out_dir` in your `cwal.ini`
- Confirm `<out_dir>/colors-nvim.lua` exists


## ⚙️ Configuration

```lua
require("cwal").setup({
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
})
```

Terminal colors are always applied from the palette. There is no flag for them.

Precedence order: palette, styles, transparent, sidebars/floats, terminal, overrides.

`:colorscheme cwal` preserves previously-set opts. Calling `setup()` with no arguments re-applies the stored opts.

Reload persistence: the watcher keeps your opts. When `colors-nvim.lua` changes, the palette reloads and the stored opts are re-applied.

### sidebars / floats

| Value | Background |
| --- | --- |
| `dark` | current palette bgs |
| `normal` | Normal background |
| `transparent` | none |

`normal` intentionally differs from today's distinct sidebar/float bgs (tokyonight parity).


## 📄 License

Licensed under GNU GPL v3.0 — always free and open-source.

Star the project on GitHub if you find it useful!
