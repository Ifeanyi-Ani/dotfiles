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
        map("n", "<leader>gs", gs.stage_hunk, "Stage Hunk")
        map("n", "<leader>gr", gs.reset_hunk, "Reset Hunk")
        map("v", "<leader>gs", function()
          gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end, "Stage Hunk (Visual)")
        map("v", "<leader>gr", function()
          gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end, "Reset Hunk (Visual)")
        map("n", "<leader>gS", gs.stage_buffer, "Stage Buffer")
        map("n", "<leader>gR", gs.reset_buffer, "Reset Buffer")
        map("n", "<leader>gu", gs.undo_stage_hunk, "Undo Stage Hunk")
        map("n", "<leader>gp", gs.preview_hunk, "Preview Hunk")
        map("n", "<leader>gb", function()
          gs.blame_line({ full = true })
        end, "Blame Line")
        map("n", "<leader>gB", gs.toggle_current_line_blame, "Toggle Line Blame")
        map("n", "<leader>gd", gs.diffthis, "Diff This")
        map("n", "<leader>gD", function()
          gs.diffthis("~")
        end, "Diff This ~")

        -- Text object
        map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "Select Hunk")
      end,
    },
  },
  {
    "tpope/vim-fugitive",
    config = function()
      -- Set a vim motion to <Space> + g + b to view the most recent contributors to the file
      vim.keymap.set("n", "<leader>gb", ":Git blame<cr>", { desc = "[G]it [B]lame" })
      -- Set a vim motion to <Space> + g + <Shift>A to add all files to the staging area
      vim.keymap.set("n", "<leader>gA", ":Git add .<cr>", { desc = "[G]it Add [A]ll" })
      -- Set a vim motion to <Space> + g + a to add the current file and changes to the staging area
      vim.keymap.set("n", "<leader>ga", ":Git add %<cr>", { desc = "[G]it [A]dd Current" })
      -- Set a vim motion to <Space> + g + c to commit the current changes
      vim.keymap.set("n", "<leader>gc", ":Git commit<cr>", { desc = "[G]it [C]ommit" })
      -- Set a vim motion to <Space> + g + p to push the committed changes to the remote repository
      vim.keymap.set("n", "<leader>gp", ":Git push<cr>", { desc = "[G]it [P]ush" })
      -- Set a vim motion to <Space> + g + s to show the Git status
      vim.keymap.set("n", "<leader>gs", ":Git status<cr>", { desc = "[G]it [S]tatus" })
    end,
  },
}
