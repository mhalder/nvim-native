-- set leader before any keymaps
vim.g.mapleader = " "

-- install plugins
require("plugins")

-- configure plugins
require("lsp-config")
require("fidget-config")
require("treesitter-config")
require("blinkcmp-config")
require("snacks-config")
require("whichkey-config")
require("luasnip-config")
require("quicker-config")
require("oil-config")
require("sidekick-config")
require("copilot-config")
require("debugging-config")
require("conform-config")
require("trouble-config")

-- user setup
require("options")
require("keymaps")
require("autocommands")

-- theme
require("theme")
