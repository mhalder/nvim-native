local skip_default_tags_for = {
  ["TODO.md"] = true,
  ["PLAN.md"] = true,
  ["CONTEXT.md"] = true,
  ["NEXT.md"] = true,
  ["SYSTEM.md"] = true,
  ["APPEND_SYSTEM.md"] = true,
  ["README.md"] = true,
  ["AGENTS.md"] = true,
}

require("obsidian").setup({
  workspaces = {
    {
      name = "pi",
      path = "~/vaults/pi",
      overrides = {
        notes_subdir = "inbox",
        new_notes_location = "notes_subdir",
        daily_notes = {
          folder = "daily",
        },
        templates = {
          folder = "templates",
          date_format = "%Y-%m-%d",
          time_format = "%H:%M",
        },
      },
    },
  },

  notes_subdir = "inbox",
  new_notes_location = "notes_subdir",

  -- Note ID: timestamp-slug format matching vault convention
  note_id_func = function(title)
    local suffix = ""
    if title ~= nil then
      suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
    else
      for _ = 1, 4 do
        suffix = suffix .. string.char(math.random(65, 90))
      end
    end
    return tostring(os.time()) .. "-" .. suffix
  end,

  -- Daily notes: match Obsidian app config (10-daily folder)
  daily_notes = {
    folder = "10-daily",
    date_format = "%Y-%m-%d",
    alias_format = "%B %-d, %Y",
    template = "daily.md",
    default_tags = { "daily" },
  },

  templates = {
    folder = "templates",
    date_format = "%Y-%m-%d",
    time_format = "%H:%M",
    substitutions = {
      yesterday = function()
        return os.date("%Y-%m-%d", os.time() - 86400)
      end,
      tomorrow = function()
        return os.date("%Y-%m-%d", os.time() + 86400)
      end,
      -- Obsidian app Moment.js date/time formats
      ["date:YYYY-MM-DD"] = function()
        return os.date("%Y-%m-%d")
      end,
      ["date:YYYYMMDDHHmm"] = function()
        return os.date("%Y%m%d%H%M")
      end,
      ["date:YYYY-MM-DD, dddd"] = function()
        return os.date("%Y-%m-%d, %A")
      end,
      ["time:HH:mm"] = function()
        return os.date("%H:%M")
      end,
      ["date-1d:YYYY-MM-DD"] = function()
        return os.date("%Y-%m-%d", os.time() - 86400)
      end,
      ["date+1d:YYYY-MM-DD"] = function()
        return os.date("%Y-%m-%d", os.time() + 86400)
      end,
    },
  },

  -- Frontmatter: preserve vault schema and avoid empty aliases: [] noise.
  frontmatter = {
    enabled = function(fname)
      if fname == nil then
        return true
      end
      return not skip_default_tags_for[vim.fs.basename(fname)]
    end,
    func = function(note)
      local out = { id = note.id, tags = note.tags }
      if note.aliases ~= nil and #note.aliases > 0 then
        out.aliases = note.aliases
      end
      if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
        for k, v in pairs(note.metadata) do
          out[k] = v
        end
      end
      return out
    end,
    sort = { "id", "tags", "aliases" },
  },

  completion = {
    nvim_cmp = false,
    blink = true,
    min_chars = 1,
  },

  picker = {
    name = "fzf-lua",
    note_mappings = {
      new = "<C-x>",
      insert_link = "<C-l>",
    },
  },

  -- Keymaps set via callbacks (mappings config is deprecated)
  callbacks = {
    ---@diagnostic disable-next-line: unused-local
    enter_note = function(_note)
      vim.keymap.set("n", "gf", "<cmd>Obsidian follow_link<cr>", { buffer = true, desc = "Follow link" })
      vim.keymap.set("n", "<leader>ch", "<cmd>Obsidian toggle_checkbox<cr>", {
        buffer = true,
        desc = "Toggle checkbox",
      })
      vim.keymap.set("n", "<cr>", function()
        vim.cmd("delmarks < >")
        return require("obsidian").util.smart_action()
      end, { buffer = true, expr = true })
      vim.keymap.set("v", "<cr>", ":Obsidian toggle_checkbox<cr>gv", { buffer = true })
    end,
  },

  link = {
    style = "wiki",
    wiki = function(opts)
      local header_or_block = ""
      if opts.anchor then
        header_or_block = string.format("#%s", opts.anchor.header)
      elseif opts.block then
        header_or_block = string.format("#%s", opts.block.id)
      end
      return string.format("[[%s%s]]", opts.label, header_or_block)
    end,
  },
  legacy_commands = false,

  -- Attachments: match Obsidian app config
  attachments = {
    folder = "attachments",
    img_name_func = function()
      return string.format("pasted-%s", os.date("%Y%m%d%H%M%S"))
    end,
    ---@diagnostic disable-next-line: unused-local
    img_text_func = function(_client, path)
      return string.format("![[%s]]", path.name)
    end,
    confirm_img_paste = false,
  },

  ui = {
    enable = false, -- render-markdown.nvim handles markdown rendering
  },

  footer = {
    enabled = true,
    format = "{{backlinks}} backlinks  {{words}} words",
    hl_group = "Comment",
  },

  checkbox = {
    enabled = true,
    create_new = true,
    order = { " ", "~", "!", ">", "x" },
  },
})
