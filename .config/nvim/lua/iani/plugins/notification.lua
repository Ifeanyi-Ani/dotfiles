return {
  {
    "rcarriga/nvim-notify",
    event = "VeryLazy",
    opts = {
      background_colour = "#000000",
      fps = 30,
      icons = {
        DEBUG = "",
        ERROR = "",
        INFO = "",
        TRACE = "✎",
        WARN = "",
      },
      level = 2,
      minimum_width = 50,
      render = "default",
      stages = "fade_in_slide_out",
      timeout = 5000,
      top_down = false,
      position = "top",
    },
    config = function(_, opts)
      local notify = require("notify")
      notify.setup(opts)
      vim.notify = notify
    end,
  },
  {
    "ray-x/lsp_signature.nvim",
    event = "VeryLazy",
    opts = {
      bind = true,
      doc_lines = 2,
      floating_window = true,
      fix_pos = true,
      hint_enable = true,
      hint_prefix = "🐼 ",
      hint_scheme = "String",
      hi_parameter = "Search",
      max_height = 22,
      max_width = 120, -- max_width of signature floating_window, line will be wrapped if exceed max_width
      handler_opts = {
        border = "rounded", -- double, single, shadow, none
      },
      zindex = 200, -- by default it will be on top of all floating windows, set to 50 send it to bottom
      padding = "", -- character to pad on left and right of signature can be ' ', or '|'  etc
    },
    config = function(_, opts)
      require("lsp_signature").setup(opts)
    end,
  },
  {
    "folke/noice.nvim",
    enabled = false, -- Disable noice.nvim
  },
  {
    "echasnovski/mini.notify",
    event = "VeryLazy",
    config = function()
      require("mini.notify").setup({
        -- Customize as needed
        lsp_progress = {
          enable = true,
          format = "lsp_progress",
        },
        cmdline = {
          enable = true,
          format = "cmdline",
        },
      })
    end,
  },
}
