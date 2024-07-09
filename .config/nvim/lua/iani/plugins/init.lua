return {
	"nvim-lua/plenary.nvim", -- lua functions that many plugins use

	"christoomey/vim-tmux-navigator", -- tmux & split window navigation

	"inkarkat/vim-ReplaceWithRegister", -- replace with register contents using motion (gr + motion)

	"tpope/vim-fugitive",

	"ThePrimeagen/git-worktree.nvim",
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
