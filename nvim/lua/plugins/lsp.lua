-- LSP configuration

return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup({
        ui = {
          border = "rounded",
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
          }
        }
      })
    end,
  },
  
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "mason.nvim" },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "texlab",      -- LaTeX LSP
          "ltex",        -- Grammar checking
          "lua_ls",      -- Lua LSP
          "pyright",     -- Python LSP
          "bashls",      -- Bash LSP
          "jsonls",      -- JSON LSP
          "yamlls",      -- YAML LSP
        },
        automatic_installation = true,
      })
    end,
  },
  
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "mason.nvim",
      "mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      local lspconfig = require("lspconfig")
      local cmp_nvim_lsp = require("cmp_nvim_lsp")
      
      -- LSP keymaps
      local on_attach = function(client, bufnr)
        local opts = { noremap = true, silent = true, buffer = bufnr }
        
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
        vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
        vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts)
        vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts)
        vim.keymap.set("n", "<leader>wl", function()
          print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, opts)
        vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, opts)
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
        vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
        vim.keymap.set("n", "<leader>f", function()
          vim.lsp.buf.format({ async = true })
        end, opts)
      end
      
      -- Capabilities
      local capabilities = cmp_nvim_lsp.default_capabilities()
      
      -- Configure LSP servers
      
      -- LaTeX LSP (texlab)
      lspconfig.texlab.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
          texlab = {
            auxDirectory = ".",
            bibtexFormatter = "texlab",
            build = {
              args = { "-pdf", "-interaction=nonstopmode", "-synctex=1", "%f" },
              executable = "latexmk",
              forwardSearchAfter = false,
              onSave = false,
            },
            chktex = {
              onEdit = false,
              onOpenAndSave = false,
            },
            diagnosticsDelay = 300,
            formatterLineLength = 80,
            forwardSearch = {
              args = { "--synctex-forward", "%l:1:%f", "%p" },
              executable = "zathura",
            },
            latexFormatter = "latexindent",
            latexindent = {
              modifyLineBreaks = false,
            },
          },
        },
      })
      
      -- Grammar checking (ltex)
      do
        local has_java = (vim.fn.executable("java") == 1)
        if has_java then
          lspconfig.ltex.setup({
            on_attach = on_attach,
            capabilities = capabilities,
            settings = {
              ltex = {
                language = "en-US",
                diagnosticSeverity = "information",
                sentenceCacheSize = 2000,
                additionalRules = {
                  enablePickyRules = true,
                  motherTongue = "en-US",
                },
                trace = { server = "verbose" },
                dictionary = {},
                disabledRules = {},
                hiddenFalsePositives = {},
              },
            },
            filetypes = { "latex", "tex", "bib", "markdown" },
          })
        else
          vim.schedule(function()
            vim.notify("ltex disabled: Java runtime not found. Install 'jre-openjdk-headless' or set PATH.", vim.log.levels.WARN)
          end)
        end
      end
      
      -- Lua LSP
      lspconfig.lua_ls.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
          Lua = {
            runtime = {
              version = "LuaJIT",
            },
            diagnostics = {
              globals = { "vim" },
            },
            workspace = {
              library = vim.api.nvim_get_runtime_file("", true),
              checkThirdParty = false,
            },
            telemetry = {
              enable = false,
            },
          },
        },
      })
      
      -- Python LSP
      lspconfig.pyright.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
          python = {
            analysis = {
              autoSearchPaths = true,
              diagnosticMode = "workspace",
              useLibraryCodeForTypes = true,
            },
          },
        },
      })
      
      -- Bash LSP
      lspconfig.bashls.setup({
        on_attach = on_attach,
        capabilities = capabilities,
      })
      
      -- JSON LSP
      lspconfig.jsonls.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
          json = {
            schemas = require("schemastore").json.schemas(),
            validate = { enable = true },
          },
        },
      })
      
      -- YAML LSP
      lspconfig.yamlls.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
          yaml = {
            schemas = require("schemastore").yaml.schemas(),
            validate = true,
            completion = true,
            hover = true,
          },
        },
      })
      
      -- Configure diagnostics
      vim.diagnostic.config({
        virtual_text = {
          prefix = "●",
        },
        signs = true,
        underline = true,
        update_in_insert = false,
        severity_sort = true,
        float = {
          border = "rounded",
          source = "always",
          header = "",
          prefix = "",
        },
      })
      
      -- Diagnostic signs
      local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
      for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
      end
    end,
  },
  
  -- Schema store for JSON/YAML
  {
    "b0o/schemastore.nvim",
    lazy = true,
  },
}
