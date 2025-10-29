-- LaTeX support with VimTeX

return {
  {
    "lervag/vimtex",
    lazy = false,
    ft = { "tex", "latex" },
    init = function()
      -- VimTeX configuration
      vim.g.vimtex_view_method = "zathura"
      vim.g.vimtex_view_general_viewer = "zathura"
      vim.g.vimtex_view_general_options = [[--unique file:@pdf\#src:@line@tex]]
      vim.g.vimtex_view_general_options_latexmk = [[--unique]]

      local nvr = vim.fn.exepath("nvr")
      if nvr ~= "" then
        vim.g.vimtex_callback_progpath = nvr
      end
      
      -- Compiler settings
      vim.g.vimtex_compiler_method = "latexmk"
      vim.g.vimtex_compiler_latexmk = {
        build_dir = "",
        callback = 1,
        continuous = 1,
        executable = "latexmk",
        hooks = {},
        options = {
          "-verbose",
          "-file-line-error",
          "-synctex=1",
          "-interaction=nonstopmode",
        },
      }
      
      -- Quickfix settings
      vim.g.vimtex_quickfix_mode = 0
      vim.g.vimtex_quickfix_autoclose_after_keystrokes = 1
      vim.g.vimtex_quickfix_open_on_warning = 0
      
      
      -- Folding
      vim.g.vimtex_fold_enabled = 1

-- This is your detailed configuration table, which is structured correctly.
-- We are just removing the conflicting 'vim.g.vimtex_fold_manual'.
vim.g.vimtex_fold_types = {
  comments = { enabled = 1 },
  envs = {
    blacklist = {},
    whitelist = {},
  },
  env_options = { enabled = 0 }, -- Set to 1 if you want to fold based on env options
  markers = { enabled = 0 },     -- Set to 1 to enable marker folding
  sections = {
    parse_levels = 1, -- Set to 1 to enable parsing of section levels
    -- Your section definitions are good
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
      
      -- Indentation
      vim.g.vimtex_indent_enabled = 1
      vim.g.vimtex_indent_bib_enabled = 1
      vim.g.vimtex_indent_tikz_commands = 1
      
      -- Completion
      vim.g.vimtex_complete_enabled = 1
      vim.g.vimtex_complete_close_braces = 1
      vim.g.vimtex_complete_ignore_case = 1
      vim.g.vimtex_complete_smart_case = 1
      
      -- Motion settings
      vim.g.vimtex_motion_enabled = 1
      vim.g.vimtex_motion_matchparen = 1
      
      -- Text objects
      vim.g.vimtex_text_obj_enabled = 1
      vim.g.vimtex_text_obj_linewise_operators = { "d", "y" }
      
      -- Table of contents
      vim.g.vimtex_toc_config = {
        name = "TOC",
        layers = { "content", "todo", "include" },
        split_width = 25,
        todo_sorted = 0,
        show_help = 1,
        show_numbers = 1,
        mode = 2,
      }
      
      -- Disable insert mode mappings to avoid conflicts
      vim.g.vimtex_imaps_enabled = 0
      
      -- Disable some default mappings
      vim.g.vimtex_mappings_enabled = 1
      vim.g.vimtex_mappings_disable = {
        n = { "K" }, -- We use K for LSP hover
      }
      
      -- Enable shell escape for minted, tikz, etc.
      vim.g.vimtex_compiler_latexmk_engines = {
        _ = "-pdf",
        pdflatex = "-pdf",
        dvipdfmx = "-pdfdvi",
        lualatex = "-lualatex",
        xelatex = "-xelatex",
      }
      
      -- Clean up auxiliary files
      vim.g.vimtex_compiler_clean_paths = {
        "*.aux",
        "*.bbl",
        "*.bcf",
        "*.blg",
        "*.idx",
        "*.ind",
        "*.lof",
        "*.lot",
        "*.out",
        "*.toc",
        "*.acn",
        "*.acr",
        "*.alg",
        "*.glg",
        "*.glo",
        "*.gls",
        "*.ist",
        "*.fls",
        "*.log",
        "*.fdb_latexmk",
        "*.snm",
        "*.nav",
        "*.vrb",
        "*.figlist",
        "*.figlist",
        "*.makefile",
        "*.fdb_latexmk",
        "*.run.xml",
      }
      
      -- Error format
      vim.g.vimtex_quickfix_ignore_filters = {
        "Underfull \\hbox",
        "Overfull \\hbox",
        "LaTeX Warning: .\\+float specifier changed to",
        "LaTeX hooks Warning",
        "Package hyperref Warning: Token not allowed in a PDF string",
      }
    end,
    config = function()
      -- Additional VimTeX configuration can go here
      -- Set up custom keymaps
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "tex",
        callback = function()
          local opts = { noremap = true, silent = true, buffer = true }
          
          -- Compilation
          vim.keymap.set("n", "<localleader>ll", "<cmd>VimtexCompile<CR>", opts)
          vim.keymap.set("n", "<localleader>lv", "<cmd>VimtexView<CR>", opts)
          vim.keymap.set("n", "<localleader>lc", "<cmd>VimtexClean<CR>", opts)
          vim.keymap.set("n", "<localleader>lC", "<cmd>VimtexClean!<CR>", opts)
          vim.keymap.set("n", "<localleader>lk", "<cmd>VimtexStop<CR>", opts)
          vim.keymap.set("n", "<localleader>lK", "<cmd>VimtexStopAll<CR>", opts)
          
          -- Navigation
          vim.keymap.set("n", "<localleader>lt", "<cmd>VimtexTocToggle<CR>", opts)
          vim.keymap.set("n", "<localleader>lT", "<cmd>VimtexTocOpen<CR>", opts)
          
          -- Errors
          vim.keymap.set("n", "<localleader>le", "<cmd>VimtexErrors<CR>", opts)
          vim.keymap.set("n", "<localleader>lo", "<cmd>VimtexCompileOutput<CR>", opts)
          
          -- Status
          vim.keymap.set("n", "<localleader>lg", "<cmd>VimtexStatus<CR>", opts)
          vim.keymap.set("n", "<localleader>lG", "<cmd>VimtexStatusAll<CR>", opts)
          
          -- Info
          vim.keymap.set("n", "<localleader>li", "<cmd>VimtexInfo<CR>", opts)
          vim.keymap.set("n", "<localleader>lI", "<cmd>VimtexInfoFull<CR>", opts)
          
          -- Word count
          vim.keymap.set("n", "<localleader>lw", "<cmd>VimtexCountWords<CR>", opts)
          vim.keymap.set("n", "<localleader>lW", "<cmd>VimtexCountLetters<CR>", opts)
          
          -- Motions and text objects are handled by VimTeX automatically
        end,
      })
      
      -- Custom commands for LaTeX workflow
      vim.api.nvim_create_user_command("LatexWordCount", "VimtexCountWords", {})
      vim.api.nvim_create_user_command("LatexLetterCount", "VimtexCountLetters", {})
      vim.api.nvim_create_user_command("LatexInfo", "VimtexInfo", {})
      vim.api.nvim_create_user_command("LatexToc", "VimtexTocToggle", {})
    end,
  },
}
