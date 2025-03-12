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
          dart = true, -- Add Dart support
        },
        prompt_func_param_type = {
          javascript = true,
          typescript = true,
          dart = true, -- Add Dart support
        },
        -- Add Dart-specific refactoring options
        print_var_statements = {
          dart = {
            'print("${} = ${}");',
          },
        },
      })

      -- Add Dart-specific keymaps
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "dart",
        callback = function()
          vim.keymap.set(
            "v",
            "<leader>rem",
            [[:Refactor extract_method<CR>]],
            { noremap = true, silent = true, buffer = true, desc = "Extract method" }
          )
          vim.keymap.set(
            "v",
            "<leader>rec",
            [[:Refactor extract_class<CR>]],
            { noremap = true, silent = true, buffer = true, desc = "Extract class" }
          )
        end,
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
    config = function()
      require("inc_rename").setup({
        cmd_name = "IncRename", -- the name of the command
        hl_group = "Substitute", -- the highlight group used for highlighting the identifier's new name
        preview_empty_name = false, -- whether an empty new name should be previewed; if false the command preview will be cancelled instead
        show_message = true, -- whether to display a `Renamed m instances in n files` message after a rename operation
        input_buffer_type = "dressing", -- the type of the external input buffer to use (the only supported value is currently "dressing")
        post_hook = nil, -- callback to run after renaming, receives the result table (from LSP rename) as an argument
      })

      -- Add Dart-specific rename functionality
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "dart",
        callback = function()
          vim.keymap.set("n", "<leader>rw", function()
            local word = vim.fn.expand("<cword>")
            local pascal_case = word:gsub("^%l", string.upper)
            return ":IncRename " .. pascal_case
          end, { noremap = true, expr = true, buffer = true, desc = "Rename to PascalCase" })
        end,
      })
    end,
  },
}
