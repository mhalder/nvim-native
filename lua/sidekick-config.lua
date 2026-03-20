-- Subtle border for sidekick float
vim.api.nvim_set_hl(0, "SidekickBorder", { fg = "#292e42" })

require("sidekick").setup({
  nes = { enabled = false },
  cli = {
    tools = {
      claude = {
        cmd = { "claude", "--add-dir", vim.fn.expand("~/vaults/claude") },
      },
    },
    win = {
      layout = "float",
      float = {
        width = 0.9,
        height = 0.9,
        border = "rounded",
        title = "",
      },
      wo = {
        winhighlight = "FloatBorder:SidekickBorder",
      },
    },
    mux = {
      backend = "tmux",
      enabled = true,
    },
  },
})
