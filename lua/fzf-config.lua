require("fzf-lua").setup({
  grep = {
    rg_glob = true,
    glob_flag = "--iglob",
    glob_separator = "%s%-%-",
  },
})

-- Use fzf-lua for vim.ui.select (sidekick, LSP actions, etc.)
require("fzf-lua").register_ui_select()
