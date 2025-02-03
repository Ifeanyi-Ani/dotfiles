return {
  {
    "ThePrimeagen/refactoring.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    cmd = "Refactor",
    keys = {
      { "<leader>re", ":Refactor extract ", mode = "x", desc = "Extract function" },
      { "<leader>rf", ":Refactor extract_to_file ", mode = "x", desc = "Extract function to file" },
      { "<leader>rv", ":Refactor extract_var ", mode = "x", desc = "Extract variable" },
      { "<leader>ri", ":Refactor inline_var", mode = { "x", "n" }, desc = "Inline variable" },
      { "<leader>rI", ":Refactor inline_func", mode = "n", desc = "Inline function" },
      { "<leader>rb", ":Refactor extract_block", mode = "n", desc = "Extract block" },
      { "<leader>rf", ":Refactor extract_block_to_file", mode = "n", desc = "Extract block to file" },
    },
    config = function()
      require("refactoring").setup({
        printf_statements = {},
        extract_to_file = {
          default_path = function(file_path)
            return vim.fn.fnamemodify(file_path, ":h")
          end,
        },
        -- Configure the prompt behavior
        prompt_func_return_type = {
          javascript = true,
          typescript = true,
        },
        prompt_func_param_type = {
          javascript = true,
          typescript = true,
        },
      })
    end,
  },
  {
    "smjonas/inc-rename.nvim",
    cmd = "IncRename",
    keys = {
      {
        "<leader>rN",
        function()
          return ":IncRename " .. vim.fn.expand("<cword>")
        end,
        desc = "Incremental rename",
        mode = "n",
        noremap = true,
        expr = true,
      },
    },
    config = true,
  },
}
