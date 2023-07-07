local M = {}

M.config = function()
  lvim.plugins = {
    -- notify
    {
      "rcarriga/nvim-notify"
    },

    -- noice
    {
      "folke/noice.nvim"
    },

    -- nui.nvim
    {
      "MunifTanjim/nui.nvim"
    },

    -- novice
    -- {
    --   "folke/noice.nvim",
    --   event = "VeryLazy",
    --   config = function()
    --     require("user.noice").config()
    --   end,
    --   dependencies = {
    --     "rcarriga/nvim-notify",
    --   },
    --   -- enabled = lvim.builtin.noice.active,
    -- },

    -- symbols-outline
    {
      "simrat39/symbols-outline.nvim",
      config = function()
        require("user.symbols_outline").config()
      end,
      event = "BufReadPost",
      enabled = lvim.builtin.tag_provider == "symbols-outline",
    },

    -- neoscroll(smooth_scroll)
    {
      "karb94/neoscroll.nvim",
      config = function()
        require("neoscroll").setup {
          easing_function = "quadratic",
          hide_cursor = true,
        }
      end,
      event = "BufRead",
      enabled = lvim.builtin.smooth_scroll == "neoscroll",
    },

    -- cinnamon(smooth_scroll)
    {
      "declancm/cinnamon.nvim",
      config = function()
        require("cinnamon").setup {
          default_keymaps = true,
          default_delay = 4,
          extra_keymaps = true,
          extended_keymaps = false,
          centered = true,
          scroll_limit = 100,
        }
      end,
      event = "BufRead",
      enabled = lvim.builtin.smooth_scroll == "cinnamon",
    },

    -- gruvbox(theme)
    {
      "ellisonleao/gruvbox.nvim",
    },

    -- neovim version of easymotion
    {
      "phaazon/hop.nvim",
      event = "BufRead",
      config = function()
        require("hop").setup()
        vim.api.nvim_set_keymap("n", "s", ":HopChar2<cr>", { silent = true })
        vim.api.nvim_set_keymap("n", "S", ":HopWord<cr>", { silent = true })
      end,
    },

    -- rust-tools
    {
      "simrat39/rust-tools.nvim"
    },

    -- crates(rust)
    {
      "saecki/crates.nvim",
      dependencies = { "nvim-lua/plenary.nvim" },
      config = function()
        require("crates").setup {
          null_ls = {
            enabled = true,
            name = "crates.nvim",
          },
          popup = {
            border = "rounded",
          },
        }
      end,
    },

    -- fidget(better lsp server monitor)
    {
      "j-hui/fidget.nvim",
      config = function()
        require("fidget").setup()
      end,
    },

    -- ron
    {
      "ron-rs/ron.vim",
    },

    -- LspUI
    {
      "jinzhongjia/LspUI.nvim",
      event = "VeryLazy",
      config = function()
        require("LspUI").setup()
      end,
    },
  }
end
return M
