return {
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, desc)
          vim.keymap.set(mode, l, r, { buffer = bufnr, desc = desc })
        end

        -- Navigation
        map("n", "]h", gs.next_hunk, "Next Hunk")
        map("n", "[h", gs.prev_hunk, "Prev Hunk")

        -- Actions
        map("n", "<leader>ghs", gs.stage_hunk, "Stage hunk")
        map("n", "<leader>ghr", gs.reset_hunk, "Reset hunk")
        map("v", "<leader>ghs", function()
          gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end, "Stage hunk")
        map("v", "<leader>ghr", function()
          gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end, "Reset hunk")

        map("n", "<leader>ghS", gs.stage_buffer, "Stage buffer")
        map("n", "<leader>ghR", gs.reset_buffer, "Reset buffer")

        map("n", "<leader>ghu", gs.undo_stage_hunk, "Undo stage hunk")

        map("n", "<leader>ghp", gs.preview_hunk, "Preview hunk")

        map("n", "<leader>ghb", function()
          gs.blame_line({ full = true })
        end, "Blame line")
        map("n", "<leader>ghB", gs.toggle_current_line_blame, "Toggle line blame")

        map("n", "<leader>ghd", gs.diffthis, "Diff this")
        map("n", "<leader>ghD", function()
          gs.diffthis("~")
        end, "Diff this ~")

        -- Text object
        map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "Gitsigns select hunk")
      end,
    },
  },
  {
    "tpope/vim-fugitive",
    config = function()
      -- Set a vim motion to <Space> + g + b to view the most recent contributers to the file
      vim.keymap.set("n", "<leader>gb", ":Git blame<cr>", { desc = "[G]it [B]lame" })
      -- Set a vim motion to <Space> + g + <Shift>A to all files changed to the staging area
      vim.keymap.set("n", "<leader>gA", ":Git add .<cr>", { desc = "[G]it Add [A]ll" })
      -- Set a vim motion to <Space> + g + a to add the current file and changes to the staging area
      vim.keymap.set("n", "<leader>ga", "Git add", { desc = "[G]it [A]dd" })
      -- Set a vim motion to <Space> + g + c to commit the current chages
      vim.keymap.set("n", "<leader>gc", ":Git commit", { desc = "[G]it [C]ommit" })
      -- Set a vim motion to <Space> + g + p to push the commited changes to the remote repository
      vim.keymap.set("n", "<leader>gp", "Git push", { desc = "[G]it [P]ush" })
    end,
  },
}
