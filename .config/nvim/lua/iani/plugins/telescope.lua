return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = vim.fn.executable("make") ~= 0 and "make"
        or "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
      enabled = vim.fn.executable("make") ~= 0 or vim.fn.executable("cmake") ~= 0,
    },
    "nvim-tree/nvim-web-devicons",
    "folke/todo-comments.nvim",
    "nvim-telescope/telescope-ui-select.nvim",
    "nvim-telescope/telescope-live-grep-args.nvim",
    { "nvim-telescope/telescope-fzy-native.nvim", build = "make" },
    "gbrlsnchs/telescope-lsp-handlers.nvim",
  },
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")
    local lga_actions = require("telescope-live-grep-args.actions")

    -- Function to check if trouble plugin exists and use it
    local open_with_trouble = function(...)
      if pcall(require, "trouble.sources.telescope") then
        return require("trouble.sources.telescope").open(...)
      else
        vim.notify("Trouble plugin not found", vim.log.levels.WARN)
        return false
      end
    end

    local find_files_no_ignore = function()
      local action_state = require("telescope.actions.state")
      local line = action_state.get_current_line()
      require("telescope.builtin").find_files({ no_ignore = true, default_text = line })
    end

    local find_files_with_hidden = function()
      local action_state = require("telescope.actions.state")
      local line = action_state.get_current_line()
      require("telescope.builtin").find_files({ hidden = true, default_text = line })
    end

    local function find_command()
      if 1 == vim.fn.executable("rg") then
        return { "rg", "--files", "--color", "never", "-g", "!.git" }
      elseif 1 == vim.fn.executable("fd") then
        return { "fd", "--type", "f", "--color", "never", "-E", ".git" }
      elseif 1 == vim.fn.executable("fdfind") then
        return { "fdfind", "--type", "f", "--color", "never", "-E", ".git" }
      elseif 1 == vim.fn.executable("find") and vim.fn.has("win32") == 0 then
        return { "find", ".", "-type", "f" }
      elseif 1 == vim.fn.executable("where") then
        return { "where", "/r", ".", "*" }
      end
    end

    telescope.setup({
      defaults = {
        prompt_prefix = " ",
        selection_caret = " ",
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
        -- open files in the first window that is an actual file.
        -- use the current window if no other window is available.
        get_selection_window = function()
          local wins = vim.api.nvim_list_wins()
          table.insert(wins, 1, vim.api.nvim_get_current_win())
          for _, win in ipairs(wins) do
            local buf = vim.api.nvim_win_get_buf(win)
            if vim.bo[buf].buftype == "" then
              return win
            end
          end
          return 0
        end,
        mappings = {
          i = {
            ["<c-t>"] = open_with_trouble,
            ["<a-t>"] = open_with_trouble,
            ["<a-i>"] = find_files_no_ignore,
            ["<a-h>"] = find_files_with_hidden,
            ["<C-Down>"] = actions.cycle_history_next,
            ["<C-Up>"] = actions.cycle_history_prev,
            ["<C-f>"] = actions.preview_scrolling_down,
            ["<C-b>"] = actions.preview_scrolling_up,
          },
          n = {
            ["q"] = actions.close,
          },
        },
      },
      pickers = {
        find_files = {
          hidden = true,
          find_command = find_command,
        },
        buffers = {
          previewer = true,
          layout_config = {
            width = 80,
          },
          sort_mru = true,
          sort_lastused = true,
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

    -- Load extensions
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

    -- Setup keybindings - merged and deduped from both configs
    local keymap = vim.keymap

    -- Basic finder mappings
    keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Find Files (Root Dir)" })
    keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Recent Files" })
    keymap.set("n", "<leader>fF", function()
      require("telescope.builtin").find_files({ cwd = vim.fn.getcwd() })
    end, { desc = "Find Files (cwd)" })
    keymap.set("n", "<leader>fg", "<cmd>Telescope git_files<cr>", { desc = "Find Files (git-files)" })
    keymap.set("n", "<leader>fR", function()
      require("telescope.builtin").oldfiles({ cwd = vim.uv.cwd() })
    end, { desc = "Recent (cwd)" })

    -- Buffer management
    keymap.set(
      "n",
      "<leader>fb",
      "<cmd>Telescope buffers sort_mru=true sort_lastused=true ignore_current_buffer=true<cr>",
      { desc = "Buffers" }
    )
    keymap.set(
      "n",
      "<leader>,",
      "<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>",
      { desc = "Switch Buffer" }
    )

    -- Search functionality
    keymap.set("n", "<leader>/", "<cmd>Telescope current_buffer_fuzzy_find<cr>", { desc = "Find in buffer" })
    keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep_args<cr>", { desc = "Find string in cwd" })
    keymap.set("n", "<leader>sg", function()
      require("telescope.builtin").live_grep()
    end, { desc = "Grep (Root Dir)" })
    keymap.set("n", "<leader>sG", function()
      require("telescope.builtin").live_grep({ cwd = vim.fn.getcwd() })
    end, { desc = "Grep (cwd)" })

    -- Find commands and help
    keymap.set("n", "<leader>fc", "<cmd>Telescope commands<cr>", { desc = "Find commands" })
    keymap.set("n", "<leader>:", "<cmd>Telescope command_history<cr>", { desc = "Command History" })
    keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { desc = "Find help" })

    -- Find specialized content
    keymap.set("n", "<leader>ft", "<cmd>Telescope todo-comments<cr>", { desc = "Find todos" })
    keymap.set("n", "<leader>fd", "<cmd>Telescope diagnostics<cr>", { desc = "Find diagnostics" })
    keymap.set("n", "<leader>fm", "<cmd>Telescope marks<cr>", { desc = "Find marks" })
    keymap.set("n", "<leader>fn", "<cmd>Telescope treesitter<cr>", { desc = "Find variable" })

    -- Find packages
    keymap.set("n", "<leader>fP", function()
      require("telescope.builtin").find_files({
        cwd = vim.fs.joinpath(vim.fn.stdpath("data"), "lazy"),
      })
    end, { desc = "Find Package" })

    -- "s" prefix keybindings (search variants)
    keymap.set("n", '<leader>s"', "<cmd>Telescope registers<cr>", { desc = "Registers" })
    keymap.set("n", "<leader>sa", "<cmd>Telescope autocommands<cr>", { desc = "Auto Commands" })
    keymap.set("n", "<leader>sb", "<cmd>Telescope current_buffer_fuzzy_find<cr>", { desc = "Buffer" })
    keymap.set("n", "<leader>sc", "<cmd>Telescope command_history<cr>", { desc = "Command History" })
    keymap.set("n", "<leader>sC", "<cmd>Telescope commands<cr>", { desc = "Commands" })
    keymap.set("n", "<leader>sd", "<cmd>Telescope diagnostics bufnr=0<cr>", { desc = "Document Diagnostics" })
    keymap.set("n", "<leader>sD", "<cmd>Telescope diagnostics<cr>", { desc = "Workspace Diagnostics" })
    keymap.set("n", "<leader>sh", "<cmd>Telescope help_tags<cr>", { desc = "Help Pages" })
    keymap.set("n", "<leader>sH", "<cmd>Telescope highlights<cr>", { desc = "Search Highlight Groups" })
    keymap.set("n", "<leader>sj", "<cmd>Telescope jumplist<cr>", { desc = "Jumplist" })
    keymap.set("n", "<leader>sk", "<cmd>Telescope keymaps<cr>", { desc = "Key Maps" })
    keymap.set("n", "<leader>sl", "<cmd>Telescope loclist<cr>", { desc = "Location List" })
    keymap.set("n", "<leader>sM", "<cmd>Telescope man_pages<cr>", { desc = "Man Pages" })
    keymap.set("n", "<leader>sm", "<cmd>Telescope marks<cr>", { desc = "Jump to Mark" })
    keymap.set("n", "<leader>so", "<cmd>Telescope vim_options<cr>", { desc = "Options" })
    keymap.set("n", "<leader>sR", "<cmd>Telescope resume<cr>", { desc = "Resume" })
    keymap.set("n", "<leader>sq", "<cmd>Telescope quickfix<cr>", { desc = "Quickfix List" })
    keymap.set("n", "<leader>sw", function()
      require("telescope.builtin").grep_string({ word_match = "-w" })
    end, { desc = "Word (Root Dir)" })
    keymap.set("n", "<leader>sW", function()
      require("telescope.builtin").grep_string({ cwd = vim.fn.getcwd(), word_match = "-w" })
    end, { desc = "Word (cwd)" })

    -- Visual mode grep
    keymap.set("v", "<leader>sw", function()
      require("telescope.builtin").grep_string()
    end, { desc = "Selection (Root Dir)" })
    keymap.set("v", "<leader>sW", function()
      require("telescope.builtin").grep_string({ cwd = vim.fn.getcwd() })
    end, { desc = "Selection (cwd)" })

    -- Symbol searching
    keymap.set("n", "<leader>ss", function()
      require("telescope.builtin").lsp_document_symbols()
    end, { desc = "Goto Symbol" })

    keymap.set("n", "<leader>sS", function()
      require("telescope.builtin").lsp_dynamic_workspace_symbols()
    end, { desc = "Goto Symbol (Workspace)" })

    -- Git integration
    keymap.set("n", "<leader>gc", "<cmd>Telescope git_commits<CR>", { desc = "Git Commits" })
    keymap.set("n", "<leader>gs", "<cmd>Telescope git_status<CR>", { desc = "Git Status" })

    -- Colorscheme with preview
    keymap.set("n", "<leader>uC", function()
      require("telescope.builtin").colorscheme({ enable_preview = true })
    end, { desc = "Colorscheme with Preview" })
  end,
}
