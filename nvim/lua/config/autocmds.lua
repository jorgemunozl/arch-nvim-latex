-- Autocommands

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- General autocommands
local general = augroup("General", { clear = true })

-- Highlight yanked text
autocmd("TextYankPost", {
  group = general,
  pattern = "*",
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 200 })
  end,
})

-- Remove trailing whitespace on save
autocmd("BufWritePre", {
  group = general,
  pattern = "*",
  command = [[%s/\s\+$//e]],
})

-- Restore cursor position
autocmd("BufReadPost", {
  group = general,
  pattern = "*",
  callback = function()
    local line = vim.fn.line("'\"")
    if line > 1 and line <= vim.fn.line("$") then
      vim.cmd('normal! g`"')
    end
  end,
})

-- LaTeX specific autocommands
local latex = augroup("LaTeX", { clear = true })

-- Set LaTeX file type for .tex files
autocmd({ "BufRead", "BufNewFile" }, {
  group = latex,
  pattern = "*.tex",
  command = "set filetype=tex",
})

-- LaTeX specific settings
autocmd("FileType", {
  group = latex,
  pattern = "tex",
  callback = function()
    vim.opt_local.wrap = true           -- Enable line wrapping for LaTeX
    vim.opt_local.linebreak = true      -- Break lines at word boundaries
    vim.opt_local.textwidth = 80        -- Set text width to 80 characters
    vim.opt_local.spell = true          -- Enable spell checking
    vim.opt_local.spelllang = "en_us"   -- Set spell check language
    vim.opt_local.conceallevel = 2      -- Enable concealing
    vim.opt_local.foldmethod = "manual" -- Use manual folding for LaTeX
  end,
})

-- Auto-save LaTeX files when focus is lost
autocmd("FocusLost", {
  group = latex,
  pattern = "*.tex",
  command = "silent! wa",
})

-- Automatically compile LaTeX on save (optional)
autocmd("BufWritePost", {
  group = latex,
  pattern = "*.tex",
  callback = function()
    -- Only auto-compile if VimTeX is available and compilation is enabled
    if vim.g.vimtex_enabled and vim.g.auto_compile_latex then
      vim.cmd("VimtexCompile")
    end
  end,
})

-- Markdown specific settings (for documentation)
local markdown = augroup("Markdown", { clear = true })

autocmd("FileType", {
  group = markdown,
  pattern = "markdown",
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.linebreak = true
    vim.opt_local.spell = true
    vim.opt_local.conceallevel = 2
  end,
})

-- Git commit message settings
local git = augroup("Git", { clear = true })

autocmd("FileType", {
  group = git,
  pattern = "gitcommit",
  callback = function()
    vim.opt_local.textwidth = 72
    vim.opt_local.spell = true
  end,
})

-- Terminal settings
local terminal = augroup("Terminal", { clear = true })

autocmd("TermOpen", {
  group = terminal,
  pattern = "*",
  callback = function()
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    vim.opt_local.signcolumn = "no"
  end,
})

-- Auto-enter insert mode when entering terminal
autocmd("BufEnter", {
  group = terminal,
  pattern = "term://*",
  command = "startinsert",
})

-- File type specific settings
local filetypes = augroup("FileTypes", { clear = true })

-- Python settings
autocmd("FileType", {
  group = filetypes,
  pattern = "python",
  callback = function()
    vim.opt_local.tabstop = 4
    vim.opt_local.shiftwidth = 4
    vim.opt_local.expandtab = true
  end,
})

-- Lua settings
autocmd("FileType", {
  group = filetypes,
  pattern = "lua",
  callback = function()
    vim.opt_local.tabstop = 2
    vim.opt_local.shiftwidth = 2
    vim.opt_local.expandtab = true
  end,
})
