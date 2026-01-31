local map = vim.keymap.set

-- indent
map("v", "<", "<gv", { desc = "indent left" })
map("v", ">", ">gv", { desc = "indent right" })

-- clear search highlight
map("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "clear search highlight" })

-- mini.pick
map("n", "<leader>ff", function()
  require("mini.pick").builtin.files()
end, { desc = "find files" })
map("n", "<leader>fg", function()
  require("mini.pick").builtin.grep_live()
end, { desc = "grep" })
local function pick_buffers()
  local pick = require("mini.pick")
  local wipe_buffer = function()
    local matches = pick.get_picker_matches()
    if matches and matches.current then
      local bufnr = matches.current.bufnr
      pick.stop()
      vim.api.nvim_buf_delete(bufnr, {})
      vim.schedule(pick_buffers)
    end
  end
  pick.builtin.buffers({}, {
    mappings = { wipe = { char = "<C-d>", func = wipe_buffer } },
  })
end
map("n", "<leader>fb", pick_buffers, { desc = "buffers" })
map("n", "<leader>fh", function()
  require("mini.pick").builtin.help()
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
  require("mini.pick").builtin.resume()
end, { desc = "resume" })
map("n", "<leader>fo", function()
  require("mini.extra").pickers.oldfiles()
end, { desc = "oldfiles" })
map("n", "<leader>f/", function()
  require("mini.extra").pickers.buf_lines({ scope = "current" })
end, { desc = "buffer lines" })
map("n", "<leader>fw", function()
  require("mini.pick").builtin.grep({ pattern = vim.fn.expand("<cword>") })
end, { desc = "grep word" })
map("n", "<leader>fc", function()
  require("mini.extra").pickers.commands()
end, { desc = "commands" })
map("n", "<leader>fk", function()
  require("mini.extra").pickers.keymaps()
end, { desc = "keymaps" })
map("n", "<leader>fm", function()
  require("mini.extra").pickers.marks()
end, { desc = "marks" })
map("n", "<leader>f'", function()
  require("mini.extra").pickers.registers()
end, { desc = "registers" })
map("n", "<leader>fd", function()
  require("mini.extra").pickers.diagnostic()
end, { desc = "diagnostics" })
map("n", "<leader>fs", function()
  require("mini.extra").pickers.lsp({ scope = "document_symbol" })
end, { desc = "symbols" })
map("n", "<leader>fS", function()
  require("mini.extra").pickers.lsp({ scope = "workspace_symbol" })
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
end, { desc = "yazi file manager" })

-- format
map({ "n", "v" }, "<leader>cf", function()
  require("conform").format({ async = true })
end, { desc = "format buffer" })
map("n", "<leader>ct", function()
  vim.g.disable_autoformat = not vim.g.disable_autoformat
  local state = vim.g.disable_autoformat and "disabled" or "enabled"
  vim.notify("Autoformat " .. state)
end, { desc = "toggle autoformat" })
map("n", "<leader>cT", function()
  local current = vim.o.conceallevel
  vim.o.conceallevel = current == 0 and 2 or 0
  vim.notify("Conceal " .. (vim.o.conceallevel == 0 and "off" or "on"))
end, { desc = "toggle conceal" })
map("n", "<leader>cc", "<cmd>FormatChanged<cr>", { desc = "format git changed" })
map("n", "<leader>cs", "<cmd>FormatChanged staged<cr>", { desc = "format git staged" })

-- terminal
map("t", "<C-x>", "<C-\\><C-n>", { desc = "exit terminal mode" })

-- window
map("n", "<leader>wz", function()
  MiniMisc.zoom()
end, { desc = "zoom toggle" })
map("n", "<leader>wm", function()
  MiniNotify.show_history()
end, { desc = "message history" })

-- obsidian
map("n", "<leader>oO", function()
  local vault = Obsidian.workspace.name
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

-- trouble
map("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", { desc = "diagnostics" })
map("n", "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", { desc = "buffer diagnostics" })
map("n", "<leader>xs", "<cmd>Trouble symbols toggle focus=false<cr>", { desc = "symbols" })
map("n", "<leader>xl", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", { desc = "lsp references" })
map("n", "<leader>xL", "<cmd>Trouble loclist toggle<cr>", { desc = "location list" })

-- buffer navigation
map("n", "<C-Left>", "<cmd>bprevious<CR>", { desc = "previous buffer" })
map("n", "<C-Right>", "<cmd>bnext<CR>", { desc = "next buffer" })

-- buffer commands
map("n", "<leader>co", "<cmd>BufOnly<cr>", { desc = "close other buffers" })
vim.api.nvim_create_user_command("BufOnly", function()
  local cur = vim.api.nvim_get_current_buf()
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if buf ~= cur and vim.bo[buf].buflisted then
      vim.api.nvim_buf_delete(buf, { force = false })
    end
  end
end, { desc = "Delete all buffers except current" })
