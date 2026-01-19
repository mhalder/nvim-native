require("obsidian").setup({
  workspaces = {
    {
      name = "terminus",
      path = "~/terminus",
    },
  },

  notes_subdir = "notes",
  new_notes_location = "notes_subdir",

  daily_notes = {
    folder = "daily",
    date_format = "%Y-%m-%d",
    alias_format = "%B %-d, %Y",
    default_tags = { "daily" },
  },

  templates = {
    folder = "templates",
    date_format = "%Y-%m-%d",
    time_format = "%H:%M",
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

  preferred_link_style = "wiki",
  legacy_commands = false,

  ui = {
    enable = true,
  },

  checkbox = {
    order = { " ", "x", ">", "~" },
    [" "] = { char = "󰄱", hl_group = "ObsidianTodo" },
    ["x"] = { char = "", hl_group = "ObsidianDone" },
    [">"] = { char = "", hl_group = "ObsidianRightArrow" },
    ["~"] = { char = "󰰱", hl_group = "ObsidianTilde" },
  },
})
