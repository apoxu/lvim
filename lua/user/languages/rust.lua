local M = {}

M.config = function()
local extension_path = vim.env.HOME .. '/.local/share/nvim/mason/packages/codelldb/extension/'
local codelldb_path = extension_path .. 'adapter/codelldb'
-- local libcodelldb.dylib_path = extension_path .. 'adapter/libcodelldb.dylib'
local liblldb_path = extension_path .. 'lldb/lib/liblldb.dylib'

pcall(function()
  require("rust-tools").setup {
    tools = {
      executor = require("rust-tools/executors").termopen, -- can be quickfix or termopen
      reload_workspace_from_cargo_toml = true,
      runnables = {
        use_telescope = true,
      },
      inlay_hints = {
        auto = true,
        only_current_line = false,
        show_parameter_hints = true,
        parameter_hints_prefix = "<-",
        other_hints_prefix = "=>",
        max_len_align = false,
        max_len_align_padding = 1,
        right_align = false,
        right_align_padding = 7,
        highlight = "Comment",
      },
      hover_actions = {
        border = "rounded",
      },
      on_initialized = function()
        vim.api.nvim_create_autocmd({ "BufWritePost", "BufEnter", "CursorHold", "InsertLeave" }, {
          pattern = { "*.rs" },
          callback = function()
            local _, _ = pcall(vim.lsp.codelens.refresh)
          end,
        })
      end,
    },
    dap = {
      adapter = require('rust-tools.dap').get_codelldb_adapter(codelldb_path, liblldb_path)
    },
    server = {
      on_attach = function(client, bufnr)
        require("lvim.lsp").common_on_attach(client, bufnr)
        local rt = require "rust-tools"
        vim.keymap.set("n", "K", rt.hover_actions.hover_actions, { buffer = bufnr })
      end,

      capabilities = require("lvim.lsp").common_capabilities(),
      settings = {
        ["rust-analyzer"] = {
          lens = {
            enable = true,
          },
          checkOnSave = {
            enable = true,
            command = "clippy",
          },
        },
      },
    },
  }
end)

lvim.builtin.dap.on_config_done = function(dap)
  dap.adapters.codelldb = require('rust-tools.dap').get_codelldb_adapter(codelldb_path, liblldb_path)
  dap.configurations.rust = {
    {
      name = "Launch",
      type = "codelldb",
      request = "launch",
      program = function()
        return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
      end,
      cwd = "${workspaceFolder}",
      stopOnEntry = false,
    },
  }
end

vim.api.nvim_set_keymap("n", "<m-d>", "<cmd>RustOpenExternalDocs<Cr>", { noremap = true, silent = true })

lvim.builtin.which_key.mappings["C"] = {
  name = "Rust",
  r = { "<cmd>RustRunnables<Cr>", "Runnables" },
  t = { "<cmd>lua _CARGO_TEST()<cr>", "Cargo Test" },
  m = { "<cmd>RustExpandMacro<Cr>", "Expand Macro" },
  c = { "<cmd>RustOpenCargo<Cr>", "Open Cargo" },
  p = { "<cmd>RustParentModule<Cr>", "Parent Module" },
  d = { "<cmd>RustDebuggables<Cr>", "Debuggables" },
  v = { "<cmd>RustViewCrateGraph<Cr>", "View Crate Graph" },
  R = {
    "<cmd>lua require('rust-tools/workspace_refresh')._reload_workspace_from_cargo_toml()<Cr>",
    "Reload Workspace",
  },
  o = { "<cmd>RustOpenExternalDocs<Cr>", "Open External Docs" },
  y = { "<cmd>lua require'crates'.open_repository()<cr>", "[crates] open repository" },
  P = { "<cmd>lua require'crates'.show_popup()<cr>", "[crates] show popup" },
  i = { "<cmd>lua require'crates'.show_crate_popup()<cr>", "[crates] show info" },
  f = { "<cmd>lua require'crates'.show_features_popup()<cr>", "[crates] show features" },
  D = { "<cmd>lua require'crates'.show_dependencies_popup()<cr>", "[crates] show dependencies" },
}
end
return M
