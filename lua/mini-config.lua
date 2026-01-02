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
require("mini.pick").setup({
	window = {
		config = function()
			local height = math.floor(0.618 * vim.o.lines)
			local width = math.floor(0.35 * vim.o.columns)
			return {
				anchor = "NE",
				height = height,
				width = width,
				row = math.floor(0.5 * (vim.o.lines - height)),
				col = vim.o.columns,
			}
		end,
	},
})
require("mini.surround").setup()

local miniclue = require("mini.clue")
miniclue.setup({
	triggers = {
		{ mode = "n", keys = "<Leader>" },
		{ mode = "x", keys = "<Leader>" },
		{ mode = "i", keys = "<C-x>" },
		{ mode = "n", keys = "g" },
		{ mode = "x", keys = "g" },
		{ mode = "n", keys = "'" },
		{ mode = "n", keys = "`" },
		{ mode = "x", keys = "'" },
		{ mode = "x", keys = "`" },
		{ mode = "n", keys = '"' },
		{ mode = "x", keys = '"' },
		{ mode = "i", keys = "<C-r>" },
		{ mode = "c", keys = "<C-r>" },
		{ mode = "n", keys = "<C-w>" },
		{ mode = "n", keys = "z" },
		{ mode = "x", keys = "z" },
		{ mode = "n", keys = "[" },
		{ mode = "n", keys = "]" },
	},
	clues = {
		{ mode = "n", keys = "<Leader>a", desc = "+sidekick" },
		{ mode = "x", keys = "<Leader>a", desc = "+sidekick" },
		{ mode = "n", keys = "<Leader>c", desc = "+code" },
		{ mode = "x", keys = "<Leader>c", desc = "+code" },
		{ mode = "n", keys = "<Leader>d", desc = "+debugging" },
		{ mode = "n", keys = "<Leader>f", desc = "+find" },
		{ mode = "n", keys = "<Leader>j", desc = "+quit/save" },
		{ mode = "n", keys = "<Leader>x", desc = "+trouble" },
		miniclue.gen_clues.builtin_completion(),
		miniclue.gen_clues.g(),
		miniclue.gen_clues.marks(),
		miniclue.gen_clues.registers(),
		miniclue.gen_clues.windows(),
		miniclue.gen_clues.z(),
	},
	window = {
		delay = 300,
		config = {
			anchor = "SE",
			row = "auto",
			col = "auto",
			width = "auto",
		},
	},
})
