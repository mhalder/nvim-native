local blink = require("blink.cmp")

local function ensure_blink_native()
  if blink.library_available() then
    return true
  end

  local home = vim.uv.os_homedir()
  local path_parts = {
    home .. "/.local/bin",
    home .. "/.cargo/bin",
  }

  for _, part in ipairs(path_parts) do
    if not vim.env.PATH:find(part, 1, true) then
      vim.env.PATH = part .. ":" .. vim.env.PATH
    end
  end

  if vim.fn.executable("cargo") ~= 1 then
    return false
  end

  local ok, err = pcall(function()
    blink.build({ force = true }):wait(600000)
  end)

  if not ok then
    vim.schedule(function()
      vim.notify("blink.cmp native build failed: " .. tostring(err), vim.log.levels.WARN)
    end)
  end

  return blink.library_available()
end

ensure_blink_native()

blink.setup({
  fuzzy = { implementation = "prefer_rust_with_warning" },
  signature = { enabled = true },
  snippets = { preset = "luasnip" },
  keymap = {
    preset = "default",
    ["<Tab>"] = { "snippet_forward", "select_next", "fallback" },
    ["<S-Tab>"] = { "snippet_backward", "select_prev", "fallback" },
    ["<C-d>"] = { "scroll_documentation_down", "fallback" },
    ["<C-u>"] = { "scroll_documentation_up", "fallback" },
  },
  sources = {
    default = { "lsp", "path", "snippets", "buffer" },
    per_filetype = {
      markdown = { "obsidian", "obsidian_new", "obsidian_tags", "path", "buffer" },
    },
  },
  completion = {
    documentation = { auto_show = true, auto_show_delay_ms = 500 },
    menu = {
      auto_show = true,
      draw = {
        -- selene: allow(mixed_table)
        columns = { { "kind_icon", "label", "label_description", gap = 1 }, { "kind" } },
      },
    },
  },
})

-- blink.cmp v2 compatibility: some revisions expose add_source_provider(),
-- but call a missing internal validator when external plugins (e.g. obsidian.nvim)
-- register providers at runtime.
if type(blink.add_source_provider) == "function" then
  local add_source_provider = blink.add_source_provider
  blink.add_source_provider = function(source_id, source_config)
    local ok, err = pcall(add_source_provider, source_id, source_config)
    if ok then
      return
    end

    if type(err) == "string" and err:match("already exists") then
      return
    end

    if type(err) == "string" and err:match("validate_provider") then
      local config = require("blink.cmp.config")
      if config.sources.providers[source_id] == nil then
        config.sources.providers[source_id] = source_config
      end
      return
    end

    error(err)
  end
end
