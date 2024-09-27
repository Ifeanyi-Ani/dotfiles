local js_based_languages = {
  "typescript",
  "javascript",
  "typescriptreact",
  "javascriptreact",
  "vue",
}

return {
  "mfussenegger/nvim-dap",

  dependencies = {
    {
      "microsoft/vscode-js-debug",
      -- After install, build it and rename the dist directory to out
      version = "1.*",
      build = "npm install --legacy-peer-deps --no-save && npx gulp vsDebugServerBundle && rm -rf out && mv dist out",
    },
    {
      "mxsdev/nvim-dap-vscode-js",
      config = function()
        ---@diagnostic disable-next-line: missing-fields
        require("dap-vscode-js").setup({
          -- Path of node executable. Defaults to $NODE_PATH, and then "node"
          -- node_path = "node",

          -- Path to vscode-js-debug installation.
          debugger_path = vim.fn.stdpath("data") .. "/lazy/vscode-js-debug",
          -- debugger_path = vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter",

          -- Command to use to launch the debug server. Takes precedence over "node_path" and "debugger_path"
          -- debugger_cmd = { "js-debug-adapter" },

          -- which adapters to register in nvim-dap
          adapters = {
            "chrome",
            "pwa-node",
            "pwa-chrome",
            "pwa-msedge",
            "pwa-extensionHost",
            "node-terminal",
          },

          -- Path for file logging
          -- log_file_path = "(stdpath cache)/dap_vscode_js.log",

          -- Logging level for output to file. Set to false to disable logging.
          -- log_file_level = false,

          -- Logging level for output to console. Set to false to disable console output.
          -- log_console_level = vim.log.levels.ERROR,
        })
      end,
    },
    {
      "Joakker/lua-json5",
      build = "./install.sh",
    },
    -- fancy UI for the debugger
    {
      "rcarriga/nvim-dap-ui",
      dependencies = { "nvim-neotest/nvim-nio" },
      -- stylua: ignore
      keys = {
        { "<leader>bu", function() require("dapui").toggle({ }) end, desc = "Dap UI" },
        { "<leader>be", function() require("dapui").eval() end, desc = "Eval", mode = {"n", "v"} },
      },
      opts = {},
      config = function(_, opts)
        -- setup dap config by VsCode launch.json file
        -- require("dap.ext.vscode").load_launchjs()
        local dap = require("dap")
        local dapui = require("dapui")
        dapui.setup(opts)
        dap.listeners.after.event_initialized["dapui_config"] = function()
          dapui.open({})
        end
        dap.listeners.before.event_terminated["dapui_config"] = function()
          dapui.close({})
        end
        dap.listeners.before.event_exited["dapui_config"] = function()
          dapui.close({})
        end
      end,
    },

    -- virtual text for the debugger
    {
      "theHamsta/nvim-dap-virtual-text",
      opts = {},
    },

    -- which key integration
    {
      "folke/which-key.nvim",
      optional = true,
      opts = {
        defaults = {
          ["<leader>d"] = { name = "+debug" },
        },
      },
    },

    -- mason.nvim integration
    {
      "jay-babu/mason-nvim-dap.nvim",
      dependencies = "mason.nvim",
      cmd = { "DapInstall", "DapUninstall" },
      opts = {
        -- Makes a best effort to setup the various debuggers with
        -- reasonable debug configurations
        automatic_installation = true,

        -- You can provide additional configuration to the handlers,
        -- see mason-nvim-dap README for more information
        handlers = {},

        -- You'll need to check that you have the required things installed
        -- online, please don't ask me how to install them :)
        ensure_installed = {
          -- Update this to ensure that you have the debuggers for the langs you want
          "java-debug-adapter",
          "java-test",
        },
      },
    },
  },
  config = function()
    local dap = require("dap")

    for _, language in ipairs(js_based_languages) do
      dap.configurations[language] = {
        -- Debug single nodejs files
        {
          type = "pwa-node",
          request = "launch",
          name = "Launch file",
          program = "${file}",
          cwd = vim.fn.getcwd(),
          sourceMaps = true,
        },
        -- Debug nodejs processes (make sure to add --inspect when you run the process)
        {
          type = "pwa-node",
          request = "attach",
          name = "Attach",
          processId = require("dap.utils").pick_process,
          cwd = vim.fn.getcwd(),
          sourceMaps = true,
        },
        -- Debug web applications (client side)
        {
          type = "pwa-chrome",
          request = "launch",
          name = "Launch & Debug Chrome",
          url = function()
            local co = coroutine.running()
            return coroutine.create(function()
              vim.ui.input({
                prompt = "Enter URL: ",
                default = "http://localhost:3000",
              }, function(url)
                if url == nil or url == "" then
                  return
                else
                  coroutine.resume(co, url)
                end
              end)
            end)
          end,
          webRoot = vim.fn.getcwd(),
          protocol = "inspector",
          sourceMaps = true,
          userDataDir = false,
        },
        -- Divider for the launch.json derived configs
        {
          name = "----- ↓ launch.json configs ↓ -----",
          type = "",
          request = "launch",
        },
      }
    end
  end,
  keys = {
    {
      "<leader>bB",
      function()
        require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
      end,
      desc = "Breakpoint Condition",
    },
    {
      "<leader>bb",
      function()
        require("dap").toggle_breakpoint()
      end,
      desc = "Toggle Breakpoint",
    },
    {
      "<leader>bc",
      function()
        require("dap").continue()
      end,
      desc = "Continue",
    },
    {
      "<leader>ba",
      function()
        if vim.fn.filereadable(".vscode/launch.json") then
          local dap_vscode = require("dap.ext.vscode")
          dap_vscode.load_launchjs(nil, {
            ["pwa-node"] = js_based_languages,
            ["chrome"] = js_based_languages,
            ["pwa-chrome"] = js_based_languages,
          })
        end
        require("dap").continue()
      end,
      desc = "Run with Args",
    },
    {
      "<leader>bC",
      function()
        require("dap").run_to_cursor()
      end,
      desc = "Run to Cursor",
    },
    {
      "<leader>bg",
      function()
        require("dap").goto_()
      end,
      desc = "Go to Line (No Execute)",
    },
    {
      "<leader>bi",
      function()
        require("dap").step_into()
      end,
      desc = "Step Into",
    },
    {
      "<leader>bj",
      function()
        require("dap").down()
      end,
      desc = "Down",
    },
    {
      "<leader>bk",
      function()
        require("dap").up()
      end,
      desc = "Up",
    },
    {
      "<leader>bl",
      function()
        require("dap").run_last()
      end,
      desc = "Run Last",
    },
    {
      "<leader>bo",
      function()
        require("dap").step_out()
      end,
      desc = "Step Out",
    },
    {
      "<leader>bO",
      function()
        require("dap").step_over()
      end,
      desc = "Step Over",
    },
    {
      "<leader>bp",
      function()
        require("dap").pause()
      end,
      desc = "Pause",
    },
    {
      "<leader>br",
      function()
        require("dap").repl.toggle()
      end,
      desc = "Toggle REPL",
    },
    {
      "<leader>bs",
      function()
        require("dap").session()
      end,
      desc = "Session",
    },
    {
      "<leader>bt",
      function()
        require("dap").terminate()
      end,
      desc = "Terminate",
    },
    {
      "<leader>bw",
      function()
        require("dap.ui.widgets").hover()
      end,
      desc = "Widgets",
    },
  },
}
