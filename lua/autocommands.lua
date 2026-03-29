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
    vim.wo.cursorline = vim.bo.buftype ~= "terminal"
  end,
})

autocmd("WinLeave", {
  desc = "Hide cursorline in inactive window",
  group = group,
  callback = function()
    vim.wo.cursorline = false
  end,
})

-- load markdown-preview for markdown files
autocmd("FileType", {
  desc = "Load markdown-preview plugin",
  group = group,
  pattern = "markdown",
  callback = function()
    vim.cmd.packadd("markdown-preview.nvim")
  end,
})

-- silently reload files changed outside of Neovim
autocmd("FileChangedShell", {
  desc = "Silently reload files changed externally",
  group = group,
  callback = function()
    vim.v.fcs_choice = "reload"
  end,
})

-- clean up terminal buffers for transparent background
autocmd("TermOpen", {
  desc = "Disable UI chrome in terminal buffers",
  group = group,
  callback = function()
    vim.wo.cursorline = false
    vim.wo.number = false
    vim.wo.relativenumber = false
    vim.wo.signcolumn = "no"
    vim.b.minicursorword_disable = true
  end,
})

local saved_timeoutlen
autocmd("TermEnter", {
  desc = "Disable leader timeout in terminal",
  group = group,
  callback = function()
    saved_timeoutlen = vim.o.timeoutlen
    vim.o.timeoutlen = 0
  end,
})
autocmd("TermLeave", {
  desc = "Restore leader timeout from terminal",
  group = group,
  callback = function()
    vim.o.timeoutlen = saved_timeoutlen or 500
  end,
})

-- check for file changes when gaining focus or entering a buffer
autocmd({ "FocusGained", "BufEnter", "CursorHold" }, {
  desc = "Check for file changes",
  group = group,
  command = "silent! checktime",
})
