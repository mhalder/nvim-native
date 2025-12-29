local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- main augroup for config autocmds
local group = augroup("UserConfig", { clear = true })

-- highlight yank
autocmd("TextYankPost", {
	desc = "Highlight selection on yank",
	group = group,
	callback = function()
		vim.hl.on_yank({ timeout = 200 })
	end,
})

-- restore cursor position
autocmd("BufReadPost", {
	desc = "Restore cursor to last position",
	group = group,
	callback = function(args)
		local mark = vim.api.nvim_buf_get_mark(args.buf, '"')
		local line_count = vim.api.nvim_buf_line_count(args.buf)
		if mark[1] > 0 and mark[1] <= line_count then
			pcall(vim.api.nvim_win_set_cursor, 0, mark)
			vim.cmd.normal({ "zz", bang = true })
		end
	end,
})

-- help in vertical split
autocmd("FileType", {
	desc = "Open help in vertical split",
	group = group,
	pattern = "help",
	callback = function()
		vim.cmd.wincmd("L")
	end,
})

-- auto resize splits
autocmd("VimResized", {
	desc = "Auto resize splits on terminal resize",
	group = group,
	callback = function()
		vim.cmd.wincmd("=")
	end,
})

-- no auto continue comments
autocmd("FileType", {
	desc = "Disable auto comment continuation",
	group = group,
	callback = function()
		vim.opt_local.formatoptions:remove({ "c", "r", "o" })
	end,
})

-- dotenv syntax highlighting
autocmd({ "BufRead", "BufNewFile" }, {
	desc = "Set filetype for dotenv files",
	group = group,
	pattern = { ".env", ".env.*" },
	callback = function()
		vim.bo.filetype = "sh"
	end,
})

-- cursorline only in active window
autocmd({ "WinEnter", "BufEnter" }, {
	desc = "Show cursorline in active window",
	group = group,
	callback = function()
		vim.wo.cursorline = true
	end,
})

autocmd({ "WinLeave", "BufLeave" }, {
	desc = "Hide cursorline in inactive window",
	group = group,
	callback = function()
		vim.wo.cursorline = false
	end,
})

-- LSP attach configuration
autocmd("LspAttach", {
	desc = "Configure LSP on attach",
	group = group,
	callback = function(args)
		local client = assert(vim.lsp.get_client_by_id(args.data.client_id))

		if client:supports_method("textDocument/completion") then
			vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
		end
	end,
})
