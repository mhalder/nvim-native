require("render-markdown").setup({
  preset = "obsidian",
  file_types = { "markdown" },
  checkbox = {
    custom = {
      in_progress = {
        raw = "[~]",
        rendered = "󰰱 ",
        highlight = "RenderMarkdownWarn",
      },
      deferred = {
        raw = "[>]",
        rendered = " ",
        highlight = "RenderMarkdownInfo",
      },
    },
  },
})
