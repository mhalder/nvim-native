---@type opencode.Opts
vim.g.opencode_opts = {}

vim.o.autoread = true

local map = vim.keymap.set

map({ "n", "x" }, "<leader>aoa", function()
  require("opencode").ask("@this: ", { submit = true })
end, { desc = "opencode ask" })
map({ "n", "x" }, "<leader>aox", function()
  require("opencode").select()
end, { desc = "opencode select" })
map({ "n", "t" }, "<leader>aot", function()
  require("opencode").toggle()
end, { desc = "opencode toggle" })
map({ "n", "x" }, "go", function()
  return require("opencode").operator("@this ")
end, { desc = "opencode add range", expr = true })
map("n", "goo", function()
  return require("opencode").operator("@this ") .. "_"
end, { desc = "opencode add line", expr = true })
