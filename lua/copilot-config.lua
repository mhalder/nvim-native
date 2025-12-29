require("copilot").setup({
	suggestion = {
		enabled = true,
		auto_trigger = true,
		keymap = {
			accept = "<Tab>",
			accept_word = "<C-Right>",
			accept_line = "<C-Down>",
			next = "<M-]>",
			prev = "<M-[>",
			dismiss = "<C-]>",
		},
	},
	panel = {
		enabled = true,
	},
	filetypes = {
		yaml = true,
		markdown = true,
		gitcommit = false,
		gitrebase = false,
	},
})
