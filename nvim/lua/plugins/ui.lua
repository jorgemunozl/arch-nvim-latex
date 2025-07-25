-- Status line configuration

return {
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "VeryLazy",
    config = function()
      local lualine = require("lualine")
      
      -- Custom components
      local function show_macro_recording()
        local recording_register = vim.fn.reg_recording()
        if recording_register == "" then
          return ""
        else
          return "Recording @" .. recording_register
        end
      end
      
      local function lsp_client()
        local clients = vim.lsp.get_active_clients({ bufnr = 0 })
        if next(clients) == nil then
          return ""
        end
        
        local client_names = {}
        for _, client in ipairs(clients) do
          table.insert(client_names, client.name)
        end
        return "LSP: " .. table.concat(client_names, ", ")
      end
      
      local function latex_status()
        if vim.bo.filetype == "tex" then
          -- Check if VimTeX is available and get compilation status
          if vim.fn.exists("*vimtex#compiler#status") == 1 then
            local status = vim.fn["vimtex#compiler#status"]()
            if status == 1 then
              return "󱁤 Compiling"
            elseif status == 0 then
              return "󱁤 Ready"
            else
              return "󱁤 Error"
            end
          else
            return "󱁤 LaTeX"
          end
        end
        return ""
      end
      
      local function word_count()
        if vim.bo.filetype == "tex" or vim.bo.filetype == "markdown" then
          local words = vim.fn.wordcount().words
          return words .. " words"
        end
        return ""
      end
      
      -- Configure lualine
      lualine.setup({
        options = {
          icons_enabled = true,
          theme = "auto",
          component_separators = { left = "", right = "" },
          section_separators = { left = "", right = "" },
          disabled_filetypes = {
            statusline = {},
            winbar = {},
          },
          ignore_focus = {},
          always_divide_middle = true,
          globalstatus = true,
          refresh = {
            statusline = 1000,
            tabline = 1000,
            winbar = 1000,
          }
        },
        sections = {
          lualine_a = {
            {
              "mode",
              fmt = function(str)
                return str:sub(1, 1)
              end,
            }
          },
          lualine_b = {
            "branch",
            {
              "diff",
              symbols = { added = " ", modified = " ", removed = " " },
            },
            {
              "diagnostics",
              sources = { "nvim_diagnostic", "nvim_lsp" },
              symbols = { error = " ", warn = " ", info = " ", hint = " " },
            },
          },
          lualine_c = {
            {
              "filename",
              file_status = true,
              newfile_status = false,
              path = 1,
              shorting_target = 40,
              symbols = {
                modified = "[+]",
                readonly = "[-]",
                unnamed = "[No Name]",
                newfile = "[New]",
              }
            },
            {
              show_macro_recording,
              color = { fg = "#ff9e64" },
            },
          },
          lualine_x = {
            latex_status,
            word_count,
            lsp_client,
            "encoding",
            {
              "fileformat",
              symbols = {
                unix = "",
                dos = "",
                mac = "",
              }
            },
            "filetype"
          },
          lualine_y = { "progress" },
          lualine_z = { "location" }
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = { "filename" },
          lualine_x = { "location" },
          lualine_y = {},
          lualine_z = {}
        },
        tabline = {},
        winbar = {},
        inactive_winbar = {},
        extensions = {
          "nvim-tree",
          "telescope",
          "fugitive",
          "quickfix",
        }
      })
      
      -- Auto-refresh for macro recording
      vim.api.nvim_create_autocmd("RecordingEnter", {
        callback = function()
          lualine.refresh()
        end,
      })
      
      vim.api.nvim_create_autocmd("RecordingLeave", {
        callback = function()
          local timer = vim.loop.new_timer()
          timer:start(50, 0, vim.schedule_wrap(function()
            lualine.refresh()
          end))
        end,
      })
    end,
  },
  
  {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = "nvim-tree/nvim-web-devicons",
    event = "VeryLazy",
    config = function()
      require("bufferline").setup({
        options = {
          mode = "buffers",
          numbers = "none",
          close_command = "bdelete! %d",
          right_mouse_command = "bdelete! %d",
          left_mouse_command = "buffer %d",
          middle_mouse_command = nil,
          indicator = {
            icon = "▎",
            style = "icon",
          },
          buffer_close_icon = "󰅖",
          modified_icon = "●",
          close_icon = "",
          left_trunc_marker = "",
          right_trunc_marker = "",
          max_name_length = 18,
          max_prefix_length = 15,
          truncate_names = true,
          tab_size = 18,
          diagnostics = "nvim_lsp",
          diagnostics_update_in_insert = false,
          diagnostics_indicator = function(count, level, diagnostics_dict, context)
            local icon = level:match("error") and " " or " "
            return " " .. icon .. count
          end,
          custom_filter = function(buf_number, buf_numbers)
            -- Filter out temporary and special buffers
            local buftype = vim.bo[buf_number].buftype
            local filetype = vim.bo[buf_number].filetype
            
            if buftype == "terminal" or buftype == "quickfix" then
              return false
            end
            
            if filetype == "NvimTree" or filetype == "alpha" then
              return false
            end
            
            return true
          end,
          offsets = {
            {
              filetype = "NvimTree",
              text = "File Explorer",
              text_align = "left",
              separator = true,
            },
          },
          color_icons = true,
          show_buffer_icons = true,
          show_buffer_close_icons = true,
          show_close_icon = true,
          show_tab_indicators = true,
          show_duplicate_prefix = true,
          persist_buffer_sort = true,
          separator_style = "slant",
          enforce_regular_tabs = false,
          always_show_bufferline = true,
          hover = {
            enabled = true,
            delay = 200,
            reveal = { "close" },
          },
          sort_by = "insert_after_current",
        },
      })
      
      -- Keymaps for buffer navigation
      local keymap = vim.keymap.set
      local opts = { noremap = true, silent = true }
      
      keymap("n", "<S-h>", ":BufferLineCyclePrev<CR>", opts)
      keymap("n", "<S-l>", ":BufferLineCycleNext<CR>", opts)
      keymap("n", "<leader>bd", ":BufferLinePickClose<CR>", opts)
      keymap("n", "<leader>bp", ":BufferLinePick<CR>", opts)
      keymap("n", "<leader>bP", ":BufferLineTogglePin<CR>", opts)
      keymap("n", "<leader>bo", ":BufferLineCloseOthers<CR>", opts)
      keymap("n", "<leader>br", ":BufferLineCloseRight<CR>", opts)
      keymap("n", "<leader>bl", ":BufferLineCloseLeft<CR>", opts)
      keymap("n", "<leader>bse", ":BufferLineSortByExtension<CR>", opts)
      keymap("n", "<leader>bsd", ":BufferLineSortByDirectory<CR>", opts)
      keymap("n", "<leader>bst", ":BufferLineSortByTabs<CR>", opts)
      
      -- Move buffers
      keymap("n", "<leader>bmh", ":BufferLineMovePrev<CR>", opts)
      keymap("n", "<leader>bml", ":BufferLineMoveNext<CR>", opts)
      
      -- Go to buffer by position
      for i = 1, 9 do
        keymap("n", "<leader>" .. i, ":BufferLineGoToBuffer " .. i .. "<CR>", opts)
      end
    end,
  },
}
