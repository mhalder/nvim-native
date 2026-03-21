-- Subtle border for sidekick float — syncs with colorscheme
local function set_sidekick_border()
  local hl = vim.api.nvim_get_hl(0, { name = "CursorLine", link = false })
  vim.api.nvim_set_hl(0, "SidekickBorder", { fg = hl.bg })
end
set_sidekick_border()
vim.api.nvim_create_autocmd("ColorScheme", { callback = set_sidekick_border })

-- Zero out leader key timeout in sidekick terminal buffers
local saved_timeoutlen
vim.api.nvim_create_autocmd("BufEnter", {
  callback = function(ev)
    if vim.bo[ev.buf].filetype == "sidekick_terminal" then
      saved_timeoutlen = vim.o.timeoutlen
      vim.o.timeoutlen = 0
    end
  end,
})
vim.api.nvim_create_autocmd("BufLeave", {
  callback = function(ev)
    if vim.bo[ev.buf].filetype == "sidekick_terminal" then
      vim.o.timeoutlen = saved_timeoutlen or 500
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
