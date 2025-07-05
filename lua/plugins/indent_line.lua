return {
  { -- Add indentation guides even on blank lines
    'lukas-reineke/indent-blankline.nvim',
    -- Enable `lukas-reineke/indent-blankline.nvim`
    -- See `:help ibl`
    main = 'ibl',
    opts = {
      exclude = {
        filetypes = { 'dashboard' }, -- Only add your custom filetype
        -- (Plugin will still use its OTHER default exclusions)
      },
      indent = {
        tab_char = '▎',
      },
    },
  },
}
