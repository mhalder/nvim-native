local map = vim.keymap.set

-- indent
map("v", "<", "<gv", { desc = "indent left" })
map("v", ">", ">gv", { desc = "indent right" })

-- clear search highlight
map("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "clear search highlight" })

-- find / grep (fzf-lua)
map("n", "<leader><leader>", function()
  require("fzf-lua").files()
end, { desc = "find files" })
map("n", "<leader>fg", function()
  require("fzf-lua").live_grep({
    hidden = true,
    rg_opts = "--column --line-number --no-heading --color=always --smart-case --max-columns=4096 --glob=!.git -e",
  })
end, { desc = "grep (hidden)" })
map("n", "<leader>fw", function()
  require("fzf-lua").grep_cword()
end, { desc = "grep word" })
map("v", "<leader>fw", function()
  require("fzf-lua").grep_visual()
end, { desc = "grep selection" })
map("n", "<leader>bb", function()
  require("fzf-lua").buffers()
end, { desc = "buffers" })
map("n", "<leader>bd", "<cmd>bd<cr>", { desc = "delete buffer" })
map("n", "<leader>fh", function()
  require("fzf-lua").helptags()
end, { desc = "help" })
map("n", "<leader>fn", function()
  local notify = require("mini.notify")
  local history = notify.get_all()
  if #history == 0 then
    print("No notifications")
    return
  end
  local items = {}
  for i = #history, 1, -1 do
    local n = history[i]
    table.insert(items, { text = n.msg, level = n.hl_group or "Normal" })
  end
  require("mini.pick").start({
    source = {
      name = "Notifications",
      items = vim.tbl_map(function(item)
        return item.text
      end, items),
      choose = function(item)
        vim.fn.setreg("+", item)
      end,
    },
  })
end, { desc = "notifications" })
map("n", "<leader>fr", function()
  require("fzf-lua").resume()
end, { desc = "resume" })
map("n", "<leader>fo", function()
  require("fzf-lua").oldfiles()
end, { desc = "oldfiles" })
map("n", "<leader>f/", function()
  require("fzf-lua").blines()
end, { desc = "buffer lines" })
map("n", "<leader>fc", function()
  require("fzf-lua").commands()
end, { desc = "commands" })
map("n", "<leader>fk", function()
  require("fzf-lua").keymaps()
end, { desc = "keymaps" })
map("n", "<leader>fm", function()
  require("fzf-lua").marks()
end, { desc = "marks" })
map("n", "<leader>f'", function()
  require("fzf-lua").registers()
end, { desc = "registers" })
map("n", "<leader>fd", function()
  require("fzf-lua").diagnostics_document()
end, { desc = "diagnostics" })
map("n", "<leader>fs", function()
  require("fzf-lua").lsp_document_symbols()
end, { desc = "symbols" })
map("n", "<leader>fS", function()
  require("fzf-lua").lsp_workspace_symbols()
end, { desc = "workspace symbols" })

-- quit and save
map("n", "<leader>jj", vim.cmd.quit, { desc = "quit" })
map("n", "<leader>jk", vim.cmd.write, { desc = "save" })
map("n", "<leader>jl", vim.cmd.wq, { desc = "save and quit" })
map("n", "<leader>j;", function()
  vim.cmd("qa!")
end, { desc = "quit all (no save)" })

-- sidekick
map({ "n", "v" }, "<leader>aa", function()
  require("sidekick.cli").toggle({ focus = true })
end, { desc = "sidekick toggle" })
map({ "n", "v" }, "<leader>ac", function()
  require("sidekick.cli").toggle({ name = "claude", focus = true })
end, { desc = "sidekick claude" })
map("n", "<leader>as", function()
  require("sidekick.cli").select({ filter = { installed = true } })
end, { desc = "sidekick select cli" })
map({ "n", "v" }, "<leader>ap", function()
  require("sidekick.cli").prompt()
end, { desc = "sidekick prompt" })
map({ "n", "x", "i", "t" }, "<C-.>", function()
  require("sidekick.cli").focus()
end, { desc = "sidekick focus" })

-- debugging
map("n", "<leader>dc", function()
  require("dap").continue()
end, { desc = "debug continue" })
map("n", "<leader>do", function()
  require("dap").step_over()
end, { desc = "debug step over" })
map("n", "<leader>di", function()
  require("dap").step_into()
end, { desc = "debug step into" })
map("n", "<leader>du", function()
  require("dap").step_out()
end, { desc = "debug step out" })
map("n", "<leader>db", function()
  require("dap").toggle_breakpoint()
end, { desc = "toggle breakpoint" })
map("n", "<leader>dB", function()
  require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
end, { desc = "conditional breakpoint" })
map("n", "<leader>dr", function()
  require("dap").repl.open()
end, { desc = "open repl" })
map("n", "<leader>dl", function()
  require("dap").run_last()
end, { desc = "run last" })
map("n", "<leader>dt", function()
  require("dap").terminate()
end, { desc = "terminate" })
map("n", "<leader>dv", function()
  require("dapui").toggle()
end, { desc = "toggle dap ui" })

-- mini.files
map("n", "-", function()
  require("mini.files").open(vim.api.nvim_buf_get_name(0))
end, { desc = "open parent directory" })

-- yazi
map("n", "<leader>-", function()
  require("yazi").yazi()
end, { desc = "yazi" })

-- code: format
map({ "n", "v" }, "<leader>cf", function()
  require("conform").format({ async = true })
end, { desc = "format buffer" })
map("n", "<leader>cg", "<cmd>FormatChanged<cr>", { desc = "format git changed" })

-- code: lsp actions (supplement built-in gr* mappings)
map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "code action" })
map("n", "<leader>cn", vim.lsp.buf.rename, { desc = "rename symbol" })

-- toggles
map("n", "<leader>wa", function()
  vim.g.disable_autoformat = not vim.g.disable_autoformat
  local state = vim.g.disable_autoformat and "disabled" or "enabled"
  vim.notify("Autoformat " .. state)
end, { desc = "toggle autoformat" })
map("n", "<leader>wc", function()
  local current = vim.o.conceallevel
  vim.o.conceallevel = current == 0 and 2 or 0
  vim.notify("Conceal " .. (vim.o.conceallevel == 0 and "off" or "on"))
end, { desc = "toggle conceal" })

-- terminal
map("t", "<S-CR>", "\x1b[13;2u", { desc = "shift+enter to terminal" })
map("t", "<C-x>", "<C-\\><C-n>", { desc = "exit terminal mode" })
map("n", "<leader>tt", "<cmd>rightbelow vsplit | terminal<cr>", { desc = "terminal split" })

-- window
map("n", "<leader>wz", function()
  MiniMisc.zoom()
end, { desc = "zoom toggle" })
map("n", "<leader>wm", function()
  MiniNotify.show_history()
end, { desc = "message history" })

-- obsidian
map("n", "<leader>oO", function()
  local ok, client = pcall(require("obsidian").get_client)
  if not ok then
    vim.notify("Obsidian not initialized", vim.log.levels.WARN)
    return
  end
  local vault = client:vault_name()
  vim.fn.jobstart({ "obsidian", "obsidian://open?vault=" .. vault }, { detach = true })
end, { desc = "open Obsidian app" })
map("n", "<leader>oo", "<cmd>Obsidian quick_switch<cr>", { desc = "open note" })
map("n", "<leader>ov", "<cmd>Obsidian workspace<cr>", { desc = "switch vault" })
map("n", "<leader>on", "<cmd>Obsidian new<cr>", { desc = "new note" })
map("n", "<leader>od", "<cmd>Obsidian today<cr>", { desc = "daily note" })
map("n", "<leader>oy", "<cmd>Obsidian yesterday<cr>", { desc = "yesterday" })
map("n", "<leader>ot", "<cmd>Obsidian tomorrow<cr>", { desc = "tomorrow" })
map("n", "<leader>os", "<cmd>Obsidian search<cr>", { desc = "search" })
map("n", "<leader>ob", "<cmd>Obsidian backlinks<cr>", { desc = "backlinks" })
map("n", "<leader>og", "<cmd>Obsidian tags<cr>", { desc = "tags" })
map("n", "<leader>ol", "<cmd>Obsidian link<cr>", { desc = "link" })
map("n", "<leader>oT", "<cmd>Obsidian new_from_template<cr>", { desc = "new note from template" })
map("n", "<leader>oc", "<cmd>Obsidian toggle<cr>", { desc = "toggle checkbox" })
map("v", "<leader>ol", "<cmd>Obsidian link<cr>", { desc = "link selection" })
map("v", "<leader>oe", "<cmd>Obsidian extract_note<cr>", { desc = "extract to note" })

-- diagnostics toggle
map("n", "<leader>wd", function()
  vim.diagnostic.enable(not vim.diagnostic.is_enabled())
end, { desc = "toggle diagnostics" })

-- trouble
map("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", { desc = "diagnostics" })
map("n", "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", { desc = "buffer diagnostics" })
map("n", "<leader>xs", "<cmd>Trouble symbols toggle focus=false<cr>", { desc = "symbols" })
map("n", "<leader>xl", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", { desc = "lsp references" })
map("n", "<leader>xL", "<cmd>Trouble loclist toggle<cr>", { desc = "location list" })

-- git diff (built-in difftool)
map("n", "<leader>gd", "<cmd>DiffTool<cr>", { desc = "diff working tree" })
map("n", "<leader>gs", function()
  vim.cmd("Git diff --staged --name-only")
end, { desc = "diff staged (list)" })
map("n", "<leader>gh", "<cmd>Git log --oneline -- %<cr>", { desc = "file history" })
map("n", "<leader>gH", "<cmd>Git log --oneline<cr>", { desc = "repo history" })
map("n", "<leader>gb", "<cmd>Git blame -- %<cr>", { desc = "blame file" })

-- buffer navigation
map("n", "<C-Left>", "<cmd>bprevious<CR>", { desc = "previous buffer" })
map("n", "<C-Right>", "<cmd>bnext<CR>", { desc = "next buffer" })

-- buffer commands
map("n", "<leader>bo", "<cmd>BufOnly<cr>", { desc = "close other buffers" })
vim.api.nvim_create_user_command("BufOnly", function()
  local cur = vim.api.nvim_get_current_buf()
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if buf ~= cur and vim.bo[buf].buflisted then
      vim.api.nvim_buf_delete(buf, { force = false })
    end
  end
end, { desc = "Delete all buffers except current" })
