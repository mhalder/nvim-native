require("lazydev").setup({
	library = {
		{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
		{ path = "snacks.nvim", words = { "Snacks" } },
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
	ensure_installed = { "lua_ls", "ts_ls", "basedpyright", "rust_analyzer" },
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
		"ruff",
		"prettierd",
		"shfmt",
		-- linters
		"selene",
		"eslint_d",
		"shellcheck",
		"golangci-lint",
		-- debuggers
		"debugpy",
		"delve",
		"codelldb",
	},
})
