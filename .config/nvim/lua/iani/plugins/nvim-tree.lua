return {
  "nvim-tree/nvim-tree.lua",
  dependencies = "nvim-tree/nvim-web-devicons",
  config = function()
    local nvimtree = require("nvim-tree")

    -- recommended settings from nvim-tree documentation
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    nvimtree.setup({
      view = {
        width = 35,
        relativenumber = true,
      },
      -- change folder arrow icons
      renderer = {
        indent_markers = {
          enable = true,
        },
        icons = {
          glyphs = {
            default = "",
            symlink = "",
            git = {
              unstaged = "",
              staged = "",
              unmerged = "",
              renamed = "凜",
              untracked = "",
              deleted = "",
              ignored = "◌",
            },
            folder = {
              arrow_closed = "",
              arrow_open = "",
              default = "",
              open = "",
              empty = "",
              empty_open = "",
              symlink = "",
              symlink_open = "",
            },
          },
        },
      },
      diagnostics = {
        enable = true,
        show_on_dirs = true,
        icons = {
          hint = "",
          info = "",
          warning = "",
          error = "",
        },
      },
      actions = {
        open_file = {
          quit_on_open = true,
          window_picker = {
            enable = true,
          },
        },
      },

      filters = {
        dotfiles = true,
        custom = { ".cache", ".git", "node_modules", ".DS_Store", ".idea", ".vscode" },
        exclude = { ".env" },
      },
      git = {
        enable = true,
        ignore = false,
        timeout = 500,
      },
      filesystem_watchers = {
        enable = true,
        debounce_delay = 50,
      },
      update_focused_file = {
        enable = true,
        update_cwd = true,
      },
    })

    -- set keymaps
    local keymap = vim.keymap -- for conciseness

    keymap.set("n", "<leader>ee", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer" }) -- toggle file explorer
    keymap.set("n", "<leader>ef", "<cmd>NvimTreeFindFileToggle<CR>", { desc = "Toggle file explorer on current file" }) -- toggle file explorer on current file
    keymap.set("n", "<leader>ec", "<cmd>NvimTreeCollapse<CR>", { desc = "Collapse file explorer" }) -- collapse file explorer
    keymap.set("n", "<leader>er", "<cmd>NvimTreeRefresh<CR>", { desc = "Refresh file explorer" }) -- refresh file explorer
    keymap.set("n", "<leader>eR", "<cmd>NvimTreeResize +10<CR>", { desc = "Resize file explorer width" }) -- resize explorer
    keymap.set("n", "<leader>em", "<cmd>NvimTreeToggleHidden<CR>", { desc = "Toggle hidden files" }) -- toggle hidden files
    keymap.set("n", "<leader>en", "<cmd>NvimTreeFocus<CR>", { desc = "Focus on file explorer" }) -- focus file explorer
  end,
}
