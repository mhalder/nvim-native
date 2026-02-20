# Neovim Configuration

A minimal Neovim 0.12+ configuration using native `vim.pack` for plugin management.

## Requirements

- Neovim 0.12+
- Git
- Rust via [rustup](https://rustup.rs/) (builds blink.cmp)
- Node.js (markdown-preview.nvim)
- [uv](https://github.com/astral-sh/uv) (Python debugging)
- [yazi](https://yazi-rs.github.io/) (terminal file manager)

## Installation

```bash
git clone https://github.com/yourusername/nvim ~/.config/nvim
nvim
```

Plugins install automatically on first launch.

## Features

**AI** - Sidekick (Claude) and GitHub Copilot integration
**LSP** - Lua, TypeScript, Python (basedpyright), Rust
**Treesitter** - Syntax highlighting for Lua, Python, Rust, TypeScript, JavaScript, Go, Bash, JSON, YAML, Markdown, HTML, CSS
**Formatting** - Format on save via conform.nvim (stylua, ruff, prettierd, shfmt, goimports, rustfmt)
**Linting** - Async linting via nvim-lint (selene, eslint_d, shellcheck, golangci-lint)
**Completion** - blink.cmp with LuaSnip snippets and Copilot suggestions
**Debugging** - DAP with Python, Go, and Rust support and virtual text
**Buffers** - Native tabline showing all open buffers with modified indicator, Ctrl+arrow navigation
**Navigation** - mini.files explorer, mini.pick fuzzy finder, yazi file manager, flash.nvim motions, tmux integration
**Notes** - Obsidian multi-vault integration with wiki links, daily notes, and templates
**Git** - Git commands (mini.git), diff signs and hunk staging (mini.diff)
**Utilities** - Auto project root, cursor restore, terminal background sync, buffer zoom (mini.misc)

## Key Bindings

Leader: `Space` | Local Leader: `\`

### Find (`<leader>f`)

| Key                | Action            |
| ------------------ | ----------------- |
| `<leader><leader>` | Files             |
| `fg`               | Grep              |
| `fh`               | Help              |
| `fn`               | Notifications     |
| `fr`               | Resume picker     |
| `fo`               | Old files         |
| `f/`               | Buffer lines      |
| `fw`               | Grep word         |
| `fc`               | Commands          |
| `fk`               | Keymaps           |
| `fm`               | Marks             |
| `f'`               | Registers         |
| `fd`               | Diagnostics       |
| `fs`               | Document symbols  |
| `fS`               | Workspace symbols |

In grep/files picker, press `<C-o>` to add glob filters (e.g., `*.md`, `src/**`).
In buffers picker, press `<C-d>` to wipe the selected buffer.

### AI (`<leader>a`)

| Key   | Action          |
| ----- | --------------- |
| `aa`  | Toggle Sidekick |
| `ac`  | Toggle Claude   |
| `as`  | Select CLI      |
| `ap`  | Prompt          |
| `C-.` | Focus Sidekick  |

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

### Buffer (`<leader>b`)

| Key  | Action        |
| ---- | ------------- |
| `bb` | Buffers       |
| `bd` | Delete buffer |

### Code (`<leader>c`)

| Key  | Action              |
| ---- | ------------------- |
| `cf` | Format buffer       |
| `cc` | Format git changed  |
| `cs` | Format git staged   |
| `co` | Close other buffers |

### Toggle (`<leader>t`)

| Key  | Action            |
| ---- | ----------------- |
| `ta` | Toggle autoformat |
| `tc` | Toggle conceal    |

### Trouble (`<leader>x`)

| Key  | Action             |
| ---- | ------------------ |
| `xx` | Diagnostics        |
| `xX` | Buffer diagnostics |
| `xs` | Symbols            |
| `xl` | LSP references     |
| `xL` | Location list      |

### Quit/Save (`<leader>j`)

| Key  | Action             |
| ---- | ------------------ |
| `jj` | Quit               |
| `jk` | Save               |
| `jl` | Save and quit      |
| `j;` | Quit all (no save) |

### Window (`<leader>w`)

| Key  | Action          |
| ---- | --------------- |
| `wz` | Zoom toggle     |
| `wm` | Message history |

### Git

| Key    | Action        |
| ------ | ------------- |
| `gh`   | Apply hunk    |
| `gH`   | Reset hunk    |
| `[h`   | Previous hunk |
| `]h`   | Next hunk     |
| `:Git` | Git commands  |

### Obsidian (`<leader>o`)

| Key  | Action              |
| ---- | ------------------- |
| `oO` | Open Obsidian app   |
| `oo` | Open note           |
| `ov` | Switch vault        |
| `on` | New note            |
| `od` | Daily note          |
| `oy` | Yesterday           |
| `ot` | Tomorrow            |
| `os` | Search              |
| `ob` | Backlinks           |
| `og` | Tags                |
| `ol` | Link (visual: link) |
| `oT` | New from template   |
| `oc` | Toggle checkbox     |
| `oe` | Extract to note (v) |

### Flash

| Key     | Mode  | Action                 |
| ------- | ----- | ---------------------- |
| `s`     | n,x,o | Jump to match          |
| `gS`    | n,x,o | Treesitter select      |
| `r`     | o     | Remote flash           |
| `R`     | o,x   | Treesitter search      |
| `<C-s>` | c     | Toggle flash in search |

Enhanced `f`/`t` motions show jump labels automatically.

### Other

| Key         | Action                      |
| ----------- | --------------------------- |
| `Esc`       | Clear search highlight      |
| `-`         | Open mini.files (parent)    |
| `<leader>-` | Yazi                        |
| `<` / `>`   | Indent (visual, repeatable) |
| `C-Left`    | Previous buffer             |
| `C-Right`   | Next buffer                 |
| `C-x`       | Exit terminal mode          |

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
| `gz`  | Add surrounding       |
| `gzd` | Delete surrounding    |
| `gzr` | Replace surrounding   |
| `gzf` | Find surrounding      |
| `gzF` | Find left             |
| `gzh` | Highlight surrounding |

### Bracket Navigation (mini.bracketed)

Jump to previous/next items with `[` and `]`:

| Key       | Target          |
| --------- | --------------- |
| `[b`/`]b` | Buffer          |
| `[c`/`]c` | Comment block   |
| `[x`/`]x` | Conflict marker |
| `[d`/`]d` | Diagnostic      |
| `[f`/`]f` | File on disk    |
| `[h`/`]h` | Hunk (git diff) |
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
├── .luarc.json
├── .stylua.toml
├── selene.toml
├── vim.yml
└── lua/
    ├── autocommands.lua
    ├── blinkcmp-config.lua
    ├── conform-config.lua
    ├── copilot-config.lua
    ├── debugging-config.lua
    ├── flash-config.lua
    ├── keymaps.lua
    ├── lint-config.lua
    ├── lsp-config.lua
    ├── luasnip-config.lua
    ├── mini-config.lua
    ├── obsidian-config.lua
    ├── options.lua
    ├── plugins.lua
    ├── quicker-config.lua
    ├── sidekick-config.lua
    ├── theme.lua
    ├── treesitter-config.lua
    ├── trouble-config.lua
    └── yazi-config.lua
```

## Plugins

| Plugin                    | Purpose                                                                                                                                 |
| ------------------------- | --------------------------------------------------------------------------------------------------------------------------------------- |
| blink.cmp                 | Completion                                                                                                                              |
| blink-copilot             | Copilot source for blink.cmp                                                                                                            |
| conform.nvim              | Formatting                                                                                                                              |
| copilot.lua               | GitHub Copilot LSP                                                                                                                      |
| flash.nvim                | Motion jump with labels                                                                                                                 |
| friendly-snippets         | Snippet collection                                                                                                                      |
| lazydev.nvim              | Lua dev support                                                                                                                         |
| LuaSnip                   | Snippet engine                                                                                                                          |
| markdown-preview.nvim     | Markdown preview                                                                                                                        |
| mason-lspconfig.nvim      | Mason LSP bridge                                                                                                                        |
| mason-tool-installer.nvim | Auto-install tools                                                                                                                      |
| mason.nvim                | LSP/tool installer                                                                                                                      |
| mini.nvim                 | File explorer, picker, statusline, notifications, text objects, pairs, surround, bracketed, key hints, git, diff, icons, misc utilities |
| nvim-dap                  | Debugging                                                                                                                               |
| nvim-dap-go               | Go DAP adapter                                                                                                                          |
| nvim-dap-python           | Python DAP adapter                                                                                                                      |
| nvim-dap-ui               | DAP UI                                                                                                                                  |
| nvim-dap-virtual-text     | DAP inline values                                                                                                                       |
| nvim-nio                  | Async library                                                                                                                           |
| nvim-lint                 | Async linting                                                                                                                           |
| obsidian.nvim             | Obsidian vault integration                                                                                                              |
| nvim-lspconfig            | LSP                                                                                                                                     |
| nvim-treesitter           | Syntax                                                                                                                                  |
| quicker.nvim              | Quickfix enhancement                                                                                                                    |
| sidekick.nvim             | AI assistant                                                                                                                            |
| tokyonight.nvim           | Theme                                                                                                                                   |
| trouble.nvim              | Diagnostics list                                                                                                                        |
| vim-tmux-navigator        | Tmux integration                                                                                                                        |
| plenary.nvim              | Lua utility library                                                                                                                     |
| yazi.nvim                 | Yazi file manager integration                                                                                                           |

## License

[MIT](LICENSE)
