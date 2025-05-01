return {
  "nvim-lua/plenary.nvim",
  "christoomey/vim-tmux-navigator",
  {
    "mistricky/codesnap.nvim",
    build = "make build_generator",
    keys = {
      { "<leader>cc", "<cmd>CodeSnap<cr>", mode = "x", desc = "Save selected code snapshot into clipboard" },
      { "<leader>cs", "<cmd>CodeSnapSave<cr>", mode = "x", desc = "Save selected code snapshot in ~/Pictures" },
    },
    opts = {
      save_path = "~/Pictures/",
      has_breadcrumbs = true,
      bg_theme = "bamboo",
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
