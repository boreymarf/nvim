return {
  'L3MON4D3/LuaSnip',
  -- follow latest release.
  version = 'v2.*', -- Replace <CurrentMajor> by the latest released major (first number of latest release)
  -- install jsregexp (optional!).
  build = 'make install_jsregexp',

  config = function()
    require('luasnip').config.setup {
      -- Your LuaSnip configuration options here (optional)
      -- enable_autosnippets = true,
      -- store_selection_keys = '<Tab>',

      require('luasnip.loaders.from_lua').load { paths = { '~/.config/nvim/lua/snippets/' } },
      require('luasnip').filetype_extend('vue', { 'vue-composition', 'vuex', 'vue-router' }),
      require('luasnip.loaders.from_vscode').lazy_load(),
    }
  end,
}
