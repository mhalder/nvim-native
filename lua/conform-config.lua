---@type conform.FiletypeFormatter
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
		rust = { [1] = "rustfmt", lsp_format = "fallback" },
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
