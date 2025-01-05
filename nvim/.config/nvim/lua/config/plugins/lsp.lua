return {
  "neovim/nvim-lspconfig",
  dependencies = {
    'saghen/blink.cmp',
    {
      "folke/lazydev.nvim",
      opts = {
        library = {
          { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        },
      },
    },
    {
      "microsoft/python-type-stubs",
      cond = false
    },
  },
  config = function()
    local lspconfig = require("lspconfig")
    local capabilities = require('blink.cmp').get_lsp_capabilities()

    -- -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
    -- local capabilities = vim.lsp.protocol.make_client_capabilities()
    -- capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
    -- capabilities.textDocument.completion.completionItem.snippetSupport = true
    -- capabilities.textDocument.completion.completionItem.resolveSupport = {
    --   properties = { 'documentation', 'detail', 'additionalTextEdits' },
    -- }

    vim.diagnostic.config({ virtual_text = false, })


    ---
    --- Server configs
    ---

    -- (La)tex
    lspconfig.texlab.setup {
      capabilities = capabilities,
      cmd = { "texlab" },
      filetypes = { "plaintex", "tex", "bib" },
      settings = {
        texlab = {
          auxDirectory = ".",
          bibtexFormatter = "texlab",
          build = {
            args = { "-pdf", "-dvi-", "-interaction=nonstopmode", "-synctex=1", "%f" },
            executable = "latexmk",
            forwardSearchAfter = false,
            onSave = false
          },
          chktex = {
            onEdit = false,
            onOpenAndSave = false
          },
          diagnosticsDelay = 300,
          formatterLineLength = 80,
          forwardSearch = {
            args = {}
          },
          latexFormatter = "latexindent",
          latexindent = {
            modifyLineBreaks = false
          }
        }
      },
      single_file_support = true
    }

    -- Lua
    lspconfig.lua_ls.setup { capabilities = capabilities }

    -- C/C++
    lspconfig.clangd.setup {
      capabilities = capabilities,
      settings = {
        clangd = {
          checkUpdates = false,
          restartAfterCrash = true,   -- Auto restart clangd (up to 4 times) if it crashes.
          onConfigChanged = "prompt", -- values: prompt|restart|ignore  (if clangd 12+, will be ignored)
          semanticHighlighting = true,
          serverCompletionRanking = true,
          detectExtensionConflicts = true,
        }
      },

      cmd = { 'clangd',
        unpack({
          "--enable-config=true",
          "--fallback-style=google",
          "--log=error",
          "--all-scopes-completion",
          "--completion-parse=always",
          "--completion-style=bundled", -- detailed, bundled
          "--header-insertion=iwyu",
          "--header-insertion-decorators",
          "--offset-encoding=utf-16",
          "--ranking-model=heuristics",
          "--folding-ranges",
          "--clang-tidy",
          "-j=12",
          "--limit-references=100",
          "--limit-results=20",
          "--background-index",
          "--pch-storage=memory",
          "--function-arg-placeholders=true",
        }) },

      filetypes = { 'c', 'cpp', 'objc', 'objcpp', 'cuda', 'proto' },

      root_dir = require('lspconfig.util').root_pattern(
        '.clangd', '.clang-tidy', '.clang-format', 'compile_commands.json',
        'compile_flags.txt', 'configure.ac', '.git', 'build/compile_commands.json'
      ) or function() return vim.loop.cwd() end,
    }

    -- Python
    lspconfig.basedpyright.setup {
      on_attach = function(client, bufnr)
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
      end,
      capabilities = capabilities,
      cmd = { "basedpyright-langserver", "--stdio" },
      filetypes = { "python" },
      -- root_dir = function(fname)
      --   local root_files = {
      --     'pyproject.toml', 'setup.py', 'setup.cfg', 'requirements.txt',
      --     'requirements-dev.txt', 'Pipfile', 'pyrightconfig.json'
      --   }
      --   return require('lspconfig.util').root_pattern(unpack(root_files))(fname) or
      --       require('lspconfig.util').find_git_ancestor(fname) or require('lspconfig.util').path.dirname(fname)
      -- end,
      settings = {
        basedpyright = {
          -- pyright = {
          --   disableLanguageServices = false,
          --   disableOrganizeImports = false,
          -- },
          analysis = {
            autoImportCompletions = true,
            autoSearchPaths = true,
            diagnosticMode = "openFilesOnly",
            useLibraryCodeForTypes = true,
            inlayHints = {
              functionReturnTypes = true,
              genericTypes = true,
              callArgumentNames = true,
              variableTypes = false,
            },
          },
          typeCheckingMode = "standard", -- values: off | basic | standard | strict | recommended | all

        }
      },
      single_file_support = true
    }


    ---
    --- Mappings
    ---

    vim.keymap.set('n', 'gh', vim.diagnostic.open_float)
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next)

    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('UserLspConfig', {}),
      callback = function(ev)
        local opts = { buffer = ev.buf }

        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        vim.keymap.set('i', '<C-k>', vim.lsp.buf.signature_help, opts)
        vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
        vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)

        -- Formatting binding
        vim.keymap.set('n', '<leader>=', function()
          vim.lsp.buf.format { async = true }
        end, opts)


        -- Document Highlight
        -- src: https://github.com/batusai513/personal-dotfiles/neovim/.config/nvim/lua/plugins/configs/lsp/document_highlight.lua
        local group = vim.api.nvim_create_augroup('lsp_document_highlight', {})
        local function buf_autocmd_document_highlight(bufnr)
          vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
            buffer = bufnr,
            group = group,
            callback = vim.lsp.buf.document_highlight,
          })
          vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
            buffer = bufnr,
            group = 'lsp_document_highlight',
            callback = vim.lsp.buf.clear_references,
          })
        end
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        if client.supports_method 'textDocument/documentHighlight' then
          buf_autocmd_document_highlight(ev.buf)
        end
      end,
    })
  end
}
