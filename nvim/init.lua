-- NeoVim LaTeX Configuration
-- Main configuration file

-- Set leader key early
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Bootstrap lazy.nvim plugin manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Load core configuration
require("config.options")
require("config.keymaps")
require("config.autocmds")

-- Setup plugins
require("lazy").setup("plugins", {
  defaults = {
    lazy = false,
    version = false,
  },
  checker = { enabled = true },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})

-- Load LaTeX-specific settings
require("config.latex")

-- This is usually not necessary as vimtex does it automatically, so it is problem that is gonna to be resolved in the future!
vim.api.nvim_set_keymap('n', 'll', '<Plug>(vimtex-compile-ss)', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'lv', '<Plug>(vimtex-view)', { noremap = true, silent = true })

