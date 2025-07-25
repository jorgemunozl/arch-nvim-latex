-- Telescope fuzzy finder

return {
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
      "nvim-telescope/telescope-file-browser.nvim",
      "nvim-telescope/telescope-project.nvim",
      "nvim-telescope/telescope-ui-select.nvim",
    },
    config = function()
      local telescope = require("telescope")
      local actions = require("telescope.actions")
      
      telescope.setup({
        defaults = {
          prompt_prefix = " ",
          selection_caret = " ",
          path_display = { "truncate" },
          file_ignore_patterns = {
            "%.aux",
            "%.bbl",
            "%.bcf",
            "%.blg",
            "%.fdb_latexmk",
            "%.fls",
            "%.log",
            "%.out",
            "%.pdf",
            "%.synctex.gz",
            "%.toc",
            "%.run.xml",
            "node_modules/",
            ".git/",
            "__pycache__/",
            "%.pyc",
          },
          mappings = {
            i = {
              ["<C-n>"] = actions.cycle_history_next,
              ["<C-p>"] = actions.cycle_history_prev,
              ["<C-j>"] = actions.move_selection_next,
              ["<C-k>"] = actions.move_selection_previous,
              ["<C-c>"] = actions.close,
              ["<Down>"] = actions.move_selection_next,
              ["<Up>"] = actions.move_selection_previous,
              ["<CR>"] = actions.select_default,
              ["<C-x>"] = actions.select_horizontal,
              ["<C-v>"] = actions.select_vertical,
              ["<C-t>"] = actions.select_tab,
              ["<C-u>"] = actions.preview_scrolling_up,
              ["<C-d>"] = actions.preview_scrolling_down,
              ["<PageUp>"] = actions.results_scrolling_up,
              ["<PageDown>"] = actions.results_scrolling_down,
              ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
              ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
              ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
              ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
              ["<C-l>"] = actions.complete_tag,
              ["<C-_>"] = actions.which_key,
            },
            n = {
              ["<esc>"] = actions.close,
              ["<CR>"] = actions.select_default,
              ["<C-x>"] = actions.select_horizontal,
              ["<C-v>"] = actions.select_vertical,
              ["<C-t>"] = actions.select_tab,
              ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
              ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
              ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
              ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
              ["j"] = actions.move_selection_next,
              ["k"] = actions.move_selection_previous,
              ["H"] = actions.move_to_top,
              ["M"] = actions.move_to_middle,
              ["L"] = actions.move_to_bottom,
              ["<Down>"] = actions.move_selection_next,
              ["<Up>"] = actions.move_selection_previous,
              ["gg"] = actions.move_to_top,
              ["G"] = actions.move_to_bottom,
              ["<C-u>"] = actions.preview_scrolling_up,
              ["<C-d>"] = actions.preview_scrolling_down,
              ["<PageUp>"] = actions.results_scrolling_up,
              ["<PageDown>"] = actions.results_scrolling_down,
              ["?"] = actions.which_key,
            },
          },
        },
        pickers = {
          find_files = {
            theme = "dropdown",
            previewer = false,
            hidden = true,
          },
          live_grep = {
            theme = "dropdown",
          },
          buffers = {
            theme = "dropdown",
            previewer = false,
            initial_mode = "normal",
            mappings = {
              i = {
                ["<C-d>"] = actions.delete_buffer,
              },
              n = {
                ["dd"] = actions.delete_buffer,
              },
            },
          },
          git_files = {
            theme = "dropdown",
            previewer = false,
          },
          help_tags = {
            theme = "ivy",
          },
          man_pages = {
            theme = "ivy",
          },
          colorscheme = {
            enable_preview = true,
          },
        },
        extensions = {
          fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case",
          },
          file_browser = {
            theme = "dropdown",
            hijack_netrw = true,
            mappings = {
              ["i"] = {},
              ["n"] = {},
            },
          },
          project = {
            base_dirs = {
              "~/projects",
              "~/work",
              "~/Documents",
            },
            hidden_files = true,
            theme = "dropdown",
          },
          ["ui-select"] = {
            require("telescope.themes").get_dropdown({}),
          },
        },
      })
      
      -- Load extensions
      telescope.load_extension("fzf")
      telescope.load_extension("file_browser")
      telescope.load_extension("project")
      telescope.load_extension("ui-select")
      
      -- Keymaps
      local builtin = require("telescope.builtin")
      local keymap = vim.keymap.set
      local opts = { noremap = true, silent = true }
      
      -- File pickers
      keymap("n", "<leader>ff", builtin.find_files, opts)
      keymap("n", "<leader>fg", builtin.live_grep, opts)
      keymap("n", "<leader>fb", builtin.buffers, opts)
      keymap("n", "<leader>fh", builtin.help_tags, opts)
      keymap("n", "<leader>fr", builtin.oldfiles, opts)
      keymap("n", "<leader>fc", builtin.colorscheme, opts)
      keymap("n", "<leader>fm", builtin.man_pages, opts)
      keymap("n", "<leader>fk", builtin.keymaps, opts)
      keymap("n", "<leader>fC", builtin.commands, opts)
      keymap("n", "<leader>fH", builtin.command_history, opts)
      keymap("n", "<leader>fs", builtin.search_history, opts)
      
      -- Git pickers
      keymap("n", "<leader>gf", builtin.git_files, opts)
      keymap("n", "<leader>gc", builtin.git_commits, opts)
      keymap("n", "<leader>gC", builtin.git_bcommits, opts)
      keymap("n", "<leader>gb", builtin.git_branches, opts)
      keymap("n", "<leader>gs", builtin.git_status, opts)
      keymap("n", "<leader>gS", builtin.git_stash, opts)
      
      -- LSP pickers
      keymap("n", "<leader>lr", builtin.lsp_references, opts)
      keymap("n", "<leader>ld", builtin.lsp_definitions, opts)
      keymap("n", "<leader>lD", builtin.lsp_type_definitions, opts)
      keymap("n", "<leader>li", builtin.lsp_implementations, opts)
      keymap("n", "<leader>ls", builtin.lsp_document_symbols, opts)
      keymap("n", "<leader>lS", builtin.lsp_workspace_symbols, opts)
      keymap("n", "<leader>le", builtin.diagnostics, opts)
      
      -- Vim pickers
      keymap("n", "<leader>vr", builtin.registers, opts)
      keymap("n", "<leader>vm", builtin.marks, opts)
      keymap("n", "<leader>vj", builtin.jumplist, opts)
      keymap("n", "<leader>vl", builtin.loclist, opts)
      keymap("n", "<leader>vq", builtin.quickfix, opts)
      keymap("n", "<leader>vo", builtin.vim_options, opts)
      keymap("n", "<leader>va", builtin.autocommands, opts)
      keymap("n", "<leader>vf", builtin.filetypes, opts)
      keymap("n", "<leader>vh", builtin.highlights, opts)
      keymap("n", "<leader>vt", builtin.tags, opts)
      
      -- Extensions
      keymap("n", "<leader>fe", ":Telescope file_browser<CR>", opts)
      keymap("n", "<leader>fp", ":Telescope project<CR>", opts)
      
      -- LaTeX-specific searches
      keymap("n", "<leader>lt", function()
        builtin.live_grep({
          search_dirs = { vim.fn.expand("%:p:h") },
          default_text = "\\\\(begin|end)\\{",
          prompt_title = "LaTeX Environments",
        })
      end, opts)
      
      keymap("n", "<leader>lf", function()
        builtin.find_files({
          search_dirs = { vim.fn.expand("%:p:h") },
          prompt_title = "LaTeX Files",
          find_command = { "find", ".", "-name", "*.tex", "-o", "-name", "*.bib" },
        })
      end, opts)
      
      keymap("n", "<leader>lb", function()
        builtin.live_grep({
          search_dirs = { vim.fn.expand("%:p:h") },
          default_text = "\\\\cite\\{|\\\\ref\\{|\\\\label\\{",
          prompt_title = "LaTeX References",
        })
      end, opts)
      
      -- Search in current buffer
      keymap("n", "<leader>/", function()
        builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
          winblend = 10,
          previewer = false,
        }))
      end, opts)
      
      -- Search for word under cursor
      keymap("n", "<leader>*", function()
        builtin.grep_string({ search = vim.fn.expand("<cword>") })
      end, opts)
    end,
  },
}
