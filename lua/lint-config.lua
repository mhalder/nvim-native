local lint = require("lint")

lint.linters_by_ft = {
  lua = { "selene" },
  javascript = { "eslint_d" },
  javascriptreact = { "eslint_d" },
  typescript = { "eslint_d" },
  typescriptreact = { "eslint_d" },
  sh = { "shellcheck" },
  bash = { "shellcheck" },
  go = { "golangcilint" },
}

vim.api.nvim_create_autocmd({ "BufWritePost", "InsertLeave", "BufEnter" }, {
  group = vim.api.nvim_create_augroup("NvimLint", { clear = true }),
  callback = function()
    lint.try_lint()
  end,
})
