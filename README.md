# Neovim Configuration

A modern Neovim configuration built with Lua, featuring AI assistance, LSP support, debugging, and a curated set of plugins.

## Requirements

- Neovim 0.11+ (uses native `vim.pack`)
- Git
- Rust/Cargo (for blink.cmp compilation)
- [GitHub CLI](https://cli.github.com/) (optional, for GitHub integration)

## Features

- AI Integration (Sidekick with Claude, GitHub Copilot)
- Full LSP support via nvim-lspconfig and Mason
- Autocompletion with blink.cmp and LuaSnip
- Debugging via DAP
- File navigation with Oil.nvim and Snacks.nvim picker
- GitHub integration (issues, PRs, git browse)
- Tokyo Night theme

## Installation

```bash
git clone https://github.com/yourusername/nvim ~/.config/nvim
nvim
```

Plugins will be installed automatically on first launch.

## Key Bindings

Leader key: `<Space>`

### Files & Search

| Key          | Description                 |
| ------------ | --------------------------- |
| `<leader>ff` | Find files                  |
| `<leader>fg` | Grep search                 |
| `<leader>fb` | List buffers                |
| `<leader>fh` | Help tags                   |
| `-`          | Open parent directory (Oil) |

### AI (Sidekick)

| Key          | Description          |
| ------------ | -------------------- |
| `<Tab>`      | Accept AI suggestion |
| `<leader>aa` | Toggle Sidekick      |
| `<leader>ac` | Toggle Claude        |
| `<leader>as` | Select CLI           |
| `<leader>ap` | Prompt               |
| `<C-.>`      | Focus Sidekick       |

### Debugging

| Key          | Description            |
| ------------ | ---------------------- |
| `<leader>dc` | Continue               |
| `<leader>do` | Step over              |
| `<leader>di` | Step into              |
| `<leader>du` | Step out               |
| `<leader>db` | Toggle breakpoint      |
| `<leader>dB` | Conditional breakpoint |
| `<leader>dr` | Open REPL              |
| `<leader>dt` | Terminate              |
| `<leader>dv` | Toggle DAP view        |

### Git

| Key          | Description   |
| ------------ | ------------- |
| `<leader>gi` | GitHub issues |
| `<leader>gp` | GitHub PRs    |
| `<leader>gB` | Git browse    |

### Quit/Save

| Key          | Description        |
| ------------ | ------------------ |
| `<leader>jj` | Quit               |
| `<leader>jk` | Save               |
| `<leader>jl` | Save and quit      |
| `<leader>j;` | Quit all (no save) |

## License

MIT
