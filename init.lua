-- set leader before any keymaps
vim.g.mapleader = " "

-- install plugins
require("plugins")

-- configure plugins
require("treesitter-config")
require("lsp-config")
require("fidget-config")
require("luasnip-config")
require("blinkcmp-config")
require("copilot-config")
require("trouble-config")
require("conform-config")
require("debugging-config")
require("snacks-config")
require("quicker-config")
require("oil-config")
require("mini-config")
require("sidekick-config")
require("whichkey-config")

-- user setup
require("options")
require("keymaps")
require("autocommands")

-- theme
require("theme")
