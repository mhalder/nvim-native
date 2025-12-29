require("mason-tool-installer").setup({
  ensure_installed = {"debugpy"}
})

require("dap-python").setup("uv")
require("nvim-dap-virtual-text").setup({})
