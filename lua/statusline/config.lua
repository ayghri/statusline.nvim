if not Statusline then Statusline = {
  opts = {},
} end
return {
  defaults = {
    theme = "vscode",
    position_min_width = 140,
    overriden_modules = false,
    lsprogress_len = nil,
    default_file_icon = "󰈚",
    mode_icon = "",
    git_branch_icon = "",
    LSP_icon = "󰄭",
    git_changes_min_width = 120,
    LSP_progress_min_width = 120,
    cwd_icon = "󰉖",
    git_changes_icons = { added = "", changed = "", removed = "" },
    diagnostics_icons = {
      error = "󰅚",
      warn = "",
      hint = "󰛩",
      info = "",
    },
    LSP_spinners = {
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
}
