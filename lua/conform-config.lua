local prettier = { [1] = "prettierd", [2] = "prettier", stop_after_first = true }

require("conform").setup({
  formatters_by_ft = {
    lua = { "stylua" },
    python = { "ruff_format", "ruff_organize_imports" },
    javascript = prettier,
    typescript = prettier,
    javascriptreact = prettier,
    typescriptreact = prettier,
    json = prettier,
    yaml = prettier,
    markdown = prettier,
    html = prettier,
    css = prettier,
    go = { "goimports", "gofmt" },
    rust = { "rustfmt" },
    sh = { "shfmt" },
    bash = { "shfmt" },
  },
  default_format_opts = {
    lsp_format = "fallback",
  },
  format_on_save = function()
    if vim.g.disable_autoformat then
      return
    end
    return {
      timeout_ms = 500,
      lsp_format = "fallback",
    }
  end,
  notify_on_error = true,
})

-- Format all git changed files using conform
vim.api.nvim_create_user_command("FormatChanged", function(opts)
  local cmd = opts.args == "staged" and "git diff --name-only --cached" or "git diff --name-only"
  local files = vim.fn.systemlist(cmd)
  local formatted = 0
  for _, file in ipairs(files) do
    if vim.fn.filereadable(file) == 1 then
      vim.cmd("edit " .. vim.fn.fnameescape(file))
      require("conform").format({ bufnr = 0 })
      vim.cmd("update")
      formatted = formatted + 1
    end
  end
  vim.notify(string.format("Formatted %d file(s)", formatted), vim.log.levels.INFO)
end, { nargs = "?", desc = "Format git changed files (use 'staged' for staged only)" })
