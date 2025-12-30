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
require("mini.surround").setup({
	mappings = {
		add = "gsa",
		delete = "gsd",
		replace = "gsr",
		find = "gsf",
		find_left = "gsF",
		highlight = "gsh",
		update_n_lines = "gsn",
	},
})
