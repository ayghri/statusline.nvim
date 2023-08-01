
# Neovim Status Line

This is a rewrite based on [NvChad ui](https://github.com/NvChad/ui). This is
more suitable for educational purposes to understand Neovim API and how plugins
work.

The statusline is returned by `templates.{choice}.run()`.

The modes and their highlights groups are in `modes.lua`.

All the helper functions to get modes, file info, LSP info, gits.. are
in `common.lua`

The file info section needs [web-devicons](https://github.com/nvim-tree/nvim-web-devicons)
to use filetype specific icons.

## Installation

- Lazy.nvim

```lua
{
  "aghriss/statusline.nvim",
  lazy = false,
  opts = {
        theme = "vscode"
  },
  dependencies = {
   "nvim-tree/nvim-web-devicons", -- for file name icon
  },

```

## Demo

![statusline](./doc/themes/vscode.png)
