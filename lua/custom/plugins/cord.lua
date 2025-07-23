return {
  'vyfor/cord.nvim',
  build = ':Cord update',
  opts = {
    idle = {
      details = 'AFK',
    },
    editor = {
      tooltip = 'Я долбоёб',
    },
    text = {
      editing = function(opts)
        return 'Editing a ' .. opts.filetype .. ' file'
      end,
      workspace = '',
    },
  },
}
