-- Core NeoVim options

local opt = vim.opt

-- General settings
opt.mouse = "a"                     -- Enable mouse support
opt.clipboard = "unnamedplus"       -- Use system clipboard
opt.swapfile = false               -- Disable swap files
opt.completeopt = "menuone,noinsert,noselect"

-- UI settings
opt.number = true                  -- Show line numbers
opt.relativenumber = true          -- Show relative line numbers
opt.cursorline = true             -- Highlight current line
opt.signcolumn = "yes"            -- Always show sign column
opt.colorcolumn = "80"            -- Show column at 80 characters
opt.scrolloff = 8                 -- Keep 8 lines above/below cursor
opt.sidescrolloff = 8             -- Keep 8 columns left/right of cursor
opt.wrap = false                  -- Don't wrap lines
opt.termguicolors = true          -- Enable 24-bit RGB colors
opt.showmode = false              -- Don't show mode in command line
opt.conceallevel = 2              -- Enable concealing for LaTeX

-- Indentation
opt.tabstop = 2                   -- Number of spaces tabs count for
opt.shiftwidth = 2                -- Size of an indent
opt.expandtab = true              -- Use spaces instead of tabs
opt.smartindent = true            -- Insert indents automatically
opt.autoindent = true             -- Copy indent from current line

-- Search settings
opt.ignorecase = true             -- Ignore case in search
opt.smartcase = true              -- Override ignorecase if search contains uppercase
opt.hlsearch = false              -- Don't highlight search results
opt.incsearch = true              -- Show search results as you type

-- Split settings
opt.splitbelow = true             -- New horizontal splits go below
opt.splitright = true             -- New vertical splits go right

-- File settings
opt.backup = false                -- Don't create backup files
opt.writebackup = false           -- Don't create backup before overwriting
opt.undofile = true               -- Enable persistent undo
opt.updatetime = 300              -- Faster completion

-- Fold settings
opt.foldmethod = "expr"           -- Use expression for folding
opt.foldexpr = "nvim_treesitter#foldexpr()"
opt.foldenable = false            -- Don't fold by default

-- LaTeX specific settings
vim.g.tex_flavor = "latex"        -- Set default tex flavor to latex
vim.g.tex_conceal = "abdmg"       -- Enable concealing for LaTeX
