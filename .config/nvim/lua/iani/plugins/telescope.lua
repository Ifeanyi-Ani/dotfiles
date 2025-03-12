return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "nvim-tree/nvim-web-devicons",
    "folke/todo-comments.nvim",
    "nvim-telescope/telescope-ui-select.nvim",
    "nvim-telescope/telescope-live-grep-args.nvim",
    { "nvim-telescope/telescope-fzy-native.nvim", build = "make" },
    -- Add dart-specific telescope extension
    "gbrlsnchs/telescope-lsp-handlers.nvim",
  },
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")
    local lga_actions = require("telescope-live-grep-args.actions")

    telescope.setup({
      defaults = {
        path_display = { "truncate" },
        sorting_strategy = "ascending",
        layout_config = {
          horizontal = {
            prompt_position = "top",
            preview_width = 0.55,
          },
          vertical = {
            mirror = false,
          },
          width = 0.87,
          height = 0.80,
          preview_cutoff = 120,
        },
        file_ignore_patterns = { "node_modules", ".dart_tool", ".pub-cache", "build" },
      },
      pickers = {
        find_files = {
          hidden = true,
        },
        buffers = {
          previewer = true,
          layout_config = {
            width = 80,
          },
        },
        oldfiles = {
          prompt_title = "Recent Files",
        },
        lsp_references = {
          previewer = true,
        },
      },
      extensions = {
        fzf = {
          fuzzy = true,
          override_generic_sorter = true,
          override_file_sorter = true,
          case_mode = "smart_case",
        },
        ["ui-select"] = {
          require("telescope.themes").get_dropdown({}),
        },
        live_grep_args = {
          auto_quoting = true,
          mappings = {
            i = {
              ["<C-a>"] = lga_actions.quote_prompt(),
              ["<C-i>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
            },
          },
        },
        lsp_handlers = {
          code_action = {
            telescope = require("telescope.themes").get_dropdown({}),
          },
        },
      },
    })

    telescope.load_extension("fzf")
    telescope.load_extension("ui-select")
    telescope.load_extension("live_grep_args")
    telescope.load_extension("lsp_handlers")

    -- Create Flutter-specific pickers
    local function find_flutter_widgets()
      require("telescope.builtin").live_grep({
        prompt_title = "Find Widgets",
        search_dirs = { "lib" },
        word_match = "-w",
        search = "class .* extends StatelessWidget|class .* extends StatefulWidget",
      })
    end

    local function find_flutter_providers()
      require("telescope.builtin").live_grep({
        prompt_title = "Find Providers",
        search_dirs = { "lib" },
        word_match = "-w",
        search = "class .* extends ChangeNotifier|class .* extends Notifier|class .* extends StateNotifier",
      })
    end

    local function find_flutter_screens()
      require("telescope.builtin").live_grep({
        prompt_title = "Find Screens",
        search_dirs = { "lib" },
        word_match = "-w",
        search = "class .* extends StatelessWidget|class .* extends StatefulWidget",
        additional_args = function()
          return { "-g", "*_screen.dart" }
        end,
      })
    end

    -- Register keymaps for Flutter finders
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "dart",
      callback = function()
        local opts = { buffer = true }
        vim.keymap.set(
          "n",
          "<leader>fW",
          find_flutter_widgets,
          vim.tbl_extend("force", opts, { desc = "Find Flutter Widgets" })
        )
        vim.keymap.set(
          "n",
          "<leader>fp",
          find_flutter_providers,
          vim.tbl_extend("force", opts, { desc = "Find Flutter Providers" })
        )
        vim.keymap.set(
          "n",
          "<leader>fS",
          find_flutter_screens,
          vim.tbl_extend("force", opts, { desc = "Find Flutter Screens" })
        )
      end,
    })

    local keymap = vim.keymap
    keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Fuzzy find files in cwd" })
    keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Fuzzy find recent files" })
    keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep_args<cr>", { desc = "Find string in cwd" })
    keymap.set("n", "<leader>fc", "<cmd>Telescope commands<cr>", { desc = "Find commands" })
    keymap.set("n", "<leader>ft", "<cmd>Telescope todo-comments<cr>", { desc = "Find todos" })
    keymap.set("n", "<leader>fd", "<cmd>Telescope diagnostics<cr>", { desc = "Find diagnostics" })
    keymap.set("n", "<leader>fn", "<cmd>Telescope treesitter<cr>", { desc = "Find variable" })
    keymap.set("n", "<leader>/", "<cmd>Telescope current_buffer_fuzzy_find<cr>", { desc = "Find in buffer" })
    keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { desc = "Find help" })
    keymap.set("n", "<leader>fm", "<cmd>Telescope marks<cr>", { desc = "Find marks" })
    keymap.set("n", "<leader>fb", function()
      require("telescope.builtin").buffers()
    end, { desc = "Fuzzy find buffers" })
    keymap.set("n", "<leader>fP", function()
      require("telescope.builtin").find_files({
        cwd = vim.fs.joinpath(vim.fn.stdpath("data"), "lazy"),
      })
    end, { desc = "Find Package" })
  end,
}
