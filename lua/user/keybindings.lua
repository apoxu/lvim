local M = {}
M.config = function()
  lvim.builtin.which_key.mappings["t"] = {
    name = "Diagnostics",
    d = { "<cmd>Trouble document_diagnostics<cr>", "Document" },
    f = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" },
    l = { "<cmd>Trouble loclist<cr>", "LocationList" },
    q = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
    r = { "<cmd>Trouble lsp_references<cr>", "References" },
    t = { "<cmd>TroubleToggle<cr>", "Trouble" },
    w = { "<cmd>Trouble workspace_diagnostics<cr>", "Workspace" },
  }

  lvim.builtin.which_key.mappings["o"] = {
    name = "Open",
    t = { "<cmd>ToggleTerm<cr>", "FloatTerminal" },
    r = { "<Plug>RestNvim", "restnvim" }
  }
  lvim.builtin.which_key.mappings["oh"] = {
    name = "+Harpoon",
    f = { "<cmd>lua require('harpoon.mark').add_file()<cr>", "Add File" }
  }
end
return M
