return {
  "nvim-lua/plenary.nvim", -- lua functions that many plugins use
  "christoomey/vim-tmux-navigator", -- tmux & split window navigation
  {
    "mistricky/codesnap.nvim",
    build = "make",
    cmd = "CodeSnapPreviewOn",
    opts = {
      watermark = nil,
    },
  },
  {
    "LudoPinelli/comment-box.nvim",
    lazy = false,
    keys = {
      { "<leader>cb", "<cmd>lua require('comment-box').llbox()<CR>", desc = "comment box" },
      { "<leader>cb", "<cmd>lua require('comment-box').llbox()<CR>", mode = "v", desc = "comment box" },
    },
  },
}
