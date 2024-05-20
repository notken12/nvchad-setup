return {
  {
    "stevearc/conform.nvim",
    event = "BufWritePre", -- uncomment for format on save
    config = function()
      require "configs.conform"
    end,
  },

  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    event = "VeryLazy",
    config = function()
      -- require("nvchad.configs.lspconfig").defaults()
      require "configs.lspconfig"
    end,
  },

  {
    "mrcjkb/rustaceanvim",
    version = "^4", -- Recommended
    lazy = false, -- This plugin is already lazy
    -- no setup function needed, works out of the box
    config = function()
      vim.lsp.inlay_hint.enable()
    end,
  },

  {
    "mfussenegger/nvim-dap",
    event = "VeryLazy",
    dependencies = {
      "williamboman/mason.nvim",
      "jay-babu/mason-nvim-dap.nvim",
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio",
    },
    config = function()
      require("mason").setup()
      require("mason-nvim-dap").setup()
      require("dapui").setup()
    end,
  },

  {
    "mfussenegger/nvim-jdtls",
  },

  {
    "NvChad/nvim-colorizer.lua",
    enabled = false,
  },

  {
    "brenoprata10/nvim-highlight-colors",
    event = "BufEnter",
    config = function()
      require("nvim-highlight-colors").setup {
        ---Render style
        ---@usage 'background'|'foreground'|'virtual'
        render = "virtual",

        ---Set virtual symbol (requires render to be set to 'virtual')
        virtual_symbol = "■",

        ---Highlight named colors, e.g. 'green'
        enable_named_colors = true,

        ---Highlight tailwind colors, e.g. 'bg-blue-500'
        enable_tailwind = true,
      }
    end,
  },

  -- {
  -- 	"williamboman/mason.nvim",
  -- 	opts = {
  -- 		ensure_installed = {
  -- 			"lua-language-server", "stylua",
  -- 			"html-lsp", "css-lsp" , "prettier"
  -- 		},
  -- 	},
  -- },
  --
  -- {
  -- 	"nvim-treesitter/nvim-treesitter",
  -- 	opts = {
  -- 		ensure_installed = {
  -- 			"vim", "lua", "vimdoc
  --      "html", "css"
  -- 		},
  -- 	},
  -- },
}
