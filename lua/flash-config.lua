require("flash").setup({
  modes = {
    char = {
      jump_labels = true,
    },
  },
})

local map = vim.keymap.set

map({ "n", "x", "o" }, "<CR>", function()
  require("flash").jump()
end, { desc = "flash" })

map({ "n", "x", "o" }, "gS", function()
  require("flash").treesitter()
end, { desc = "flash treesitter" })

map("o", "r", function()
  require("flash").remote()
end, { desc = "flash remote" })

map({ "o", "x" }, "R", function()
  require("flash").treesitter_search()
end, { desc = "flash treesitter search" })

map("c", "<C-s>", function()
  require("flash").toggle()
end, { desc = "toggle flash search" })
