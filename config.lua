--[[
 THESE ARE EXAMPLE CONFIGS FEEL FREE TO CHANGE TO WHATEVER YOU WANT
 `lvim` is the global options object
]]
-- vim options
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.relativenumber = true

-- general
lvim.log.level = "warn"
lvim.format_on_save = {
  enabled = true,
  pattern = "*",
  timeout = 1000,
}
lvim.debug = false
vim.lsp.set_log_level "error"
lvim.lsp.code_lens_refresh = true
vim.diagnostic.config({ virtual_text = true })
lvim.builtin.dap.active = true
lvim.builtin.tag_provider = "symbols-outline"
lvim.builtin.noice = { active = true }
lvim.builtin.fancy_wild_menu = { active = true }
lvim.builtin.treesitter.rainbow.enable = true

-- to disable icons and use a minimalist setup, uncomment the following
-- lvim.use_icons = false
-- Override lunarvim defaults
-- =========================================
require("user.builtin").config()

-- Customization
-- =========================================
if vim.fn.has "nvim-0.9" == 1 then
  vim.opt.mousescroll = { "ver:1", "hor:6" }
  vim.o.mousefocus = true
  vim.o.mousemoveevent = true
  vim.o.splitkeep = "screen"
end

lvim.reload_config_on_save = true
-- cinnamon or neoscroll
lvim.builtin.smooth_scroll = "neoscroll"

lvim.builtin.treesitter.ensure_installed = {
  "lua",
  "rust",
  "toml",
  "http",
  "json",
  "vim",
  "markdown",
  "bash",
  "clojure"
}

vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "rust_analyzer" })

-- local formatters = require "lvim.lsp.null-ls.formatters"
-- formatters.setup {
--   { command = "stylua", filetypes = { "lua" } },
-- }

-- local mason_path = vim.fn.glob(vim.fn.stdpath "data" .. "/mason")


-- local codelldb_adapter = {
--   type = "server",
--   port = "$(port)",
--   name = "lldb",
--   executable = {
--     command = "~/.local/share/nvim/mason/bin/codelldb",
--     args = { "--port", "${port}" },
--     -- On windows may have to comment this
--     -- detached = false,
--   },
-- }
--

-- gui(neovide)
-- =========================================
vim.opt.guifont = "FiraCode Nerd Font:h14"
if vim.g.neovide then
  --vim.g.neovide_refresh_rate = 165
  vim.g.neovide_input_macos_alt_is_meta = true
end

-- keymappings <https://www.lunarvim.org/docs/configuration/keybindings>
lvim.leader = "space"
-- add your own keymapping
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
-- lvim.keys.normal_mode["I"] = ""

-- lvim.keys.normal_mode["<S-l>"] = ":BufferLineCycleNext<CR>"
-- lvim.keys.normal_mode["<S-h>"] = ":BufferLineCyclePrev<CR>"

-- -- Use which-key to add extra bindings with the leader-key prefix
-- lvim.builtin.which_key.mappings["W"] = { "<cmd>noautocmd w<cr>", "Save without formatting" }
lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }
-- lvim.builtin.which_key.mappings["t"] = { "<cmd>ToggleTerm<CR>", "Term" }
lvim.builtin.which_key.mappings["SPC"] = { "<cmd>Telescope commands<CR>", "commands" }

-- keybindings
-- =========================================
require("user.keybindings").config()

-- -- Change theme settings
lvim.colorscheme = "gruvbox"
vim.o.background = "light"

lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = true

-- Automatically install missing parsers when entering buffer
lvim.builtin.treesitter.auto_install = true

-- lvim.builtin.treesitter.ignore_install = { "haskell" }

-- -- generic LSP settings <https://www.lunarvim.org/docs/languages#lsp-support>

-- --- disable automatic installation of servers
-- lvim.lsp.installer.setup.automatic_installation = false

-- ---configure a server manually. IMPORTANT: Requires `:LvimCacheReset` to take effect
-- ---see the full default list `:lua =lvim.lsp.automatic_configuration.skipped_servers`
-- vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "pyright" })
-- local opts = {} -- check the lspconfig documentation for a list of all possible options
-- require("lvim.lsp.manager").setup("pyright", opts)

-- ---remove a server from the skipped list, e.g. eslint, or emmet_ls. IMPORTANT: Requires `:LvimCacheReset` to take effect
-- ---`:LvimInfo` lists which server(s) are skipped for the current filetype
-- lvim.lsp.automatic_configuration.skipped_servers = vim.tbl_filter(function(server)
--   return server ~= "emmet_ls"
-- end, lvim.lsp.automatic_configuration.skipped_servers)

-- -- you can set a custom on_attach function that will be used for all the language servers
-- -- See <https://github.com/neovim/nvim-lspconfig#keybindings-and-completion>
-- lvim.lsp.on_attach_callback = function(client, bufnr)
--   local function buf_set_option(...)
--     vim.api.nvim_buf_set_option(bufnr, ...)
--   end
--   --Enable completion triggered by <c-x><c-o>
--   buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
-- end

-- -- linters and formatters <https://www.lunarvim.org/docs/languages#lintingformatting>
-- local formatters = require "lvim.lsp.null-ls.formatters"
-- formatters.setup {
--   { command = "stylua" },
--   {
--     command = "prettier",
--     extra_args = { "--print-width", "100" },
--     filetypes = { "typescript", "typescriptreact" },
--   },
-- }
-- local linters = require "lvim.lsp.null-ls.linters"
-- linters.setup {
--   { command = "flake8", filetypes = { "python" } },
--   {
--     command = "shellcheck",
--     args = { "--severity", "warning" },
--   },
-- }

-- -- Additional Plugins <https://www.lunarvim.org/docs/plugins#user-plugins>
-- lvim.plugins = {
--     {
--       "folke/trouble.nvim",
--       cmd = "TroubleToggle",
--     },
-- }

-- Plugins
-- ========================================
require("user.plugins").config()

-- Languages
-- ========================================
-- rust
require("user.languages.rust").config()

-- -- Autocommands (`:help autocmd`) <https://neovim.io/doc/user/autocmd.html>
-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = "zsh",
--   callback = function()
--     -- let treesitter use bash highlight for zsh files as well
--     require("nvim-treesitter.highlight").attach(0, "bash")
--   end,
-- })
--
--
