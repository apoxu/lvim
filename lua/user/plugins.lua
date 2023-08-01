local M = {}

M.config = function()
  lvim.plugins = {
    -- correctly setup mason lsp extensions
    -- {
    --   "williamboman/mason.nvim",
    --   opts = function()
    --     ensure_installed = { "rust-analyzer", "taplo" },
    --         vim.list_extend(opts.ensure_installed, { "rust-analyzer", "taplo" })
    --   end
    -- },

    --correctly setup mason dap extensinos
    {
      "jay-babu/mason-nvim-dap.nvim",
      dependencies = "maosn.nvim",
      cmd = { "DapInstall", "DapUninstall" },
      opts = {
        automatic_installation = true,
        -- vim.list_extend(opts.ensure_installed, { "codelldb" })
        ensure_installed = { "codelldb" }
      },
    },

    -- nvim-ts-context-commentstring
    {
      "JoosepAlviste/nvim-ts-context-commentstring",
      lazy = true,
      event = { "User FileOpened" },
    },

    -- goto-preview
    {
      "rmagatti/goto-preview",
      lazy = true,
      keys = { "gp" },
      config = function()
        require("goto-preview").setup({
          width = 120,
          height = 25,
          default_mappings = true,
          debug = false,
          opacity = nil,
          post_open_hook = nil,
        })
      end
    },

    -- hilight todos
    {
      "folke/todo-comments.nvim",
      lazy = true,
      event = { "User FileOpened" },
      config = function()
        require("todo-comments").setup()
      end
    },

    -- nvim-surround
    {
      "kylechui/nvim-surround",
      lazy = true,
      keys = { "cs", "ds", "ys" },
      config = function()
        require("nvim-surround").setup()
      end
    },

    -- better eacape
    {
      "max397574/better-escape.nvim",
      lazy = true,
      event = { "InsertEnter" },
      config = function()
        require("better_escape").setup({
          mapping = { "jk" },
          timeout = 200,
          clear_empty_lines = false,
          keys = "<Esc>",
        })
      end,
    },

    -- neodim: make unused varibles gray
    {
      "zbirenbaum/neodim",
      lazy = true,
      event = "LspAttach",
      config = function()
        require("neodim").setup({
          alpha = 0.75,
          blend_color = "#000000",
          update_in_insert = {
            enable = true,
            delay = 100,
          },
          hide = {
            virtual_text = true,
            signs = false,
            underline = false,
          },
        })
      end,
    },


    -- colorful-winsep.nvim
    {
      "nvim-zh/colorful-winsep.nvim",
      lazy = true,
      event = "WinNew",
      config = function()
        require("colorful-winsep").setup()
      end
    },

    -- oceanicnext: theme
    {
      "mhartington/oceanic-next",
      priority = 1000,
      lazy = lvim.colorscheme ~= "OceanicNext",
    },

    -- harpoon
    {
      "ThePrimeagen/harpoon",
      lazy = true,
      cmd = "Telescope harpoon marks",
      dependencies = {
        "nvim-lua/plenary.nvim",
      },
      config = function()
        require("harpoon").setup()
        require("telescope").load_extension("harpoon")
      end,
    },

    -- nvim-treesitter-context
    {
      "romgrk/nvim-treesitter-context",
      lazy = true,
      event = { "User FileOpened" },
      config = function()
        require("treesitter-context").setup({
          enable = true,
          throttle = true,
          max_lines = 0,
          patterns = {
            default = {
              "class",
              "function",
              "method",
            },
          },
        })
      end,
    },

    -- nvim-ts-rainbow
    {
      "HiPhish/nvim-ts-rainbow2",
      -- Bracket pair rainbow colorize
      lazy = true,
      event = { "User FileOpened" },
    },

    -- filetype.nvim
    {
      "nathom/filetype.nvim",
      lazy = true,
      event = { "BufRead", "BufNewFile" },
      config = function()
        require("filetype").setup({
          overrides = {
            extensions = {
              h = "cpp",
            },
          }
        })
      end
    },

    -- rest.nvim
    {
      "rest-nvim/rest.nvim",
      dependencies = { "nvim-lua/plenary.nvim" },
      --lazy = true,
      config = function()
        require("rest-nvim").setup {
          -- Open request results in a horizontal split
          result_split_horizontal = false,
          -- Keep the http file buffer above|left when split horizontal|vertical
          result_split_in_place = false,
          -- Skip SSL verification, useful for unknown certificates
          skip_ssl_verification = false,
          -- Encode URL before making request
          encode_url = true,
          -- Highlight request on run
          highlight = {
            enabled = true,
            timeout = 150,
          },
          result = {
            -- toggle showing URL, HTTP info, headers at top the of result window
            show_url = true,
            -- show the generated curl command in case you want to launch
            -- the same request via the terminal (can be verbose)
            show_curl_command = false,
            show_http_info = true,
            show_headers = true,
            -- executables or functions for formatting response body [optional]
            -- set them to false if you want to disable them
            formatters = {
              json = "jq",
              html = function(body)
                return vim.fn.system({ "tidy", "-i", "-q", "-" }, body)
              end
            },
          },
          -- Jump to request line on run
          jump_to_request = false,
          env_file = '.env',
          custom_dynamic_variables = {},
          yank_dry_run = true,
        }
      end,
    },

    -- twilight.nvim
    {
      "folke/twilight.nvim",
      --event = "VeryLazy",
      lazy = true,
      config = function()
        require("user.twilight").config()
      end,
    },

    -- trouble.nvim
    {
      "folke/trouble.nvim",
      dependencies = { "nvim-tree/nvim-web-devicons" },
      cmd = { "TroubleToggle", "Trouble", "TroubleRefresh" },
      config = function()
        require("trouble").setup()
      end,
      event = "VeryLazy",
    },

    -- nui.nvim
    {
      "munifTanjim/nui.nvim"
    },

    -- noice.nvim
    {
      "folke/noice.nvim",
      event = "VeryLazy",
      config = function()
        require("user.noice").config()
      end,
      dependencies = {
        "rcarriga/nvim-notify",
      },
      enabled = lvim.builtin.noice.active,
    },

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
      priority = 1000,
      lazy = lvim.colorscheme ~= "gruvbox"
    },

    -- neovim version of easymotion
    -- {
    --   "phaazon/hop.nvim",
    --   event = "BufRead",
    --   config = function()
    --     require("hop").setup()
    --     vim.api.nvim_set_keymap("n", "s", ":HopChar2<cr>", { silent = true })
    --     vim.api.nvim_set_keymap("n", "S", ":HopWord<cr>", { silent = true })
    --   end,
    -- },

    {
      "folke/flash.nvim",
      event = "VeryLazy",
      -- ---@type Flash.Config
      opts = {},
      keys = {
        {
          "s",
          mode = { "n", "x", "o" },
          function()
            require("flash").jump()
          end,
          desc = "Flash",
        },
        {
          "S",
          mode = { "n", "o", "x" },
          function()
            require("flash").treesitter()
          end,
          desc = "Flash Treesitter",
        },
        {
          "r",
          mode = "o",
          function()
            require("flash").remote()
          end,
          desc = "Remote Flash",
        },
        {
          "R",
          mode = { "o", "x" },
          function()
            require("flash").treesitter_search()
          end,
          desc = "Flash Treesitter Search",
        },
        {
          "<c-s>",
          mode = { "c" },
          function()
            require("flash").toggle()
          end,
          desc = "Toggle Flash Search",
        },
      },
    },

    -- rust-tools
    {
      "simrat39/rust-tools.nvim"
    },

    -- crates(rust)
    {
      "saecki/crates.nvim",
      event = "VeryLazy",
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

    -- -- fidget(better lsp server monitor)
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
