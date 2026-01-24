-- set leader before any keymaps
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- install plugins
require("plugins")

-- configure plugins
require("treesitter-config")
require("lsp-config")
require("luasnip-config")
require("blinkcmp-config")
require("copilot-config")
require("trouble-config")
require("conform-config")
require("lint-config")
require("debugging-config")
require("quicker-config")
require("mini-config")
require("sidekick-config")
require("obsidian-config")
require("yazi-config")

-- user setup
require("options")
require("keymaps")
require("autocommands")

-- theme
require("theme")
