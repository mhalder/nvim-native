local actions = require("fzf-lua").actions

-- selene: allow(mixed_table)
require("fzf-lua").setup({
  "fzf-native",
  fzf_opts = { ["--tiebreak"] = "length" },
  grep = {
    rg_glob = true,
    glob_flag = "--iglob",
    glob_separator = "%s%-%-",
    fzf_opts = { ["--nth"] = "3.." },
    actions = {
      ["ctrl-r"] = { actions.toggle_ignore },
    },
  },
  buffers = {
    actions = {
      ["ctrl-d"] = { fn = actions.buf_del, reload = true },
      ["ctrl-x"] = false,
    },
  },
})

-- Use fzf-lua for vim.ui.select (sidekick, LSP actions, etc.)
require("fzf-lua").register_ui_select()
