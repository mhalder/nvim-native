local prettier = { "prettierd", "prettier", stop_after_first = true }

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
		rust = { "rustfmt", lsp_format = "fallback" },
		sh = { "shfmt" },
		bash = { "shfmt" },
	},
	default_format_opts = {
		lsp_format = "fallback",
	},
	format_on_save = {
		timeout_ms = 500,
		lsp_format = "fallback",
	},
	notify_on_error = true,
})
