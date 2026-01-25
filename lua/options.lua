vim.o.termguicolors = true
vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true
vim.o.smartindent = true
vim.o.autoindent = true
vim.o.scrolloff = 8
vim.o.sidescrolloff = 8
vim.o.wrap = false
vim.o.number = true
vim.o.relativenumber = true
vim.o.cursorline = true
vim.o.signcolumn = "yes"
vim.o.conceallevel = 2
vim.o.clipboard = "unnamedplus"
vim.o.completeopt = "menuone,noselect,fuzzy,nosort"

vim.o.updatetime = 300
vim.o.timeoutlen = 500
vim.o.confirm = true
vim.o.exrc = true
vim.o.autoread = true
vim.o.smoothscroll = true

vim.o.jumpoptions = "stack"
vim.o.inccommand = "split"

vim.o.grepprg = "rg --vimgrep"
vim.o.grepformat = "%f:%l:%c:%m"

vim.o.ignorecase = true
vim.o.smartcase = true

vim.opt.diffopt:append("algorithm:histogram,linematch:60")

vim.diagnostic.config({ virtual_text = true })
