-- Key mappings

local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- General keymaps
keymap("n", "<leader>w", ":w<CR>", opts)                    -- Save file
keymap("n", "<leader>q", ":q<CR>", opts)                    -- Quit
keymap("n", "<leader>x", ":x<CR>", opts)                    -- Save and quit
keymap("n", "<leader>Q", ":qa!<CR>", opts)                  -- Force quit all

-- Buffer navigation
keymap("n", "<S-h>", ":bprevious<CR>", opts)                -- Previous buffer
keymap("n", "<S-l>", ":bnext<CR>", opts)                    -- Next buffer
keymap("n", "<leader>bd", ":bdelete<CR>", opts)             -- Delete buffer

-- Window navigation
keymap("n", "<C-h>", "<C-w>h", opts)                        -- Move to left window
keymap("n", "<C-j>", "<C-w>j", opts)                        -- Move to bottom window
keymap("n", "<C-k>", "<C-w>k", opts)                        -- Move to top window
keymap("n", "<C-l>", "<C-w>l", opts)                        -- Move to right window

-- Window resizing
keymap("n", "<C-Up>", ":resize +2<CR>", opts)               -- Increase height
keymap("n", "<C-Down>", ":resize -2<CR>", opts)             -- Decrease height
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)    -- Decrease width
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)   -- Increase width

-- Text editing
keymap("v", "<", "<gv", opts)                               -- Indent left and reselect
keymap("v", ">", ">gv", opts)                               -- Indent right and reselect
keymap("v", "J", ":move '>+1<CR>gv-gv", opts)               -- Move line down
keymap("v", "K", ":move '<-2<CR>gv-gv", opts)               -- Move line up

-- Better search navigation
keymap("n", "n", "nzzzv", opts)                             -- Center screen when searching
keymap("n", "N", "Nzzzv", opts)                             -- Center screen when searching

-- Clear search highlighting
keymap("n", "<Esc>", ":nohlsearch<CR>", opts)

-- Insert mode navigation
keymap("i", "<C-h>", "<Left>", opts)                        -- Move left in insert mode
keymap("i", "<C-j>", "<Down>", opts)                        -- Move down in insert mode
keymap("i", "<C-k>", "<Up>", opts)                          -- Move up in insert mode
keymap("i", "<C-l>", "<Right>", opts)                       -- Move right in insert mode

-- Command mode navigation
keymap("c", "<C-h>", "<Left>", opts)                        -- Move left in command mode
keymap("c", "<C-j>", "<Down>", opts)                        -- Move down in command mode
keymap("c", "<C-k>", "<Up>", opts)                          -- Move up in command mode
keymap("c", "<C-l>", "<Right>", opts)                       -- Move right in command mode

-- LaTeX specific keymaps (these will be enhanced by plugins)
keymap("n", "<leader>ll", ":VimtexCompile<CR>", opts)       -- Start/stop compilation
keymap("n", "<leader>lv", ":VimtexView<CR>", opts)          -- View PDF
keymap("n", "<leader>lc", ":VimtexClean<CR>", opts)         -- Clean auxiliary files
keymap("n", "<leader>lC", ":VimtexClean!<CR>", opts)        -- Clean all files
keymap("n", "<leader>le", ":VimtexErrors<CR>", opts)        -- Show errors
keymap("n", "<leader>lo", ":VimtexCompileOutput<CR>", opts) -- Show compilation output
keymap("n", "<leader>lg", ":VimtexStatus<CR>", opts)        -- Show status
keymap("n", "<leader>lG", ":VimtexStatusAll<CR>", opts)     -- Show status for all
keymap("n", "<leader>lk", ":VimtexStop<CR>", opts)          -- Stop compilation
keymap("n", "<leader>lK", ":VimtexStopAll<CR>", opts)       -- Stop all compilation

-- Quick LaTeX insertions in insert mode
keymap("i", "<C-b>", "\\textbf{}<Left>", opts)              -- Bold text
keymap("i", "<C-i>", "\\textit{}<Left>", opts)              -- Italic text
keymap("i", "<C-u>", "\\underline{}<Left>", opts)           -- Underline text
keymap("i", "<C-e>", "\\emph{}<Left>", opts)                -- Emphasize text

-- Math mode shortcuts
keymap("i", "<C-m>", "$$<Left>", opts)                      -- Inline math
keymap("i", "<C-M>", "\\[\\]<Left><Left>", opts)            -- Display math
