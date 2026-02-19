require("blink.cmp").setup({
  signature = { enabled = true },
  snippets = { preset = "luasnip" },
  keymap = {
    preset = "default",
    ["<Tab>"] = { "snippet_forward", "select_next", "fallback" },
    ["<S-Tab>"] = { "snippet_backward", "select_prev", "fallback" },
  },
  sources = {
    default = { "obsidian", "obsidian_new", "obsidian_tags", "copilot", "lsp", "path", "snippets", "buffer" },
    providers = {
      copilot = {
        name = "copilot",
        module = "blink-copilot",
        async = true,
        score_offset = -1,
        transform_items = function(_, items)
          for _, item in ipairs(items) do
            item.kind_icon = ""
            item.kind_name = "copilot"
          end
          return items
        end,
      },
    },
  },
  completion = {
    documentation = { auto_show = true, auto_show_delay_ms = 500 },
    menu = {
      auto_show = true,
      draw = {
        treesitter = { "lsp" },
        -- selene: allow(mixed_table)
        columns = { { "kind_icon", "label", "label_description", gap = 1 }, { "kind" } },
      },
    },
  },
})
