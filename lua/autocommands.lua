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
autocmd("WinEnter", {
	desc = "Show cursorline in active window",
	group = group,
	callback = function()
		vim.wo.cursorline = true
	end,
})

autocmd("WinLeave", {
	desc = "Hide cursorline in inactive window",
	group = group,
	callback = function()
		vim.wo.cursorline = false
	end,
})
