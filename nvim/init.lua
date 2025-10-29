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
--    I use t… (t = TeX) in normal mode: tt = compile, tc = toc, te/ta = math envs, tv = view.
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'tex',
  callback = function(ev)
    local o = { buffer = ev.buf, silent = true, noremap = true }

    -- Compile current project with VimTeX (latexmk by default)
    vim.keymap.set('n', 'tt', '<cmd>VimtexCompile<CR>', vim.tbl_extend('force', o, {
      desc = 'TeX: compile (VimTeX)',
    }))

    local function insert_env(env)
      return function()
        local buf = vim.api.nvim_get_current_buf()
        local pos = vim.api.nvim_win_get_cursor(0)
        local row = pos[1]
        local current_line = vim.api.nvim_buf_get_lines(buf, row - 1, row, false)[1] or ""
        local indent = current_line:match('^%s*') or ''
        local snippet = {
          indent .. '\\begin{' .. env .. '}',
          indent .. '  ',
          indent .. '\\end{' .. env .. '}',
        }
        vim.api.nvim_buf_set_lines(buf, row, row, false, snippet)
        vim.api.nvim_win_set_cursor(0, { row + 1, #indent + 2 })
      end
    end

    -- Insert equation/align environments with matching indentation
    vim.keymap.set('n', 'te', insert_env('equation'), vim.tbl_extend('force', o, {
      desc = 'TeX: insert equation environment',
    }))
    vim.keymap.set('n', 'ta', insert_env('align'), vim.tbl_extend('force', o, {
      desc = 'TeX: insert align environment',
    }))

    -- Toggle the structured table of contents window
    vim.keymap.set('n', 'tc', '<cmd>VimtexTocToggle<CR>', vim.tbl_extend('force', o, {
      desc = 'TeX: toggle TOC (VimTeX)',
    }))

    -- Open/forward-sync the PDF in your viewer
    vim.keymap.set('n', 'tv', '<cmd>VimtexView<CR>', vim.tbl_extend('force', o, {
      desc = 'TeX: view PDF (VimTeX)',
    }))

    -- (Optional extras — uncomment if you want them)
    -- vim.keymap.set('n', '<leader>tS', '<cmd>VimtexStop<CR>',     vim.tbl_extend('force', o, { desc = 'TeX: stop compiler' }))
    -- vim.keymap.set('n', '<leader>tC', '<cmd>VimtexClean<CR>',    vim.tbl_extend('force', o, { desc = 'TeX: clean aux files' }))
  end,
})
