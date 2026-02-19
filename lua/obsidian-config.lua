require("obsidian").setup({
  workspaces = {
    {
      name = "terminus",
      path = "~/vaults/terminus",
    },
    {
      name = "trantor",
      path = "~/vaults/trantor",
    },
    {
      name = "new-terminus",
      path = "~/vaults/new-terminus",
    },
  },

  -- Match Obsidian app: new files go to 00-inbox
  notes_subdir = "00-inbox",
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

  -- Frontmatter: preserve vault schema (id, type, tags, created)
  frontmatter = {
    enabled = true,
  },

  completion = {
    nvim_cmp = false,
    blink = true,
    min_chars = 2,
  },

  picker = {
    name = "mini.pick",
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

  preferred_link_style = "wiki",
  wiki_link_func = "use_alias_only",
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
    enable = true,
  },

  footer = {
    enabled = true,
    format = "{{backlinks}} backlinks  {{words}} words",
    hl_group = "Comment",
  },

  checkbox = {
    order = { " ", "x", ">", "~" },
    [" "] = { char = "󰄱", hl_group = "ObsidianTodo" },
    ["x"] = { char = "", hl_group = "ObsidianDone" },
    [">"] = { char = "", hl_group = "ObsidianRightArrow" },
    ["~"] = { char = "󰰱", hl_group = "ObsidianTilde" },
  },
})
