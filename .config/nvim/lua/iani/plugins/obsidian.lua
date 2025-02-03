return {
  "epwalsh/obsidian.nvim",
  version = "*",
  lazy = true,
  ft = "markdown",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "hrsh7th/nvim-cmp",
    "nvim-telescope/telescope.nvim",
    "nvim-treesitter/nvim-treesitter",
    "preservim/vim-markdown",
    "godlygeek/tabular",
    "iamcco/markdown-preview.nvim",
  },
  opts = {
    workspaces = {
      {
        name = "personal",
        path = "~/dev/emmy-notes/",
      },
    },
    daily_notes = {
      folder = "dailies",
      date_format = "%Y-%m-%d",
      template = "daily_task_template.md",
    },
    templates = {
      subdir = "templates",
      date_format = "%Y-%m-%d",
      time_format = "%H:%M",

      substitutions = {
        yesterday = function()
          return os.date("%Y-%m-%d", os.time() - 86400)
        end,
        tomorrow = function()
          return os.date("%Y-%m-%d", os.time() + 86400)
        end,
      },
    },
    note_id_func = function(title)
      if title ~= nil then
        return title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
      else
        return tostring(os.date("%Y%m%d%H%M%S"))
      end
    end,
    disable_frontmatter = false,
    note_frontmatter_func = function(note)
      local out = { id = note.id, aliases = note.aliases, tags = note.tags }
      if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
        for k, v in pairs(note.metadata) do
          out[k] = v
        end
      end
      return out
    end,
    follow_url_func = function(url)
      vim.fn.jobstart({ "xdg-open", url }) -- Use 'open' for macOS, "xdg-open" for linux, or 'start' for Windows
    end,
    use_advanced_uri = true,
    open_app_foreground = false,
    finder = "telescope.nvim",
    sort_by = "modified",
    sort_reversed = true,
    open_notes_in = "current",
    completion = {
      nvim_cmp = true,
      min_chars = 2,
    },
    new_notes_location = "current_dir",
    wiki_link_func = function(opts)
      if opts.id == nil then
        return string.format("[[%s]]", opts.label)
      elseif opts.label ~= opts.id then
        return string.format("[[%s|%s]]", opts.id, opts.label)
      else
        return string.format("[[%s]]", opts.id)
      end
    end,
    markdown_link_func = function(opts)
      return string.format("[%s](%s)", opts.label, opts.path)
    end,
  },

  config = function(_, opts)
    require("obsidian").setup(opts)

    -- Key mappings
    local function map(mode, lhs, rhs, desc)
      vim.keymap.set(mode, lhs, rhs, { noremap = true, silent = true, desc = desc })
    end

    map("n", "gf", function()
      if require("obsidian").util.cursor_on_markdown_link() then
        return "<cmd>ObsidianFollowLink<CR>"
      else
        return "gf"
      end
    end, "Follow Obsidian link or default gf")

    map("n", "<leader>on", "<cmd>ObsidianNew<CR>", "New Obsidian note")
    map("n", "<leader>oo", "<cmd>ObsidianOpen<CR>", "Open Obsidian")
    map("n", "<leader>os", "<cmd>ObsidianSearch<CR>", "Search Obsidian notes")
    map("n", "<leader>ob", "<cmd>ObsidianBacklinks<CR>", "Show backlinks")
    map("n", "<leader>ot", "<cmd>ObsidianTemplate<CR>", "Insert template")
    map("n", "<leader>od", "<cmd>ObsidianToday<CR>", "Open today's daily note")
    map("n", "<leader>oy", "<cmd>ObsidianYesterday<CR>", "Open yesterday's daily note")
    map("n", "<leader>om", "<cmd>ObsidianTomorrow<CR>", "Open tomorrow's daily note")
    map("n", "<leader>ol", "<cmd>ObsidianLink<CR>", "Create or edit link")
    map("n", "<leader>oT", "<cmd>ObsidianTags<CR>", "Search tags")
    map("n", "<leader>oc", "<cmd>ObsidianCheck<CR>", "Check health")

    -- Template insertion mappings
    map("n", "<leader>odt", function()
      vim.cmd("ObsidianTemplate daily_task_template.md")
    end, "Insert Daily Task Template")

    map("n", "<leader>olt", function()
      vim.cmd("ObsidianTemplate learning_journey_template.md")
    end, "Insert Learning Journey Template")

    -- Custom functions
    vim.api.nvim_create_user_command("ObsidianYesterday", function()
      vim.cmd("ObsidianDailyNote " .. os.date("%Y-%m-%d", os.time() - 86400))
    end, {})

    vim.api.nvim_create_user_command("ObsidianTomorrow", function()
      vim.cmd("ObsidianDailyNote " .. os.date("%Y-%m-%d", os.time() + 86400))
    end, {})

    -- Autocommands
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "markdown",
      callback = function()
        -- Enable spell checking
        vim.opt_local.spell = true
        vim.opt_local.spelllang = "en_us"

        -- Enable text wrapping
        vim.opt_local.wrap = true
        vim.opt_local.linebreak = true

        -- Set indentation
        vim.opt_local.tabstop = 2
        vim.opt_local.shiftwidth = 2
        vim.opt_local.expandtab = true

        -- Enable concealment for markup
        vim.opt_local.conceallevel = 2
      end,
    })

    -- Additional plugin configurations
    vim.g.vim_markdown_folding_disabled = 1
    vim.g.vim_markdown_frontmatter = 1
    vim.g.vim_markdown_strikethrough = 1
    vim.g.vim_markdown_new_list_item_indent = 2
    vim.g.vim_markdown_auto_insert_bullets = 1
    vim.g.vim_markdown_toc_autofit = 1

    -- Setup nvim-cmp for Obsidian completion
    local cmp = require("cmp")
    cmp.setup.filetype("markdown", {
      sources = cmp.config.sources({
        { name = "obsidian" },
        { name = "buffer" },
        { name = "path" },
      }),
    })
  end,
}
