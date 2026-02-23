require("copilot").setup({
  suggestion = {
    enabled = true,
    auto_trigger = true,
    hide_during_completion = true,
    debounce = 75,
    keymap = {
      accept = "<M-l>",
      accept_word = "<M-k>",
      accept_line = "<M-j>",
      next = "<M-]>",
      prev = "<M-[>",
      dismiss = "<C-]>",
    },
  },
  panel = { enabled = false },
  filetypes = {
    yaml = true,
    markdown = true,
    gitcommit = false,
    gitrebase = false,
  },
})
