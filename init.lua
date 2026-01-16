-- set leader before any keymaps
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- install plugins
require("plugins")

-- configure plugins
require("lsp-config")
require("luasnip-config")
require("copilot-config")
require("trouble-config")
require("conform-config")
require("lint-config")
require("quicker-config")
require("mini-config")
require("sidekick-config")
require("obsidian-config")

-- user setup
require("options")
require("keymaps")
require("autocommands")

-- theme
require("theme")
