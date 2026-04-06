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

-- Format all git-changed files (staged + unstaged)
vim.api.nvim_create_user_command("FormatChanged", function()
  local files = vim.fn.systemlist("git diff --name-only HEAD")
  local conform = require("conform")
  local formatted = 0
  for _, file in ipairs(files) do
    if vim.fn.filereadable(file) == 1 then
      local bufnr = vim.fn.bufadd(file)
      vim.fn.bufload(bufnr)
      local was_listed = vim.bo[bufnr].buflisted
      vim.bo[bufnr].buflisted = false
      conform.format({ bufnr = bufnr, async = false }, function(err)
        if not err and vim.bo[bufnr].modified then
          vim.api.nvim_buf_call(bufnr, function()
            vim.cmd("write")
          end)
        end
        if vim.api.nvim_buf_is_valid(bufnr) and not was_listed then
          vim.api.nvim_buf_delete(bufnr, { force = true })
        end
      end)
      formatted = formatted + 1
    end
  end
  vim.notify(string.format("Formatted %d file(s)", formatted), vim.log.levels.INFO)
end, { desc = "Format all git-changed files" })
