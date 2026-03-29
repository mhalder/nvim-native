local dap, dapui = require("dap"), require("dapui")

require("dap-go").setup()
require("dap-python").setup("uv")
require("nvim-dap-virtual-text").setup({})
dapui.setup()

-- nvim-dap uses legacy sign_place which doesn't render on nvim 0.12+
-- override toggle_breakpoint to place extmark signs instead
local bp_ns = vim.api.nvim_create_namespace("dap_breakpoint_signs")
local bp_signs = {
  DapBreakpoint = { text = "\u{f28d}", hl = "DiagnosticError" },
  DapBreakpointCondition = { text = "\u{f059}", hl = "DiagnosticWarn" },
  DapStopped = { text = "\u{f04b}", hl = "DiagnosticOk", linehl = "DiffAdd" },
}

local orig_toggle = dap.toggle_breakpoint
dap.toggle_breakpoint = function(...)
  local bufnr = vim.api.nvim_get_current_buf()
  local lnum = vim.api.nvim_win_get_cursor(0)[1]
  local marks = vim.api.nvim_buf_get_extmarks(bufnr, bp_ns, { lnum - 1, 0 }, { lnum - 1, 0 }, {})
  if #marks > 0 then
    for _, mark in ipairs(marks) do
      vim.api.nvim_buf_del_extmark(bufnr, bp_ns, mark[1])
    end
  else
    local sign = bp_signs.DapBreakpoint
    vim.api.nvim_buf_set_extmark(bufnr, bp_ns, lnum - 1, 0, {
      sign_text = sign.text,
      sign_hl_group = sign.hl,
    })
  end
  return orig_toggle(...)
end

-- Rust debugging with codelldb
local codelldb_path = vim.fn.stdpath("data") .. "/mason/packages/codelldb/extension/adapter/codelldb"

dap.adapters.codelldb = {
  type = "server",
  port = "${port}",
  executable = {
    command = codelldb_path,
    args = { "--port", "${port}" },
  },
}

dap.configurations.rust = {
  {
    name = "Launch file",
    type = "codelldb",
    request = "launch",
    program = function()
      return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/target/debug/", "file")
    end,
    cwd = "${workspaceFolder}",
    stopOnEntry = false,
  },
}

dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end

dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end

dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end
