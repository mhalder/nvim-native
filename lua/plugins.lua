-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  { "stevearc/conform.nvim" },
  { "zbirenbaum/copilot.lua" },
  { "rafamadriz/friendly-snippets" },
  { "folke/lazydev.nvim" },
  { "L3MON4D3/LuaSnip" },
  { "mason-org/mason-lspconfig.nvim" },
  { "WhoIsSethDaniel/mason-tool-installer.nvim" },
  { "mason-org/mason.nvim" },
  { "echasnovski/mini.nvim" },
  { "mfussenegger/nvim-lint" },
  { "neovim/nvim-lspconfig" },
  { "stevearc/quicker.nvim" },
  { "folke/sidekick.nvim" },
  { "folke/tokyonight.nvim" },
  { "folke/trouble.nvim" },
}, {
  defaults = { lazy = false },
  install = { colorscheme = { "tokyonight" } },
})
