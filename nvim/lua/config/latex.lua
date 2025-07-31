-- LaTeX-specific configuration

-- Global variables for LaTeX
vim.g.auto_compile_latex = false  -- Set to true to enable auto-compilation on save

-- VimTeX configuration (will be set when plugin loads)
vim.g.vimtex_view_method = 'zathura'
vim.g.vimtex_view_general_viewer = 'zathura'
vim.g.vimtex_compiler_method = 'latexmk'

-- Compiler options
vim.g.vimtex_compiler_latexmk = {
  build_dir = '',
  callback = 1,
  continuous = 1,
  executable = 'latexmk',
  hooks = {},
  options = {
    '-verbose',
    '-file-line-error',
    '-synctex=1',
    '-interaction=nonstopmode',
  },
}

-- Quickfix settings
vim.g.vimtex_quickfix_mode = 0
vim.g.vimtex_quickfix_autoclose_after_keystrokes = 1
vim.g.vimtex_quickfix_open_on_warning = 0

-- Folding settings
vim.g.vimtex_fold_enabled = 1
vim.g.vimtex_fold_manual = 1
vim.g.vimtex_fold_types = {
  comments = { enabled = 1 },
  envs = {
    blacklist = {},
    whitelist = {},
  },
  env_options = {},
  markers = {},
  sections = {
    parse_levels = 0,
    parts = { 'part' },
    chapters = { 'chapter' },
    sections = { 'section', 'subsection', 'subsubsection' },
    fakesections = { 'paragraph', 'subparagraph' },
  },
}

-- Syntax settings
vim.g.vimtex_syntax_enabled = 1
vim.g.vimtex_syntax_conceal = {
  accents = 1,
  ligatures = 1,
  cites = 1,
  fancy = 1,
  spacing = 1,
  greek = 1,
  math_bounds = 1,
  math_delimiters = 1,
  math_fracs = 1,
  math_super_sub = 1,
  math_symbols = 1,
  sections = 0,
  styles = 1,
}

-- Disable some features for better performance
vim.g.vimtex_indent_enabled = 1
vim.g.vimtex_imaps_enabled = 0  -- Disable insert mode mappings
vim.g.vimtex_complete_enabled = 1
vim.g.vimtex_complete_close_braces = 1

-- Error format for better error reporting
vim.g.vimtex_quickfix_ignore_filters = {
  'Underfull \\hbox',
  'Overfull \\hbox',
  'LaTeX Warning: .\\+float specifier changed to',
  'LaTeX hooks Warning',
  'Package hyperref Warning: Token not allowed in a PDF string',
}

-- LaTeX utility functions
local M = {}

-- Function to toggle auto-compilation
function M.toggle_auto_compile()
  vim.g.auto_compile_latex = not vim.g.auto_compile_latex
  local status = vim.g.auto_compile_latex and "enabled" or "disabled"
  print("Auto-compilation " .. status)
end

-- Function to insert LaTeX template
function M.insert_template()
  local template = {
    "\\documentclass{article}",
    "\\usepackage[utf8]{inputenc}",
    "\\usepackage[T1]{fontenc}",
    "\\usepackage{amsmath,amsfonts,amssymb}",
    "\\usepackage{geometry}",
    "\\usepackage{graphicx}",
    "\\usepackage{hyperref}",
    "",
    "\\title{Your Title Here}",
    "\\author{Your Name}",
    "\\date{\\today}",
    "",
    "\\begin{document}",
    "",
    "\\maketitle",
    "",
    "\\section{Introduction}",
    "",
    "Your content here.",
    "",
    "\\end{document}"
  }
  
  local buf = vim.api.nvim_get_current_buf()
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, template)
  vim.api.nvim_win_set_cursor(0, {17, 0})  -- Position cursor at content line
end

-- Function to compile current LaTeX document
function M.compile_latex()
  if vim.bo.filetype == "tex" then
    vim.cmd("VimtexCompile")
  else
    print("Not a LaTeX file")
  end
end

-- Function to view PDF
function M.view_pdf()
  if vim.bo.filetype == "tex" then
    vim.cmd("VimtexView")
  else
    print("Not a LaTeX file")
  end
end

-- Function to clean auxiliary files
function M.clean_latex()
  if vim.bo.filetype == "tex" then
    vim.cmd("VimtexClean")
    print("Auxiliary files cleaned")
  else
    print("Not a LaTeX file")
  end
end

-- Create user commands
vim.api.nvim_create_user_command("LatexToggleAutoCompile", M.toggle_auto_compile, {})
vim.api.nvim_create_user_command("LatexTemplate", M.insert_template, {})
vim.api.nvim_create_user_command("LatexCompile", M.compile_latex, {})
vim.api.nvim_create_user_command("LatexView", M.view_pdf, {})
vim.api.nvim_create_user_command("LatexClean", M.clean_latex, {})

-- Additional keymaps for LaTeX workflow
vim.keymap.set("n", "<leader>lt", M.insert_template, { desc = "Insert LaTeX template" })
vim.keymap.set("n", "<leader>la", M.toggle_auto_compile, { desc = "Toggle auto-compilation" })

return M
