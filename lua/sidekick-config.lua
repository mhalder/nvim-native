-- Subtle border for sidekick float
vim.api.nvim_set_hl(0, "SidekickBorder", { fg = "#292e42" })

-- Zero out leader key timeout in sidekick terminal buffers
vim.api.nvim_create_autocmd("BufEnter", {
  callback = function(ev)
    if vim.bo[ev.buf].filetype == "sidekick_terminal" then
      vim.o.timeoutlen = 0
    end
  end,
})
vim.api.nvim_create_autocmd("BufLeave", {
  callback = function(ev)
    if vim.bo[ev.buf].filetype == "sidekick_terminal" then
      vim.o.timeoutlen = 500
    end
  end,
})

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
