-- Minimal config for reproducing https://github.com/neovim/neovim/issues/31316
--
-- This is based off the minimal reproducer recipe provided from the rustacean plugin:
-- https://github.com/mrcjkb/rustaceanvim
--
-- Because I would assume sourcing random files from people on the internet you don't
-- know is sketchy, I've added comments so you can understand what this does
-- (maybe you don't need them, but better safe then sorry ♥)
--
-- XXX XXX XXX XXX
-- !!! CAUTION !!!
-- Isolate your nvim with NVIM_APPNAME or whatever since this will run and install things
-- You have been warned!!
-- !!! CAUTION !!!
-- XXX XXX XXX XXX

-- Bootstraps a basic plugin manager
vim.env.LAZY_STDPATH = '.repro'
load(vim.fn.system('curl -s https://raw.githubusercontent.com/folke/lazy.nvim/main/bootstrap.lua'))()

-- Install the plugins we need
require('lazy.minit').repro {
  spec = {
    -- Seems to setup rust-analyzer for LSP completion on nvim
    {
      'mrcjkb/rustaceanvim',
      version = '^5',
      init = function()
        -- Configure rustaceanvim here
        vim.g.rustaceanvim = {}
      end,
      lazy = false,
    },
    -- Completion plugin for LSP support
    -- You've probably seen this plugin before
    {
      'hrsh7th/cmp-nvim-lsp',
      lazy = false,
    },
    -- Nvim completion plugin
    -- You've probably seen this one as well
    {
      'hrsh7th/nvim-cmp',
      lazy = false,
      init = function()
        local cmp = require('cmp')
        cmp.setup({
          sources = {
            { name = 'nvim_lsp' },
          },
          -- We need to make sure we use the external GUI popup,
          -- otherwise this won't trigger the bug
          view = {
            entries = 'native',
          },
        })
      end,
    },
  },
}
-- vim: ts=2 sts=2 sw=2 expandtab :
