return {
  "windwp/nvim-ts-autotag",
  config = function()
    require("nvim-ts-autotag").setup({
      -- Global options
      opts = {
        -- Enable auto-closing of HTML/XML tags
        enable_close = true,
        -- Enable auto-renaming of HTML/XML tags
        enable_rename = true,
        -- Disable auto-closing on trailing slash (e.g., <br/>)
        enable_close_on_slash = false,
        -- Enable auto-closing on HTML/XML tags that don't have a matching close tag
        enable_self_closing_tags = true,
      },

      -- Per-filetype configuration overrides
      per_filetype = {
        -- Disable auto-closing for HTML files
        html = {
          enable_close = false,
        },
        -- Enable auto-closing for Markdown files
        markdown = {
          enable_close = true,
        },
        -- Enable auto-renaming for JSX/TSX files
        ["javascript.jsx"] = {
          enable_rename = true,
        },
        ["typescript.tsx"] = {
          enable_rename = true,
        },
      },
    })
  end,
}
