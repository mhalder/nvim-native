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

-- Native buffer tabline
vim.o.showtabline = 2
function _G.bufline()
  local bufs = {}
  local cur = vim.api.nvim_get_current_buf()
  for _, b in ipairs(vim.api.nvim_list_bufs()) do
    if vim.bo[b].buflisted then
      local name = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(b), ":t")
      if name == "" then name = "[No Name]" end
      local modified = vim.bo[b].modified and " +" or ""
      if b == cur then
        table.insert(bufs, "%#TabLineSel# " .. name .. modified .. " ")
      else
        table.insert(bufs, "%#TabLine# " .. name .. modified .. " ")
      end
    end
  end
  return table.concat(bufs) .. "%#TabLineFill#"
end
vim.o.tabline = "%!v:lua.bufline()"
