-- Subtle border for sidekick float — syncs with colorscheme
local function set_sidekick_border()
  local hl = vim.api.nvim_get_hl(0, { name = "CursorLine", link = false })
  vim.api.nvim_set_hl(0, "SidekickBorder", { fg = hl.bg })
end
set_sidekick_border()
vim.api.nvim_create_autocmd("ColorScheme", { callback = set_sidekick_border })

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
