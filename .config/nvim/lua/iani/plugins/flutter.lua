-- plugins/flutter.lua
return {
  -- Flutter tools for Neovim
  {
    "akinsho/flutter-tools.nvim",
    lazy = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "stevearc/dressing.nvim", -- optional for improved UI
    },
    config = function()
      require("flutter-tools").setup({
        ui = {
          border = "rounded",
          notification_style = "native",
        },
        decorations = {
          statusline = {
            app_version = true,
            device = true,
          },
        },
        widget_guides = {
          enabled = true,
        },
        closing_tags = {
          highlight = "ErrorMsg",
          prefix = "//",
          enabled = true,
        },
        dev_log = {
          open_cmd = "tabedit",
        },
        dev_tools = {
          autostart = false,
          auto_open_browser = false,
        },
        outline = {
          open_cmd = "30vnew",
          auto_open = false,
        },
        lsp = {
          color = {
            enabled = true,
            background = true,
            foreground = false,
            virtual_text = true,
            virtual_text_str = "■",
          },
          settings = {
            showTodos = true,
            completeFunctionCalls = true,
            renameFilesWithClasses = "prompt",
            enableSnippets = true,
            updateImportsOnRename = true,
          },
          on_attach = function(client, bufnr)
            -- Enable folding
            vim.wo.foldmethod = "expr"
            vim.wo.foldexpr = "nvim_treesitter#foldexpr()"

            -- Set up signature help
            require("lsp_signature").on_attach({
              bind = true,
              handler_opts = {
                border = "rounded",
              },
              hint_enable = true,
              hint_prefix = "🔍 ",
              hint_scheme = "String",
              hi_parameter = "Search",
              max_height = 12,
              max_width = 120,
              padding = " ",
            }, bufnr)
          end,
        },
      })
    end,
  },

  -- Dart syntax highlighting and more
  {
    "dart-lang/dart-vim-plugin",
    ft = { "dart" },
  },

  -- Snippets for Flutter
  {
    "nash0x7e2/awesome-flutter-snippets",
    ft = { "dart" },
  },

  -- For better Dart highlighting with TreeSitter
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      local configs = require("nvim-treesitter.configs")
      configs.setup({
        ensure_installed = { "dart", "yaml", "json", "markdown" },
        highlight = { enable = true },
        indent = { enable = true },
      })
    end,
  },
}
