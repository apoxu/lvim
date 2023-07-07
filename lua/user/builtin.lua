local M = {}
M.config = function()
  local kind = require "user.lsp_kind"

  -- CMP
  -- =========================================
  lvim.builtin.cmp.experimental = {
    ghost_text = true,
    --native_menu = true,
  }

  -- Dap
  -- =========================================
  if lvim.builtin.dap.active then
    lvim.builtin.dap.on_config_done = function()
      lvim.builtin.which_key.mappings["D"].name = " Debug"
    end
  end
end
return M
