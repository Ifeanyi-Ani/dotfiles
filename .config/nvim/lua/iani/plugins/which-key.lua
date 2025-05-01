return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  config = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 500
    local wk = require("which-key")
    wk.setup({
      win = {
        border = "rounded",
      },
      preset = "helix",
    })
    wk.add({
      { "<leader>f", group = "Fuzzy Find" },
      { "<leader>t", group = "Buffer/Tabs" },
      { "<leader>x", group = "Trouble" },
      { "<leader>w", group = "Session" },
      { "<leader>s", group = "Window/Word" },
      { "<leader>r", group = "Refactor" },
      { "<leader>n", group = "Next/Clear" },
      { "<leader>p", group = "Previous" },
      { "<leader>m", group = "Format" },
      { "<leader>e", group = "Explorer" },
      { "<leader>b", group = "Debug" },
      { "<leader>g", group = "Git" },
      { "<leader>gh", group = "Git Hunk" },
      { "<leader>c", group = "Actions" },
      { "<leader>o", group = "Obsidian" },
      { "<leader>h", group = "Harpoon" },
      { "<leader>u", group = "Flutter" },
    })
  end,
}
