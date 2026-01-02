local map = vim.keymap.set

-- indent
map("v", "<", "<gv", { desc = "indent left" })
map("v", ">", ">gv", { desc = "indent right" })

-- mini.pick
map("n", "<leader>ff", function() require("mini.pick").builtin.files() end, { desc = "find files" })
map("n", "<leader>fg", function() require("mini.pick").builtin.grep_live() end, { desc = "grep" })
map("n", "<leader>fb", function() require("mini.pick").builtin.buffers() end, { desc = "buffers" })
map("n", "<leader>fh", function() require("mini.pick").builtin.help() end, { desc = "help" })
map("n", "<leader>fn", function() require("mini.notify").show_history() end, { desc = "notifications" })

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
map("n", "<leader>dc", function() require("dap").continue() end, { desc = "debug continue" })
map("n", "<leader>do", function() require("dap").step_over() end, { desc = "debug step over" })
map("n", "<leader>di", function() require("dap").step_into() end, { desc = "debug step into" })
map("n", "<leader>du", function() require("dap").step_out() end, { desc = "debug step out" })
map("n", "<leader>db", function() require("dap").toggle_breakpoint() end, { desc = "toggle breakpoint" })
map("n", "<leader>dB", function()
	require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
end, { desc = "conditional breakpoint" })
map("n", "<leader>dr", function() require("dap").repl.open() end, { desc = "open repl" })
map("n", "<leader>dl", function() require("dap").run_last() end, { desc = "run last" })
map("n", "<leader>dt", function() require("dap").terminate() end, { desc = "terminate" })
map("n", "<leader>dv", function()
	require("dapui").toggle()
end, { desc = "toggle dap ui" })

-- mini.files
map("n", "-", function()
	require("mini.files").open(vim.api.nvim_buf_get_name(0))
end, { desc = "open parent directory" })

-- format
map({ "n", "v" }, "<leader>cf", function()
	require("conform").format({ async = true })
end, { desc = "format buffer" })
map("n", "<leader>cF", function()
	vim.g.disable_autoformat = not vim.g.disable_autoformat
	local state = vim.g.disable_autoformat and "disabled" or "enabled"
	vim.notify("Autoformat " .. state)
end, { desc = "toggle autoformat" })

-- terminal
map("t", "<C-x>", "<C-\\><C-n>", { desc = "exit terminal mode" })

-- window
map("n", "<leader>wz", function() MiniMisc.zoom() end, { desc = "zoom toggle" })

-- trouble
map("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", { desc = "diagnostics" })
map("n", "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", { desc = "buffer diagnostics" })
map("n", "<leader>xs", "<cmd>Trouble symbols toggle focus=false<cr>", { desc = "symbols" })
map("n", "<leader>xl", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", { desc = "lsp references" })
map("n", "<leader>xL", "<cmd>Trouble loclist toggle<cr>", { desc = "location list" })
