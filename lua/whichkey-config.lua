require("which-key").setup()

require("which-key").add({
	{ "<leader>a", group = "sidekick" },
	{ "<leader>c", group = "code" },
	{ "<leader>d", group = "debugging" },
	{ "<leader>f", group = "find" },
	{ "<leader>g", group = "github" },
	{ "<leader>j", group = "quit/save" },
	{ "<leader>x", group = "trouble" },
})
