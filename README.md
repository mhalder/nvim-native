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
**Formatting** - Format on save via conform.nvim (stylua, ruff, prettierd, shfmt, goimports, rustfmt)
**Linting** - Async linting via nvim-lint (selene, eslint_d, shellcheck, golangci-lint)
**Completion** - blink.cmp with LuaSnip snippets
**Debugging** - DAP with Python and Go support and virtual text
**Navigation** - mini.files explorer, Snacks picker, tmux integration
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
| `gb` | Blame line          |
| `gB` | Browse in browser   |

### Code (`<leader>c`)

| Key  | Action            |
| ---- | ----------------- |
| `cf` | Format buffer     |
| `cF` | Toggle autoformat |

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
| `-`       | Open mini.files (parent)    |
| `<` / `>` | Indent (visual, repeatable) |
| `C-x`     | Exit terminal mode          |
| `s`       | Flash jump                  |
| `S`       | Flash treesitter            |

### Text Objects (mini.ai)

Use with operators: `d` (delete), `c` (change), `y` (yank), `v` (visual)

| Key             | Text Object   | Example         |
| --------------- | ------------- | --------------- |
| `(` / `)`       | Parentheses   | `vi(` `da)`     |
| `[` / `]`       | Brackets      | `vi[` `da]`     |
| `{` / `}`       | Braces        | `vi{` `da}`     |
| `<` / `>`       | Angles        | `vi<` `da>`     |
| `b`             | Any bracket   | `vib` `dab`     |
| `"` `'` `` ` `` | Quotes        | `vi"` `da'`     |
| `q`             | Any quote     | `viq` `daq`     |
| `f`             | Function call | `vif` `daf`     |
| `a`             | Argument      | `via` `cia`     |
| `t`             | HTML/XML tag  | `vit` `cat`     |
| `?`             | User prompt   | `vi?` (prompts) |

Use `2i(` or `2a(` to select the next/outer match.

### Surround (mini.surround)

| Key   | Action                |
| ----- | --------------------- |
| `gsa` | Add surrounding       |
| `gsd` | Delete surrounding    |
| `gsr` | Replace surrounding   |
| `gsf` | Find surrounding      |
| `gsF` | Find left             |
| `gsh` | Highlight surrounding |

### Bracket Navigation (mini.bracketed)

Jump to previous/next items with `[` and `]`:

| Key       | Target          |
| --------- | --------------- |
| `[b`/`]b` | Buffer          |
| `[c`/`]c` | Comment block   |
| `[x`/`]x` | Conflict marker |
| `[d`/`]d` | Diagnostic      |
| `[f`/`]f` | File on disk    |
| `[i`/`]i` | Indent change   |
| `[j`/`]j` | Jump (jumplist) |
| `[l`/`]l` | Location list   |
| `[o`/`]o` | Oldfile         |
| `[q`/`]q` | Quickfix        |
| `[t`/`]t` | Treesitter node |
| `[u`/`]u` | Undo state      |
| `[w`/`]w` | Window          |
| `[y`/`]y` | Yank selection  |

Capital letter jumps to first/last (e.g., `[B`/`]B`). Count prefix supported (e.g., `2]b`).

## Structure

```
~/.config/nvim/
├── init.lua
├── selene.toml
├── vim.yml
└── lua/
    ├── autocommands.lua
    ├── blinkcmp-config.lua
    ├── conform-config.lua
    ├── copilot-config.lua
    ├── debugging-config.lua
    ├── fidget-config.lua
    ├── keymaps.lua
    ├── lint-config.lua
    ├── lsp-config.lua
    ├── luasnip-config.lua
    ├── mini-config.lua
    ├── options.lua
    ├── plugins.lua
    ├── quicker-config.lua
    ├── sidekick-config.lua
    ├── snacks-config.lua
    ├── theme.lua
    ├── treesitter-config.lua
    ├── trouble-config.lua
    └── whichkey-config.lua
```

## Plugins

| Plugin                    | Purpose                                                             |
| ------------------------- | ------------------------------------------------------------------- |
| blink.cmp                 | Completion                                                          |
| conform.nvim              | Formatting                                                          |
| copilot.lua               | GitHub Copilot                                                      |
| fidget.nvim               | LSP progress                                                        |
| flash.nvim                | Motion navigation                                                   |
| friendly-snippets         | Snippet collection                                                  |
| lazydev.nvim              | Lua dev support                                                     |
| LuaSnip                   | Snippet engine                                                      |
| mason-lspconfig.nvim      | Mason LSP bridge                                                    |
| mason-tool-installer.nvim | Auto-install tools                                                  |
| mason.nvim                | LSP/tool installer                                                  |
| mini.nvim                 | File explorer, statusline, text objects, pairs, surround, bracketed |
| nvim-dap                  | Debugging                                                           |
| nvim-dap-go               | Go DAP adapter                                                      |
| nvim-dap-python           | Python DAP adapter                                                  |
| nvim-dap-ui               | DAP UI                                                              |
| nvim-dap-virtual-text     | DAP inline values                                                   |
| nvim-nio                  | Async library                                                       |
| nvim-lint                 | Async linting                                                       |
| nvim-lspconfig            | LSP                                                                 |
| nvim-treesitter           | Syntax                                                              |
| quicker.nvim              | Quickfix enhancement                                                |
| sidekick.nvim             | AI assistant                                                        |
| snacks.nvim               | Picker, GitHub                                                      |
| tokyonight.nvim           | Theme                                                               |
| trouble.nvim              | Diagnostics list                                                    |
| vim-tmux-navigator        | Tmux integration                                                    |
| which-key.nvim            | Key hints                                                           |

## License

[MIT](LICENSE)
