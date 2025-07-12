-- debug.lua
--
-- Shows how to use the DAP plugin to debug your code.
--
-- Primarily focused on configuring the debugger for Go, but can
-- be extended to other languages as well. That's why it's called
-- kickstart.nvim and not kitchen-sink.nvim ;)

return {
  -- NOTE: Yes, you can install new plugins here!
  'mfussenegger/nvim-dap',
  -- NOTE: And you can specify dependencies as well
  dependencies = {
    -- Creates a beautiful debugger UI
    'rcarriga/nvim-dap-ui',

    -- Required dependency for nvim-dap-ui
    'nvim-neotest/nvim-nio',

    -- Installs the debug adapters for you
    'mason-org/mason.nvim',
    'jay-babu/mason-nvim-dap.nvim',

    -- Add your own debuggers here
    'leoluz/nvim-dap-go',
    'mfussenegger/nvim-dap-python',
  },
  keys = {
    -- Basic debugging keymaps, feel free to change to your liking!
    {
      '<F5>',
      function()
        require('dap').continue()
      end,
      desc = 'Debug: Start/Continue',
    },
    {
      '<F1>',
      function()
        require('dap').step_into()
      end,
      desc = 'Debug: Step Into',
    },
    {
      '<F2>',
      function()
        require('dap').step_over()
      end,
      desc = 'Debug: Step Over',
    },
    {
      '<F3>',
      function()
        require('dap').step_out()
      end,
      desc = 'Debug: Step Out',
    },
    {
      '<leader>b',
      function()
        require('dap').toggle_breakpoint()
      end,
      desc = 'Debug: Toggle Breakpoint',
    },
    {
      '<leader>B',
      function()
        require('dap').set_breakpoint(vim.fn.input 'Breakpoint condition: ')
      end,
      desc = 'Debug: Set Breakpoint',
    },
    -- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
    {
      '<F7>',
      function()
        require('dapui').toggle()
      end,
      desc = 'Debug: See last session result.',
    },
  },
  config = function()
    local dap = require 'dap'
    local dapui = require 'dapui'

    require('mason-nvim-dap').setup {
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
        'delve',
        'debugpy', -- Debug server for python
      },
    }

    -- Dap UI setup
    -- For more information, see |:help nvim-dap-ui|
    dapui.setup {
      -- Set icons to characters that are more likely to work in every terminal.
      --    Feel free to remove or use ones that you like more! :)
      --    Don't feel like these are good choices.
      icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
      controls = {
        icons = {
          pause = '⏸',
          play = '▶',
          step_into = '⏎',
          step_over = '⏭',
          step_out = '⏮',
          step_back = 'b',
          run_last = '▶▶',
          terminate = '⏹',
          disconnect = '⏏',
        },
      },
    }

    -- Change breakpoint icons
    -- vim.api.nvim_set_hl(0, 'DapBreak', { fg = '#e51400' })
    -- vim.api.nvim_set_hl(0, 'DapStop', { fg = '#ffcc00' })
    -- local breakpoint_icons = vim.g.have_nerd_font
    --     and { Breakpoint = '', BreakpointCondition = '', BreakpointRejected = '', LogPoint = '', Stopped = '' }
    --   or { Breakpoint = '●', BreakpointCondition = '⊜', BreakpointRejected = '⊘', LogPoint = '◆', Stopped = '⭔' }
    -- for type, icon in pairs(breakpoint_icons) do
    --   local tp = 'Dap' .. type
    --   local hl = (type == 'Stopped') and 'DapStop' or 'DapBreak'
    --   vim.fn.sign_define(tp, { text = icon, texthl = hl, numhl = hl })
    -- end

    dap.listeners.after.event_initialized['dapui_config'] = dapui.open
    dap.listeners.before.event_terminated['dapui_config'] = dapui.close
    dap.listeners.before.event_exited['dapui_config'] = dapui.close

    -- Install golang specific config
    require('dap-go').setup {
      delve = {
        -- On Windows delve must be run attached or it crashes.
        -- See https://github.com/leoluz/nvim-dap-go/blob/main/README.md#configuring
        detached = vim.fn.has 'win32' == 0,
      },
    }

    -- NOTE: This code is written by Deepseek, so it may be trash
    local function find_venv_python()
      local cwd = vim.fn.getcwd()
      local candidates = {
        cwd .. '/.venv/bin/python', -- Unix-like systems
        cwd .. '/venv/bin/python', -- Alternative Unix
        cwd .. '/env/bin/python', -- Another alternative
        cwd .. '/.venv/Scripts/python.exe', -- Windows
      }

      -- Check parent directories (up to 3 levels up)
      for i = 1, 3 do
        local parent = vim.fn.fnamemodify(cwd, ':h' .. string.rep(':h', i))
        table.insert(candidates, parent .. '/.venv/bin/python')
        table.insert(candidates, parent .. '/venv/bin/python')
        table.insert(candidates, parent .. '/env/bin/python')
        table.insert(candidates, parent .. '/.venv/Scripts/python.exe')
      end

      for _, path in ipairs(candidates) do
        if vim.fn.filereadable(path) == 1 and vim.fn.executable(path) == 1 then
          return path
        end
      end

      return 'python3' -- Fallback to global Python
    end

    -- Configure dap-python with dynamic venv detection
    local python_path = find_venv_python()
    require('dap-python').setup(python_path)

    -- Update debug configurations to use the detected Python path
    dap.configurations.python = dap.configurations.python or {}
    for _, config in ipairs(dap.configurations.python) do
      config.pythonPath = function()
        return find_venv_python()
      end
    end

    -- Add a new configuration that uses the dynamic path
    table.insert(dap.configurations.python, {
      type = 'python',
      request = 'launch',
      name = 'Python: Dynamic Venv',
      program = '${file}',
      pythonPath = function()
        return find_venv_python()
      end,
    })

    -- Print debug information on startup
    vim.schedule(function()
      local current_python = find_venv_python()
      local debugpy_version = vim.fn.system(current_python .. ' -m debugpy --version 2>&1')
      print('[dap-python] Using: ' .. current_python)
      print('[dap-python] debugpy version: ' .. debugpy_version)
    end)
  end,
}
