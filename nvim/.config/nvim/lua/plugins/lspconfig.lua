return {
  'neovim/nvim-lspconfig',
  dependencies = {
    'folke/neodev.nvim'
  },
  -- event = { "BufReadPre", "BufNewFile" },
  config = function()
    local lspconfig = require('lspconfig')

    -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
    capabilities.textDocument.completion.completionItem.snippetSupport = true
    capabilities.textDocument.completion.completionItem.resolveSupport = {
      properties = { 'documentation', 'detail', 'additionalTextEdits' },
    }


    --
    -- Global mappings.
    --

    -- See `:help vim.diagnostic.*` for documentation on any of the below functions
    vim.keymap.set('n', 'gl', vim.diagnostic.open_float)
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
    vim.keymap.set('n', '<c-p>', vim.diagnostic.goto_prev)
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
    vim.keymap.set('n', '<c-n>', vim.diagnostic.goto_next)
    vim.keymap.set('n', '<leader>l', vim.diagnostic.setloclist)

    -- Use LspAttach autocommand to only map the following keys
    -- after the language server attaches to the current buffer
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('UserLspConfig', {}),
      callback = function(ev)
        -- Enable completion triggered by <c-x><c-o>
        vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

        -- Buffer local mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local opts = { buffer = ev.buf }
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
        vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
        vim.keymap.set('i', '<C-k>', vim.lsp.buf.signature_help, opts)
        -- vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
        -- vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
        -- vim.keymap.set('n', '<leader>wl', function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, opts)
        vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, opts)
        vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
        vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
        vim.keymap.set('n', '<leader>=', function()
          if vim.bo.filetype == "python" then
            -- Check if a black is installed
            if vim.fn.executable("black") == 1 and vim.fn.executable("isort") then
              vim.keymap.set("n", "<leader>=",
                function()
                  -- First write the file
                  vim.cmd("write")

                  print("hello?")
                  -- Set the formatter and formatter command
                  local formatter = "black"
                  local format_cmd = formatter .. " " .. vim.fn.expand("%")

                  -- Format and grab status code of code formatter
                  vim.fn.system(format_cmd)
                  local format_status = 1
                  if vim.v.shell_error ~= 0 then
                    format_status = 0
                  end

                  -- Sort imports
                  vim.fn.system("isort --ws " .. vim.fn.expand("%"))

                  -- Re-read buffer after changes
                  vim.cmd("silent! edit!")

                  print("hello??")

                  -- Inform user how it did went
                  if format_status == 1 then
                    vim.cmd("write")
                    print("[" .. vim.fn.toupper(formatter) .. "]: DONE!")
                  else
                    print("[" .. vim.fn.toupper(formatter) .. "]: FAILED!")
                  end
                end,
                { buffer = true, silent = true, })
            end
          else
            vim.lsp.buf.format { async = true }
          end
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


    --
    -- Server Configs
    --

    -- Lua
    lspconfig.lua_ls.setup {
      settings = {
        Lua = {
          runtime = {
            -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
            version = 'LuaJIT',
          },
          diagnostics = {
            -- Get the language server to recognize the `vim` global
            globals = { "vim", "use", "root" },
          },
          workspace = {
            -- Make the server aware of Neovim runtime files
            library = vim.api.nvim_get_runtime_file("", true),
          },
          -- Do not send telemetry data containing a randomized but unique identifier
          telemetry = {
            enable = false,
          },
        },
      },

      capabilities = capabilities

    }


    -- Python
    lspconfig.pyright.setup {
      cmd = { "pyright-langserver", "--stdio" },
      filetypes = { "python" },
      root_dir = function(fname)
        local root_files = {
          'pyproject.toml', 'setup.py', 'setup.cfg', 'requirements.txt',
          'requirements-dev.txt', 'Pipfile', 'pyrightconfig.json'
        }
        return require('lspconfig.util').root_pattern(unpack(root_files))(fname) or
            require('lspconfig.util').find_git_ancestor(fname) or require('lspconfig.util').path.dirname(fname)
      end,

      settings = {
        python = {
          analysis = {
            typeCheckingMode = "basic", -- off, basic, strict
            autoSearchPaths = true,
            diagnosticMode = "workspace",
            useLibraryCodeForTypes = true,
            reportMissingTypeStubs = "none",
            single_file_support = true
          },
        }
      },

      capabilities = capabilities
    }

    -- C/C++
    lspconfig.clangd.setup {
      cmd = { 'clangd',
        unpack({ "--fallback-style=google", "--all-scopes-completion", "--log=error", "--completion-style=detailed",
          "--header-insertion=iwyu", "--header-insertion-decorators", "--enable-config", "--offset-encoding=utf-16",
          "--ranking-model=heuristics", "--folding-ranges", "--clang-tidy", "-j=12", "--limit-references=100",
          "--limit-results=20", "--background-index", "--pch-storage=memory", }) },

      filetypes = { 'c', 'cpp', 'objc', 'objcpp', 'cuda', 'proto' },

      root_dir = require('lspconfig.util').root_pattern(
        '.clangd', '.clang-tidy', '.clang-format', 'compile_commands.json',
        'compile_flags.txt', 'configure.ac', '.git', 'build/compile_commands.json'
      ) or function() return vim.loop.cwd() end,

      capabilities = capabilities
    }

    -- Rust
    lspconfig.rust_analyzer.setup {
      cmd = { "rust-analyzer" },
      filetypes = { "rust" },
      root_dir = require("lspconfig.util").root_pattern("Cargo.toml", "rust-project.json")
          or
          function()
            return vim.loop.cwd()
          end,
      settings = {
        ["rust-analyzer"] = {
          imports = {
            granularity = {
              group = "module",
            },
            prefix = "self",
          },
          cargo = {
            buildScripts = {
              enable = true,
            },
          },
          procMacro = {
            enable = true
          },
        }
      },

      capabilities = capabilities
    }
  end
}
