require("lazydev").setup({
  library = {
    { path = "${3rd}/luv/library", words = { "vim%.uv" } },
    { path = "conform.nvim", words = { "conform" } },
  },
})

require("mason").setup({
  ui = {
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗",
    },
  },
})

require("mason-lspconfig").setup({
  ensure_installed = { "lua_ls", "ts_ls", "basedpyright" },
  handlers = {
    function(server_name)
      require("lspconfig")[server_name].setup({})
    end,
  },
})

require("mason-tool-installer").setup({
  ensure_installed = {
    -- formatters
    "stylua",
    "prettierd",
    "shfmt",
    -- linters
    "selene",
    "eslint_d",
    "shellcheck",
  },
})
