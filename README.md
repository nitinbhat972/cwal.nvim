# cwal.nvim

`cwal.nvim` is a dynamic Neovim colorscheme that reads your generated `cwal` palette and applies it across core UI, syntax, Treesitter, diagnostics, completion popups, Bufferline, and Lualine.

> For now, only dark mode is supported.
---

## 🖼 Preview

<p align="center">
  <video src="https://github.com/user-attachments/assets/87fe8cfe-c4a3-4117-9c6e-b5f6e266d28e"
alt="cwal.nvim showcase" width="700"/>
</p>
---

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

---

## 📦 Requirements

- Neovim 0.10+
- [`cwal`](https://github.com/nitinbhat972/cwal)
- A working `cwal` setup that generates:
  - `~/.config/cwal/cwal.ini`
  - `colors-nvim.lua` inside your configured `out_dir`

---

## 🔧 Installing cwal

Install from the AUR:

```bash
paru -S cwal
```

or

```bash
yay -S cwal
```

---

## 🎨 Color Source

`cwal.nvim` reads `out_dir` from your `cwal.ini`, then loads:

```
<out_dir>/colors-nvim.lua
```

---

## 🚀 Installation

### lazy.nvim

```lua
{
  "nitinbhat972/cwal.nvim",
  priority = 1000,
  config = function()
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

---

## ⚙️ Usage

Set the colorscheme:

```vim
:colorscheme cwal
```

or in Lua:

```lua
vim.cmd.colorscheme("cwal")
```

---

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

---

## 🔄 How Reload Works

`cwal.nvim` watches:

```
~/.config/cwal/cwal.ini
```

On change, it:

1. Reloads palette values from `colors-nvim.lua`
2. Reapplies all highlight groups
3. Reloads Lualine (if its theme is set to `"cwal"`)



---

## 🛠 Troubleshooting

### `Color file not found: .../colors-nvim.lua`

- Check `out_dir` in your `cwal.ini`
- Confirm `<out_dir>/colors-nvim.lua` exists

---

## 📝 Notes

- No user options are required at the moment.
- The plugin is intentionally palette-driven — regenerate your `cwal` colors and Neovim follows.

---

## 📄 License

Licensed under GNU GPL v3.0 — always free and open-source.

Star the project on GitHub if you find it useful!

