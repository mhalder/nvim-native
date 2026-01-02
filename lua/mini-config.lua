require("mini.ai").setup()
require("mini.bracketed").setup()
require("mini.files").setup({
	mappings = {
		go_in_plus = "<CR>",
	},
	windows = {
		preview = true,
	},
})
require("mini.pairs").setup()
require("mini.statusline").setup()
require("mini.pick").setup()
require("mini.surround").setup()
