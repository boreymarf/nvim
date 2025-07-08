return {
  'bngarren/checkmate.nvim',
  ft = 'markdown', -- Lazy loads for Markdown files matching patterns in 'files'
  opts = {
    keys = {
      ['<leader>Tt'] = {
        rhs = '<cmd>Checkmate toggle<CR>',
        desc = 'Toggle todo item',
        modes = { 'n', 'v' },
      },
      ['<leader>Tc'] = {
        rhs = '<cmd>Checkmate check<CR>',
        desc = 'Set todo item as checked (done)',
        modes = { 'n', 'v' },
      },
      ['<leader>Tu'] = {
        rhs = '<cmd>Checkmate uncheck<CR>',
        desc = 'Set todo item as unchecked (not done)',
        modes = { 'n', 'v' },
      },
      ['<leader>Tn'] = {
        rhs = '<cmd>Checkmate create<CR>',
        desc = 'Create todo item',
        modes = { 'n', 'v' },
      },
      ['<leader>TR'] = {
        rhs = '<cmd>Checkmate remove_all_metadata<CR>',
        desc = 'Remove all metadata from a todo item',
        modes = { 'n', 'v' },
      },
      ['<leader>Ta'] = {
        rhs = '<cmd>Checkmate archive<CR>',
        desc = 'Archive checked/completed todo items (move to bottom section)',
        modes = { 'n' },
      },
      ['<leader>Tv'] = {
        rhs = '<cmd>Checkmate metadata select_value<CR>',
        desc = 'Update the value of a metadata tag under the cursor',
        modes = { 'n' },
      },
      ['<leader>T]'] = {
        rhs = '<cmd>Checkmate metadata jump_next<CR>',
        desc = 'Move cursor to next metadata tag',
        modes = { 'n' },
      },
      ['<leader>T['] = {
        rhs = '<cmd>Checkmate metadata jump_previous<CR>',
        desc = 'Move cursor to previous metadata tag',
        modes = { 'n' },
      },
    },
    default_list_marker = '-',
    todo_markers = {
      unchecked = '',
      checked = '',
    },
    -- your configuration here
    -- or leave empty to use defaults
  },
}
