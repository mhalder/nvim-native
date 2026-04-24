local function ensure_path(parts)
  for _, part in ipairs(parts) do
    if not vim.env.PATH:find(part, 1, true) then
      vim.env.PATH = part .. ":" .. vim.env.PATH
    end
  end
end

local function build_blink(path)
  local home = vim.uv.os_homedir()
  ensure_path({ home .. "/.local/bin", home .. "/.cargo/bin" })

  if vim.fn.executable("cargo") ~= 1 then
    vim.notify("cargo missing; cannot build blink.cmp native library", vim.log.levels.ERROR)
    return
  end

  vim.notify("Building blink.cmp native library", vim.log.levels.INFO)
  local obj = vim.system({ "cargo", "build", "--release" }, { cwd = path }):wait()
  if obj.code ~= 0 then
    local msg = obj.stderr ~= "" and obj.stderr or obj.stdout
    vim.notify("blink.cmp native build failed:\n" .. msg, vim.log.levels.ERROR)
    return
  end

  local native = require("blink.lib.native")
  local commit = native.git_commit(path)
  local platform = native.platform()
  local src = path .. "/target/release/libblink_cmp_fuzzy" .. platform.lib_extension
  local dst = native.library_path("blink_cmp_fuzzy", commit)
  native.mv(src, dst)
  vim.notify("blink.cmp native library built", vim.log.levels.INFO)
end

local function run_pack_build(ev)
  local name, kind = ev.data.spec.name, ev.data.kind
  if kind ~= "install" and kind ~= "update" then
    return
  end

  vim.schedule(function()
    if name == "blink.cmp" then
      build_blink(ev.data.path)
    end
    if name == "markdown-preview.nvim" then
      vim.system({ "npm", "install" }, { cwd = ev.data.path .. "/app" }):wait()
    end
  end)
end

-- Build hooks for plugins that need compilation
vim.api.nvim_create_autocmd("PackChanged", {
  callback = run_pack_build,
})

vim.cmd.packadd("nvim.difftool")

vim.pack.add({
  { src = "https://github.com/saghen/blink.lib" },
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
  { src = "https://github.com/MeanderingProgrammer/render-markdown.nvim" },
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
  { src = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects" },
  { src = "https://github.com/stevearc/quicker.nvim" },
  { src = "https://github.com/folke/sidekick.nvim" },
  { src = "https://github.com/folke/tokyonight.nvim" },
  { src = "https://github.com/folke/trouble.nvim" },
  { src = "https://github.com/ibhagwan/fzf-lua" },
  { src = "https://github.com/folke/flash.nvim" },
  { src = "https://github.com/christoomey/vim-tmux-navigator" },
  { src = "https://github.com/nvim-lua/plenary.nvim" },
  { src = "https://github.com/mikavilpas/yazi.nvim" },
})
