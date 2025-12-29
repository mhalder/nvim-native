# Neovim Configuration

A minimal Neovim 0.12+ configuration using native `vim.pack` for plugin management.

## Requirements

- Neovim 0.12+
- Git
- Rust nightly via [rustup](https://rustup.rs/) (builds blink.cmp)
- [uv](https://github.com/astral-sh/uv) (Python debugging)
- [GitHub CLI](https://cli.github.com/) (optional)

## Installation

```bash
git clone https://github.com/yourusername/nvim ~/.config/nvim
nvim
```

Plugins install automatically on first launch.

## Features

**AI** - Sidekick (Claude) and GitHub Copilot integration
**LSP** - Lua, TypeScript, Python (basedpyright), Rust
**Formatting** - Format on save via conform.nvim (stylua, ruff, prettierd, shfmt)
**Completion** - blink.cmp with LuaSnip snippets
**Debugging** - DAP with Python support and virtual text
**Navigation** - Oil file explorer, Snacks picker, tmux integration
**GitHub** - Browse issues, PRs, open in browser

## Key Bindings

Leader: `Space`

### Find (`<leader>f`)

| Key  | Action  |
| ---- | ------- |
| `ff` | Files   |
| `fg` | Grep    |
| `fb` | Buffers |
| `fh` | Help    |

### AI (`<leader>a`)

| Key   | Action            |
| ----- | ----------------- |
| `aa`  | Toggle Sidekick   |
| `ac`  | Toggle Claude     |
| `as`  | Select CLI        |
| `ap`  | Prompt            |
| `Tab` | Accept suggestion |
| `C-.` | Focus Sidekick    |

### Debug (`<leader>d`)

| Key  | Action                 |
| ---- | ---------------------- |
| `dc` | Continue               |
| `do` | Step over              |
| `di` | Step into              |
| `du` | Step out               |
| `db` | Toggle breakpoint      |
| `dB` | Conditional breakpoint |
| `dr` | Open REPL              |
| `dl` | Run last               |
| `dt` | Terminate              |
| `dv` | Toggle DAP view        |

### Git (`<leader>g`)

| Key  | Action              |
| ---- | ------------------- |
| `gi` | Issues              |
| `gI` | Issues (all)        |
| `gp` | Pull requests       |
| `gP` | Pull requests (all) |
| `gB` | Browse in browser   |

### Code (`<leader>c`)

| Key  | Action        |
| ---- | ------------- |
| `cf` | Format buffer |

### Trouble (`<leader>x`)

| Key  | Action             |
| ---- | ------------------ |
| `xx` | Diagnostics        |
| `xX` | Buffer diagnostics |
| `xs` | Symbols            |
| `xl` | LSP references     |
| `xL` | Location list      |
| `xQ` | Quickfix list      |

### Quit/Save (`<leader>j`)

| Key  | Action             |
| ---- | ------------------ |
| `jj` | Quit               |
| `jk` | Save               |
| `jl` | Save and quit      |
| `j;` | Quit all (no save) |

### Other

| Key       | Action                      |
| --------- | --------------------------- |
| `-`       | Open Oil (parent dir)       |
| `C-p`     | Preview file (in Oil)       |
| `<` / `>` | Indent (visual, repeatable) |
| `jk`      | Exit terminal mode          |

## Structure

```
~/.config/nvim/
├── init.lua
├── lua/
│   ├── autocommands.lua
│   ├── blinkcmp-config.lua
│   ├── conform-config.lua
│   ├── copilot-config.lua
│   ├── trouble-config.lua
│   ├── debugging-config.lua
│   ├── keymaps.lua
│   ├── lsp-config.lua
│   ├── luasnip-config.lua
│   ├── oil-config.lua
│   ├── options.lua
│   ├── plugins.lua
│   ├── quicker-config.lua
│   ├── sidekick-config.lua
│   ├── snacks-config.lua
│   ├── theme.lua
│   ├── treesitter-config.lua
│   └── whichkey-config.lua
└── lsp/
    └── lua_ls.lua
```

## Plugins

| Plugin                    | Purpose              |
| ------------------------- | -------------------- |
| tokyonight.nvim           | Theme                |
| nvim-lspconfig            | LSP                  |
| mason.nvim                | LSP/tool installer   |
| mason-lspconfig.nvim      | Mason LSP bridge     |
| mason-tool-installer.nvim | Auto-install tools   |
| lazydev.nvim              | Lua dev support      |
| blink.cmp                 | Completion           |
| LuaSnip                   | Snippet engine       |
| friendly-snippets         | Snippet collection   |
| conform.nvim              | Formatting           |
| nvim-dap                  | Debugging            |
| nvim-dap-python           | Python DAP adapter   |
| nvim-dap-virtual-text     | DAP inline values    |
| nvim-dap-view             | DAP UI               |
| nvim-treesitter           | Syntax               |
| snacks.nvim               | Picker, GitHub       |
| oil.nvim                  | File explorer        |
| sidekick.nvim             | AI assistant         |
| copilot.lua               | GitHub Copilot       |
| which-key.nvim            | Key hints            |
| vim-tmux-navigator        | Tmux integration     |
| trouble.nvim              | Diagnostics list     |
| quicker.nvim              | Quickfix enhancement |

## License

[MIT](LICENSE)
