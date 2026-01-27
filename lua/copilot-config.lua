require("copilot").setup({
  suggestion = { enabled = false },
  panel = { enabled = false },
  filetypes = {
    yaml = true,
    markdown = true,
    gitcommit = false,
    gitrebase = false,
  },
})
