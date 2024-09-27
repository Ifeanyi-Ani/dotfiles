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
    })
    wk.add({
      { "<leader>f", group = "Fuzzy Find" },
      { "<leader>t", group = "Buffer/Tabs" },
      { "<leader>x", group = "Trouble" },
      { "<leader>w", group = "session" },
      { "<leader>s", group = "window/word" },
      { "<leader>r", group = "Refactor" },
      { "<leader>n", group = "Clear" },
      { "<leader>m", group = "Format" },
      { "<leader>e", group = "Explorer" },
      { "<leader>b", group = "Debug" },
      { "<leader>g", group = "Git" },
      { "<leader>gh", group = "Git Hunk" },
      { "<leader>c", group = "Actions" },
    })
  end,
}
