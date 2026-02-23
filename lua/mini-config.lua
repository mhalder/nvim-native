require("mini.extra").setup()

local gen_ai_spec = require("mini.extra").gen_ai_spec
local spec_treesitter = require("mini.ai").gen_spec.treesitter
require("mini.ai").setup({
  custom_textobjects = {
    -- mini.extra specs
    B = gen_ai_spec.buffer(),
    D = gen_ai_spec.diagnostic(),
    I = gen_ai_spec.indent(),
    L = gen_ai_spec.line(),
    N = gen_ai_spec.number(),
    -- treesitter specs (requires nvim-treesitter-textobjects)
    F = spec_treesitter({ a = "@function.outer", i = "@function.inner" }),
    o = spec_treesitter({
      a = { "@conditional.outer", "@loop.outer" },
      i = { "@conditional.inner", "@loop.inner" },
    }),
    c = spec_treesitter({ a = "@class.outer", i = "@class.inner" }),
    C = spec_treesitter({ a = "@comment.outer", i = "@comment.inner" }),
    A = spec_treesitter({ a = "@assignment.outer", i = "@assignment.inner" }),
    R = spec_treesitter({ a = "@return.outer", i = "@return.inner" }),
  },
})

require("mini.cursorword").setup()
require("mini.trailspace").setup()

local hipatterns = require("mini.hipatterns")
hipatterns.setup({
  highlighters = {
    fixme = { pattern = "%f[%w]()FIXME()%f[%W]", group = "MiniHipatternsFixme" },
    hack = { pattern = "%f[%w]()HACK()%f[%W]", group = "MiniHipatternsHack" },
    todo = { pattern = "%f[%w]()TODO()%f[%W]", group = "MiniHipatternsTodo" },
    note = { pattern = "%f[%w]()NOTE()%f[%W]", group = "MiniHipatternsNote" },
    hex_color = hipatterns.gen_highlighter.hex_color(),
  },
})

require("mini.diff").setup()
require("mini.git").setup()
require("mini.icons").setup()
local MiniMisc = require("mini.misc")
MiniMisc.setup()
MiniMisc.setup_restore_cursor()
MiniMisc.setup_auto_root()
if not vim.env.LAZYGIT_LAUNCHED then
  MiniMisc.setup_termbg_sync()
end
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
require("mini.notify").setup()
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
require("mini.surround").setup({
  mappings = {
    add = "gz",
    delete = "gzd",
    find = "gzf",
    find_left = "gzF",
    highlight = "gzh",
    replace = "gzr",
    update_n_lines = "gzn",
  },
})

local miniclue = require("mini.clue")
miniclue.setup({
  triggers = {
    { mode = "n", keys = "<Leader>" },
    { mode = "x", keys = "<Leader>" },
    { mode = "i", keys = "<C-x>" },
    { mode = "n", keys = "g" },
    { mode = "x", keys = "g" },
    { mode = "n", keys = "gz" },
    { mode = "x", keys = "gz" },
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
    { mode = "n", keys = "<Leader>b", desc = "+buffer" },
    { mode = "n", keys = "<Leader>c", desc = "+code" },
    { mode = "x", keys = "<Leader>c", desc = "+code" },
    { mode = "n", keys = "<Leader>d", desc = "+debugging" },
    { mode = "n", keys = "<Leader>f", desc = "+find" },
    { mode = "n", keys = "<Leader>j", desc = "+quit/save" },
    { mode = "n", keys = "<Leader>o", desc = "+obsidian" },
    { mode = "x", keys = "<Leader>o", desc = "+obsidian" },
    { mode = "n", keys = "<Leader>t", desc = "+toggle" },
    { mode = "n", keys = "<Leader>w", desc = "+window" },
    { mode = "n", keys = "<Leader>x", desc = "+trouble" },
    { mode = "n", keys = "gh", desc = "apply hunk" },
    { mode = "x", keys = "gh", desc = "apply hunk" },
    { mode = "n", keys = "gH", desc = "reset hunk" },
    { mode = "x", keys = "gH", desc = "reset hunk" },
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
