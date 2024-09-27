return {
  -- "Mofiqul/dracula.nvim",
  -- config = function()
  --   require("dracula").setup({
  --     colors = {
  --       bg = "#282A36",
  --       fg = "#F8F8F2",
  --       selection = "#44475A",
  --       comment = "#6272A4",
  --       red = "#FF5555",
  --       orange = "#FFB86C",
  --       yellow = "#F1FA8C",
  --       green = "#50fa7b",
  --       purple = "#BD93F9",
  --       cyan = "#8BE9FD",
  --       pink = "#FF79C6",
  --       bright_red = "#FF6E6E",
  --       bright_green = "#69FF94",
  --       bright_yellow = "#FFFFA5",
  --       bright_blue = "#D6ACFF",
  --       bright_magenta = "#FF92DF",
  --       bright_cyan = "#A4FFFF",
  --       bright_white = "#FFFFFF",
  --       menu = "#21222C",
  --       visual = "#3E4452",
  --       gutter_fg = "#4B5263",
  --       nontext = "#3B4048",
  --       white = "#ABB2BF",
  --       black = "#191A21",
  --     },
  --     -- show the '~' characters after the end of buffers
  --     show_end_of_buffer = true, -- default false
  --     -- use transparent background
  --     transparent_bg = false, -- default false
  --     -- set custom lualine background color
  --     lualine_bg_color = "#44475a", -- default nil
  --     -- set italic comment
  --     italic_comment = true, -- default false
  --     -- overrides the default highlights with table see `:h synIDattr`
  --     overrides = {},
  --     -- You can use overrides as table like this
  --     -- overrides = {
  --     --   NonText = { fg = "white" }, -- set NonText fg to white
  --     --   NvimTreeIndentMarker = { link = "NonText" }, -- link to NonText highlight
  --     --   Nothing = {} -- clear highlight of Nothing
  --     -- },
  --     -- Or you can also use it like a function to get color from theme
  --     -- overrides = function (colors)
  --     --   return {
  --     --     NonText = { fg = colors.white }, -- set NonText fg to white of theme
  --     --   }
  --   })
  --   vim.cmd("colorscheme dracula")
  -- end,
  "folke/tokyonight.nvim",
  priority = 1000,
  config = function()
    local transparent = false -- set to true if you would like to enable transparency

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
    })

    vim.cmd("colorscheme tokyonight")
  end,
}
