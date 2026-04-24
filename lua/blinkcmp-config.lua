local blink = require("blink.cmp")

local function ensure_path(parts)
  for _, part in ipairs(parts) do
    if not vim.env.PATH:find(part, 1, true) then
      vim.env.PATH = part .. ":" .. vim.env.PATH
    end
  end
end

local function ensure_blink_native()
  if blink.library_available() then
    return true
  end

  local home = vim.uv.os_homedir()
  ensure_path({ home .. "/.local/bin", home .. "/.cargo/bin" })

  if vim.fn.executable("cargo") ~= 1 then
    vim.notify("cargo missing; cannot build blink.cmp native library", vim.log.levels.ERROR)
    return false
  end

  local native = require("blink.lib.native")
  local repo = native.git_repo_root(debug.getinfo(blink.library_available, "S").source:sub(2))
  local commit = native.git_commit(repo)
  local platform = native.platform()
  local src = repo .. "/target/release/libblink_cmp_fuzzy" .. platform.lib_extension
  local dst = native.library_path("blink_cmp_fuzzy", commit)

  local build = vim.system({ "cargo", "build", "--release" }, { cwd = repo }):wait()
  if build.code ~= 0 then
    local msg = build.stderr ~= "" and build.stderr or build.stdout
    vim.notify("blink.cmp native build failed:\n" .. msg, vim.log.levels.ERROR)
    return false
  end

  local dir = vim.fs.dirname(dst)
  vim.fn.mkdir(dir, "p")
  local install = vim.system({ "install", "-m", "755", src, dst }):wait()
  if install.code ~= 0 then
    local msg = install.stderr ~= "" and install.stderr or install.stdout
    vim.notify("blink.cmp native install failed:\n" .. msg, vim.log.levels.ERROR)
    return false
  end

  return blink.library_available()
end

if not ensure_blink_native() then
  vim.schedule(function()
    vim.notify("blink.cmp native library unavailable after build; completion disabled for this session", vim.log.levels.ERROR)
  end)
  return
end

blink.setup({
  fuzzy = { implementation = "rust" },
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
