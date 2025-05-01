return {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-emoji",
    "hrsh7th/cmp-nvim-lua",
    "hrsh7th/cmp-calc",
    {
      "L3MON4D3/LuaSnip",
      version = "v2.*",
      build = "make install_jsregexp",
    },
    "saadparwaiz1/cmp_luasnip",
    "rafamadriz/friendly-snippets",
    "onsails/lspkind.nvim",
    "windwp/nvim-autopairs",
    -- Add Flutter snippets
    "Nash0x7E2/awesome-flutter-snippets",
    -- Add Copilot CMP integration
    {
      "zbirenbaum/copilot-cmp",
      dependencies = { "zbirenbaum/copilot.lua" },
      opts = {},
      config = function(_, opts)
        local copilot_cmp = require("copilot_cmp")
        copilot_cmp.setup(opts)

        vim.api.nvim_create_autocmd("LspAttach", {
          callback = function(args)
            local buffer = args.buf
            local client = vim.lsp.get_client_by_id(args.data.client_id)
            if client and client.name == "copilot" then
              copilot_cmp._on_insert_enter({})
            end
          end,
        })
      end,
    },
  },
  config = function()
    local cmp = require("cmp")
    local luasnip = require("luasnip")
    local lspkind = require("lspkind")
    local cmp_autopairs = require("nvim-autopairs.completion.cmp")
    require("luasnip.loaders.from_vscode").lazy_load()
    local function accept_ai_suggestion()
      -- Check if there's a visible ghost text
      local ghost_text = require("cmp.config.context").context.cursor_before_line
        .. (cmp.core.view:get_current_ghost_text() or "")
      if ghost_text and ghost_text ~= "" then
        -- Accept the ghost text by sending keystrokes that would complete the line
        local keys = vim.api.nvim_replace_termcodes("<End>", true, false, true)
        vim.api.nvim_feedkeys(keys, "n", true)
        return true
      end
      return false
    end
    cmp.setup({
      completion = {
        completeopt = "menu,menuone,preview,noselect",
      },
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      },
      mapping = cmp.mapping.preset.insert({
        ["<C-k>"] = cmp.mapping.select_prev_item(),
        ["<C-j>"] = cmp.mapping.select_next_item(),
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<CR>"] = cmp.mapping.confirm({ select = false }),
        ["<Tab>"] = cmp.mapping(function(fallback)
          -- First try to accept AI suggestion
          if vim.g.ai_cmp and accept_ai_suggestion() then
            -- If the AI suggestion was accepted, we're done
            return
          -- Then check if completion menu is visible
          elseif cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
      }),

      sources = cmp.config.sources({
        { name = "copilot", priority = 1200 },
        { name = "nvim_lsp", priority = 1000 },
        { name = "luasnip", priority = 750 },
        { name = "buffer", priority = 500 },
        { name = "path", priority = 250 },
        { name = "nvim_lua", priority = 200 },
        { name = "calc", priority = 150 },
        { name = "emoji", priority = 100 },
      }),
      formatting = {
        fields = { "kind", "abbr", "menu" },
        expandable_indicator = true,
        format = lspkind.cmp_format({
          mode = "symbol_text",
          maxwidth = 50,
          ellipsis_char = "...",
          before = function(entry, vim_item)
            vim_item.menu = ({
              nvim_lsp = "[LSP]",
              copilot = "[Copilot]",
              luasnip = "[Snippet]",
              buffer = "[Buffer]",
              path = "[Path]",
              nvim_lua = "[Lua]",
              calc = "[Calc]",
              emoji = "[Emoji]",
            })[entry.source.name]
            if entry.source.name == "copilot" then
              vim_item.kind = "󰚩 Copilot"
            end
            return vim_item
          end,
        }),
      },

      experimental = {
        ghost_text = vim.g.ai_cmp and {
          hl_group = "CmpGhostText",
        } or false,
      },
    })
    cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
  end,
}
