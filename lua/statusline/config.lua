if not Statusline then
  Statusline = {
    opts = {},
  }
end
return {
  defaults = {
    theme = "vscode",
    position_min_width = 140,
    overriden_modules = false,
    lsprogress_len = nil,
    git_changes_min_width = 120,
    LSP_progress_min_width = 120,
    icons = {
      modified = "",
      mode = "",
      default_file = "󰈚",
      git_branch = "",
      cwd = "󰉖",
      git_changes = { added = "", changed = "", removed = "" },
      lsp = "󰄭",
      diagnostics = {
        error = "󰅚",
        warn = "",
        hint = "󰛩",
        info = "",
      },
      spinners = {
        "",
        "󰪞",
        "󰪟",
        "󰪠",
        "󰪢",
        "󰪣",
        "󰪤",
        "󰪥",
      },
    },
  },
}
