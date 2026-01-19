-- Build hooks for plugins that need compilation
vim.api.nvim_create_autocmd("PackChanged", {
  callback = function(ev)
    local name, kind = ev.data.spec.name, ev.data.kind
    if name == "blink.cmp" and (kind == "install" or kind == "update") then
      vim.system({ "cargo", "build", "--release" }, { cwd = ev.data.path }):wait()
    end
    if name == "markdown-preview.nvim" and (kind == "install" or kind == "update") then
      vim.system({ "npm", "install" }, { cwd = ev.data.path .. "/app" }):wait()
    end
  end,
})

vim.pack.add({
  { src = "https://github.com/saghen/blink.cmp" },
  { src = "https://github.com/stevearc/conform.nvim" },
  { src = "https://github.com/zbirenbaum/copilot.lua" },
  { src = "https://github.com/rafamadriz/friendly-snippets" },
  { src = "https://github.com/folke/lazydev.nvim" },
  { src = "https://github.com/L3MON4D3/LuaSnip" },
  { src = "https://github.com/mason-org/mason-lspconfig.nvim" },
  { src = "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim" },
  { src = "https://github.com/mason-org/mason.nvim" },
  { src = "https://github.com/iamcco/markdown-preview.nvim" },
  { src = "https://github.com/echasnovski/mini.nvim" },
  { src = "https://github.com/obsidian-nvim/obsidian.nvim" },
  { src = "https://github.com/leoluz/nvim-dap-go" },
  { src = "https://github.com/mfussenegger/nvim-dap" },
  { src = "https://github.com/mfussenegger/nvim-dap-python" },
  { src = "https://github.com/mfussenegger/nvim-lint" },
  { src = "https://github.com/rcarriga/nvim-dap-ui" },
  { src = "https://github.com/nvim-neotest/nvim-nio" },
  { src = "https://github.com/theHamsta/nvim-dap-virtual-text" },
  { src = "https://github.com/neovim/nvim-lspconfig" },
  { src = "https://github.com/nvim-treesitter/nvim-treesitter" },
  { src = "https://github.com/stevearc/quicker.nvim" },
  { src = "https://github.com/folke/sidekick.nvim" },
  { src = "https://github.com/folke/tokyonight.nvim" },
  { src = "https://github.com/folke/trouble.nvim" },
  { src = "https://github.com/christoomey/vim-tmux-navigator" },
})
