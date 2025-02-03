return {
  'stevearc/oil.nvim',
  config = function(_, opts)
    require("oil").setup(opts)
    vim.keymap.set("n", "<leader>ee", require("oil").toggle_float, { desc = "Toggle oil file explorer" })
    vim.keymap.set("n", "<leader>ef", function()
      require("oil").toggle_float(vim.fn.expand("%:p:h"))
    end, { desc = "Toggle oil file explorer on current file" })
    vim.keymap.set("n", "<leader>ec", require("oil").close, { desc = "Close oil file explorer" })
  end,
}


