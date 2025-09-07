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

-- ── VimTeX: use our own keymaps ───────────────────────────────────────────────
-- 1) Disable all default VimTeX mappings (this removes <localleader>ll, lv, …)
vim.g.vimtex_mappings_enabled = 0  -- docs: you can fully opt out of defaults

-- 2) Add comfy, buffer-local mappings only for LaTeX files
--    I use <leader>t… (t = TeX): <leader>tc = compile, <leader>tv = view.
--    Change <leader> in your config if you like (commonly <Space>).
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'tex',
  callback = function(ev)
    local o = { buffer = ev.buf, silent = true, noremap = true }

    -- Compile current project with VimTeX (latexmk by default)
    vim.keymap.set('n', 'tt', '<cmd>VimtexCompile<CR>', vim.tbl_extend('force', o, {
      desc = 'TeX: compile (VimTeX)',
    }))

    -- Open/forward-sync the PDF in your viewer
    vim.keymap.set('n', 'tv', '<cmd>VimtexView<CR>', vim.tbl_extend('force', o, {
      desc = 'TeX: view PDF (VimTeX)',
    }))

    -- (Optional extras — uncomment if you want them)
    -- vim.keymap.set('n', '<leader>tS', '<cmd>VimtexStop<CR>',     vim.tbl_extend('force', o, { desc = 'TeX: stop compiler' }))
    -- vim.keymap.set('n', '<leader>tC', '<cmd>VimtexClean<CR>',    vim.tbl_extend('force', o, { desc = 'TeX: clean aux files' }))
    -- vim.keymap.set('n', '<leader>tt', '<cmd>VimtexTocToggle<CR>',vim.tbl_extend('force', o, { desc = 'TeX: toggle TOC' }))
  end,
})
