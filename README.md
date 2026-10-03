# StoneRose for Neovim

Soft color theme with stony blues and rosy reds.

Includes syntax highlighting, diagnostics, terminal colors, and styling for common Neovim plugins. Works with LazyVim and includes a matching lualine statusline theme.

Use Neovim 0.10 or newer with a true color terminal.

## Installation

### LazyVim

Create `~/.config/nvim/lua/plugins/stonerose.lua`:

```lua
return {
  {
    "ajguerrer/stonerose-nvim",
    lazy = false,
    priority = 1000,
  },
  {
    "LazyVim/LazyVim",
    opts = { colorscheme = "stonerose" },
  },
}
```

Restart Neovim. LazyVim's lualine configuration uses the included statusline theme automatically.

### lazy.nvim

Add this plugin to your configuration:

```lua
{
  "ajguerrer/stonerose-nvim",
  lazy = false,
  priority = 1000,
  config = function()
    vim.cmd.colorscheme("stonerose")
  end,
}
```

### Manual installation

On macOS or Linux, install the theme as a native Neovim package:

```sh
git clone https://github.com/ajguerrer/stonerose-nvim.git \
  "${XDG_DATA_HOME:-$HOME/.local/share}/nvim/site/pack/themes/start/stonerose"
```

Then add this to `init.lua`:

```lua
vim.cmd.colorscheme("stonerose")
```

## Statusline

Lualine detects the included theme when its theme option is set to `"auto"`. You can also select it explicitly:

```lua
require("lualine").setup({
  options = { theme = "stonerose" },
})
```

## Cursor color

To use StoneRose's blue cursor, add this to your configuration. In LazyVim, use `lua/config/options.lua`:

```lua
vim.opt.guicursor:append("a:Cursor/lCursor")
```

This keeps your existing cursor shapes and blink settings.

## Custom highlights

To customize a highlight, register an override before loading the colorscheme. For example, to turn off italic comments:

```lua
vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "stonerose",
  callback = function()
    vim.api.nvim_set_hl(0, "Comment", { fg = "#787880", italic = false })
  end,
})
```

## License

MIT. See [LICENSE](LICENSE).
