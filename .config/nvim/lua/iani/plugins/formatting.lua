return {
  "stevearc/conform.nvim",
  event = { "LspAttach", "BufReadPost", "BufWritePre", "BufNewFile" },
  cmd = { "ConformInfo" },
  keys = {
    {
      "<leader>mf",
      function()
        require("conform").format({ async = true })
      end,
      mode = "",
      desc = "Format buffer",
    },
  },
  opts = {
    formatters_by_ft = {
      javascript = { "prettierd" },
      typescript = { "prettierd" },
      javascriptreact = { "prettierd" },
      typescriptreact = { "prettierd" },
      svelte = { "prettierd" },
      css = { "prettierd" },
      html = { "prettierd" },
      json = { "prettierd" },
      yaml = { "prettierd" },
      markdown = { "prettierd" },
      graphql = { "prettierd" },
      liquid = { "prettierd" },
      lua = { "stylua" },
      python = { "isort", "black" },
      dart = { "dart_format" },
    },
    default_format_opts = {
      lsp_format = "fallback",
    },
    format_on_save = {
      timeout_ms = 2500,
      lsp_fallback = true,
      async = false,
    },
    formatters = {
      shfmt = {
        prepend_args = { "-i", "2" },
      },
      prettier = {
        prepend_args = { "--prose-wrap", "always" },
      },
      dart_format = {
        command = "dart",
        args = { "format" },
      },
    },
  },
  init = function()
    vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"

    -- Flutter-specific formatting
    local flutter_tools_ok, flutter_tools = pcall(require, "flutter-tools")
    if flutter_tools_ok then
      flutter_tools.setup({
        lsp = {
          on_attach = function(client, bufnr)
            if client.server_capabilities.documentFormattingProvider then
              vim.api.nvim_create_autocmd("BufWritePre", {
                buffer = bufnr,
                callback = function()
                  vim.lsp.buf.format({ async = false })
                end,
              })
            end
          end,
        },
      })
    end
  end,
}
