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
  },
  opts = {
    workspaces = {
      {
        name = "personal",
        path = "~/Documents/notes",
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
    },
    note_id_func = function(title)
      local suffix = ""
      if title ~= nil then
        suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
      else
        for _ = 1, 4 do
          suffix = suffix .. string.char(math.random(65, 90))
        end
      end
      return tostring(os.time()) .. "-" .. suffix
    end,
    -- ... (rest of the configuration remains the same)
  },
  config = function(_, opts)
    require("obsidian").setup(opts)

    -- Key mappings
    vim.keymap.set("n", "gf", function()
      if require("obsidian").util.cursor_on_markdown_link() then
        return "<cmd>ObsidianFollowLink<CR>"
      else
        return "gf"
      end
    end, { noremap = false, expr = true })

    vim.keymap.set("n", "<leader>on", "<cmd>ObsidianNew<CR>")
    vim.keymap.set("n", "<leader>oo", "<cmd>ObsidianOpen<CR>")
    vim.keymap.set("n", "<leader>os", "<cmd>ObsidianSearch<CR>")
    vim.keymap.set("n", "<leader>ob", "<cmd>ObsidianBacklinks<CR>")
    vim.keymap.set("n", "<leader>ot", "<cmd>ObsidianTemplate<CR>")

    -- New key mappings for quick template insertion
    vim.keymap.set("n", "<leader>odt", function()
      vim.cmd("ObsidianTemplate daily_task_template.md")
    end, { desc = "Insert Daily Task Template" })

    vim.keymap.set("n", "<leader>olt", function()
      vim.cmd("ObsidianTemplate learning_journey_template.md")
    end, { desc = "Insert Learning Journey Template" })
  end,
}
