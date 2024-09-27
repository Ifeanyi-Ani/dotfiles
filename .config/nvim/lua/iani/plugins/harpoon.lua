return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  config = function()
    -- set keymaps
    local keymap = vim.keymap -- for conciseness

    local harpoon = require("harpoon")

    -- REQUIRED
    harpoon:setup()
    -- REQUIRED

    keymap.set("n", "<leader>ha", function()
      harpoon:list():add()
    end, { desc = "mark file harpoon" })
    keymap.set("n", "<leader>hr", function()
      harpoon:list():remove()
    end, { desc = "remove mark file" })
    keymap.set("n", "<leader>hc", function()
      harpoon:list():clear()
    end, { desc = "clear all mark" })
    keymap.set("n", "<leader>he", function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end, { desc = "show mark files" })

    keymap.set("n", "<leader>1", function()
      harpoon:list():select(1)
    end)
    keymap.set("n", "<leader>2", function()
      harpoon:list():select(2)
    end)
    keymap.set("n", "<leader>3", function()
      harpoon:list():select(3)
    end)
    keymap.set("n", "<leader>4", function()
      harpoon:list():select(4)
    end)
  end,
}
