return {
  {
    "rose-pine/neovim",
    name = "rose-pine",
    -- priority = 1000,
    config = function()
      require("rose-pine").setup({

        variant = "main", -- auto, main, moon, or dawn
        dark_variant = "main", -- main, moon, or dawn
        dim_inactive_windows = false,
        disable_background = true,
        disable_nc_background = false,
        disable_float_background = false,
        extend_background_behind_borders = false,

        enable = {
          terminal = true,
          legacy_highlights = true, -- Improve compatibility for previous versions of Neovim
          migrations = true, -- Handle deprecated options automatically
        },

        styles = {
          bold = true,
          italic = false,
          transparency = true,
        },

        highlight_groups = {
          ColorColumn = { bg = "#1C1C21" },
        },

        groups = {
          border = "muted",
          link = "iris",
          -- panel = "surface",

          error = "love",
          hint = "iris",
          info = "foam",
          note = "pine",
          todo = "rose",
          warn = "gold",

          git_add = "foam",
          git_change = "rose",
          git_delete = "love",
          git_dirty = "rose",
          git_ignore = "muted",
          git_merge = "iris",
          git_rename = "pine",
          git_stage = "iris",
          git_text = "rose",
          git_untracked = "subtle",

          h1 = "iris",
          h2 = "foam",
          h3 = "rose",
          h4 = "gold",
          h5 = "pine",
          h6 = "foam",
        },
      })

      vim.cmd("colorscheme rose-pine")
    end,
  },
  {
    "folke/tokyonight.nvim",
    -- priority = 1000,
    config = function()
      local transparent = true

      local bg = "#011628"
      local bg_dark = "#011423"
      local bg_highlight = "#143652"
      local bg_search = "#0A64AC"
      local bg_visual = "#275378"
      local fg = "#CBE0F0"
      local fg_dark = "#B4D0E9"
      local fg_gutter = "#627E97"
      local border = "#547998"
      require("tokyonight").setup({
        style = "night",
        transparent = transparent,
        styles = {
          sidebars = transparent and "transparent" or "dark",
          floats = transparent and "transparent" or "dark",
        },
        on_colors = function(colors)
          colors.bg = bg
          colors.bg_dark = transparent and colors.none or bg_dark
          colors.bg_float = transparent and colors.none or bg_dark
          colors.bg_highlight = bg_highlight
          colors.bg_popup = bg_dark
          colors.bg_search = bg_search
          colors.bg_sidebar = transparent and colors.none or bg_dark
          colors.bg_statusline = transparent and colors.none or bg_dark
          colors.bg_visual = bg_visual
          colors.border = border
          colors.fg = fg
          colors.fg_dark = fg_dark
          colors.fg_float = fg
          colors.fg_gutter = fg_gutter
          colors.fg_sidebar = fg_dark
        end,
        on_highlights = function(hl, c)
          hl.CursorLine = { bg = c.bg_highlight }
          hl.CursorColumn = { bg = c.bg_highlight }
          hl.ColorColumn = { bg = c.bg_highlight }
          hl.LineNr = { fg = c.fg_gutter }
          hl.SignColumn = { bg = c.bg, fg = c.fg_gutter }
          hl.VertSplit = { fg = c.border, bg = c.bg }
          hl.TabLine = { bg = c.bg_dark, fg = c.fg_dark }
          hl.TabLineFill = { bg = c.bg_dark }
          hl.TabLineSel = { bg = c.bg, fg = c.fg }
          hl.NormalFloat = { bg = c.bg_float, fg = c.fg }
          hl.FloatBorder = { bg = c.bg_float, fg = c.border }
          hl.LspReferenceText = { bg = c.bg_highlight }
          hl.LspReferenceRead = { bg = c.bg_highlight }
          hl.LspReferenceWrite = { bg = c.bg_highlight }
          hl.DiagnosticVirtualTextError = { fg = c.red }
          hl.DiagnosticVirtualTextWarn = { fg = c.orange }
          hl.DiagnosticVirtualTextInfo = { fg = c.blue }
          hl.DiagnosticVirtualTextHint = { fg = c.teal }
        end,
      })
      -- vim.cmd("colorscheme tokyonight")
    end,
  },

  {
    "Mofiqul/dracula.nvim",
    config = function()
      local colors = {
        bg = "NONE",
        fg = "#F8F8F2",
        selection = "#44475A",
        comment = "#6272A4",
        red = "#FF5555",
        orange = "#FFB86C",
        yellow = "#F1FA8C",
        green = "#50fa7b",
        purple = "#BD93F9",
        cyan = "#8BE9FD",
        pink = "#FF79C6",
        bright_red = "#FF6E6E",
        bright_green = "#69FF94",
        bright_yellow = "#FFFFA5",
        bright_blue = "#D6ACFF",
        bright_magenta = "#FF92DF",
        bright_cyan = "#A4FFFF",
        bright_white = "#FFFFFF",
        menu = "NONE",
        visual = "#3E4452",
        gutter_fg = "#4B5263",
        nontext = "#3B4048",
        white = "#ABB2BF",
        black = "NONE",
      }

      require("dracula").setup({
        colors = colors,
        show_end_of_buffer = true,
        transparent_bg = true,
        lualine_bg_color = "NONE",
        italic_comment = true,
        overrides = function(c)
          return {
            Normal = { bg = "NONE" },
            NormalNC = { bg = "NONE" },
            SignColumn = { bg = "NONE" },
            MsgArea = { bg = "NONE" },
            TelescopeBorder = { bg = "NONE" },
            NormalFloat = { bg = "NONE" },
            FloatBorder = { bg = "NONE" },
            FloatTitle = { bg = "NONE" },
            NonText = { fg = c.white },
            NvimTreeIndentMarker = { link = "NonText" },

            Pmenu = { bg = "NONE", fg = c.fg },
            PmenuSel = { bg = c.selection, fg = c.fg },
            PmenuSbar = { bg = "NONE" },
            PmenuThumb = { bg = c.selection },

            TelescopeNormal = { bg = "NONE" },
            TelescopePrompt = { bg = "NONE" },
            TelescopeResults = { bg = "NONE" },
            TelescopePreview = { bg = "NONE" },
            TelescopePromptBorder = { bg = "NONE", fg = c.white },
            TelescopeResultsBorder = { bg = "NONE", fg = c.white },
            TelescopePreviewBorder = { bg = "NONE", fg = c.white },

            LspFloatWinNormal = { bg = "NONE" },
            LspFloatWinBorder = { bg = "NONE" },

            DiagnosticFloatingError = { bg = "NONE" },
            DiagnosticFloatingWarn = { bg = "NONE" },
            DiagnosticFloatingInfo = { bg = "NONE" },
            DiagnosticFloatingHint = { bg = "NONE" },

            WhichKeyFloat = { bg = "NONE" },

            IndentBlanklineChar = { fg = c.gutter_fg },

            GitSignsAdd = { bg = "NONE" },
            GitSignsChange = { bg = "NONE" },
            GitSignsDelete = { bg = "NONE" },

            ["@lsp.type.variable"] = { bg = "NONE" },
            ["@lsp.type.parameter"] = { bg = "NONE" },
            ["@lsp.typemod.variable.definition"] = { bg = "NONE" },

            CursorLine = { bg = c.selection },
          }
        end,
      })

      vim.api.nvim_create_autocmd("ColorScheme", {
        pattern = "*",
        callback = function()
          local highlights = {
            "Normal",
            "NormalNC",
            "SignColumn",
            "NvimTreeNormal",
            "NeoTreeNormal",
            "TelescopeNormal",
            "TelescopePrompt",
            "TelescopeResults",
            "TelescopePreview",
          }

          for _, group in ipairs(highlights) do
            vim.cmd(string.format("hi %s guibg=NONE ctermbg=NONE", group))
          end
        end,
      })

      -- Uncomment the following line to enable the colorscheme
      -- vim.cmd("colorscheme dracula")
    end,
  },
}
