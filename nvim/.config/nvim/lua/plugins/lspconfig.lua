local status, nvim_lsp = pcall(require, "lspconfig")
if (not status) then return end
local util = require('lspconfig/util')


-- Mappings.
    -- See `:help vim.diagnostic.*` for documentation on any of the below functions
    local opts = { noremap=true, silent=true }
    vim.api.nvim_set_keymap('n', '<leader>d', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
    vim.api.nvim_set_keymap('n', '<C-p>', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
    vim.api.nvim_set_keymap('n', '<C-n>', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
    vim.api.nvim_set_keymap('n', '<C-q>', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
    vim.api.nvim_set_keymap('n', '<leader>dd',
                            '<cmd>lua vim.diagnostic.disable()<CR>:echo "Diag. is Disabled"<CR>', opts)
    vim.api.nvim_set_keymap('n', '<leader>de',
                            '<cmd>lua vim.diagnostic.disable()<CR>:echo "Diag. is Enabled"<CR>', opts)

    -- Use an on_attach function to only map the following keys
    -- after the language server attaches to the current buffer
    local on_attach = function(client, bufnr)
        -- CursorHold
        if client.server_capabilities.documentHighlightProvider then
            vim.api.nvim_create_augroup("lsp_document_highlight", { clear = true })
            vim.api.nvim_clear_autocmds { buffer = bufnr, group = "lsp_document_highlight" }
            vim.api.nvim_create_autocmd("CursorHold", {
                callback = vim.lsp.buf.document_highlight,
                buffer = bufnr,
                group = "lsp_document_highlight",
                desc = "Document Highlight",
            })
            vim.api.nvim_create_autocmd("CursorMoved", {
                callback = vim.lsp.buf.clear_references,
                buffer = bufnr,
                group = "lsp_document_highlight",
                desc = "Clear All the References",
            })
        end

        -- Enable completion triggered by <c-x><c-o>
        vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

        -- Mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
        -- vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
        -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
        -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
        -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>ac', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', ',f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
    end


--  Enable (broadcasting) snippet capability for completion
local cmp_lsp = require 'cmp_nvim_lsp'
local capabilities = cmp_lsp.update_capabilities(vim.lsp.protocol.make_client_capabilities())
capabilities = cmp_lsp.update_capabilities(capabilities)


-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
    local servers = { 'pyright', 'clangd', 'sumneko_lua', 'texlab', 'gopls' }
    for _, lsp in pairs(servers) do
        require('lspconfig')[lsp].setup {
            on_attach = on_attach,
            capabilities = capabilities,
            flags = {
                -- This will be the default in neovim 0.7+
                debounce_text_changes = 150,
            }
        }
    end


-- --------------------{ TSSERVER LANGUAGE-SERVER }-------------------------------
-- -- sudo npm i -g typescript typescript-language-server
-- nvim_lsp.tsserver.setup {
--     cmd = {"typescript-language-server", "--stdio"},
--     on_attach = on_attach,
--     capabilities = capabilities,
--     filetypes = {
--         "javascript", "javascriptreact", "javascript.jsx", "typescript",
--         "typescriptreact", "typescript.tsx"
--     },
--     init_options = {hostInfo = "neovim"},
--     root_dir = util.root_pattern("package.json", "tsconfig.json", ".git", ".js",
--     vim.loop.cwd())
-- }


-- ------------------{ VSCODE HTML LANGUAGE-SERVER }------------------------------
-- -- sudo npm install --global vscode-html-languageserver-bin
-- -- the binary for this package is
-- local root_pattern = util.root_pattern("package.json")
--
-- require'lspconfig'.html.setup {
--     cmd = {"html-languageserver", "--stdio"},
--     filetypes = {"html"},
--     init_options = {
--         configurationSection = {"html", "css", "javascript"},
--         embeddedLanguages = {css = true, javascript = true}
--     },
--     root_dir = function(fname)
--         return root_pattern(fname) or vim.loop.os_homedir()
--     end,
--     settings = {},
--     capabilities = capabilities,
--     on_attach = on_attach
-- }
--


--------------------------------{ LUA }----------------------------------------
-- https://github.com/sumneko/lua-language-server/wiki/Build-and-Run-(Standalone)
-- https://jdhao.github.io/2021/08/12/nvim_sumneko_lua_conf/
local HOME = vim.fn.expand('$HOME')
local sumneko_binary_path = HOME .. '/.local/src/lua-language-server/bin/lua-language-server'
local sumneko_root_path = HOME .. "/.local/src/lua-language-server"

local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

require'lspconfig'.sumneko_lua.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    cmd = {sumneko_binary_path, "-E", sumneko_root_path .. "/main.lua"};
    settings = {
        Lua = {
        runtime = {
            -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
            version = 'LuaJIT',
            -- Setup your lua path
            path = runtime_path,
        },
        diagnostics = {
            -- Get the language server to recognize the `vim` global
            globals = {'vim'},
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
}


-- ----------------------------{ EMMET LANGUAGE SERVER }--------------------------
-- -- https://github.com/windwp/emmet-ls
-- -- # npm install -g emmet-ls
--
-- local configs = require 'lspconfig/configs'
--
-- configs.emmet_ls = {
--     default_config = {
--         cmd = {'emmet-ls', '--stdio'},
--         filetypes = {'html', 'css'},
--         root_dir = function()
--             return vim.loop.cwd()
--         end,
--         settings = {}
--     }
-- }
--
-- nvim_lsp.emmet_ls.setup {on_attach = on_attach}


-------------------------------{ BASH }----------------------------------------
-- https://github.com/bash-lsp/bash-language-server
-- # npm i -g bash-language-server

-- require'lspconfig'.bashls.setup {
--     cmd = {"bash-language-server", "start"},
--     cmd_env = {GLOB_PATTERN = "*@(.sh|.inc|.bash|.command)"},
--     filetypes = {"sh"}
-- }


------------------------------{ CLANGD }---------------------------------------
-- https://clangd.llvm.org/installation.html
-- clangd relies on a JSON compilation database specified as
-- compile_commands.json or, for simpler projects, a compile_flags.txt. For
-- details on how to automatically generate one using CMake look here.
-- https://cmake.org/cmake/help/latest/variable/CMAKE_EXPORT_COMPILE_COMMANDS.html

-- src: https://github.com/LunarVim/LunarVim/issues/2597#issuecomment-1122731886
local clangd_flags = {
  "--fallback-style=google",
  "--background-index",
  "-j=12",
  "--all-scopes-completion",
  "--pch-storage=disk",
  "--clang-tidy",
  "--log=error",
  "--completion-style=detailed",
  "--header-insertion=iwyu",
  "--header-insertion-decorators",
  "--enable-config",
  "--offset-encoding=utf-16",
  "--ranking-model=heuristics",
  "--folding-ranges",
}
local clangd_bin = "clangd"

nvim_lsp.clangd.setup {
    capabilities = capabilities,
    on_attach = on_attach,
    cmd = {clangd_bin, unpack(clangd_flags)},
    filetypes = {"c", "cpp", "objc", "objcpp"},
    root_dir =
            util.root_pattern("compile_commands.json", "compile_flags.txt", ".git")
        or
            function()
                return vim.loop.cwd()
            end
}


vim.cmd([[
augroup ClangFormat
au!
    autocmd BufEnter,BufWritePost,BufWritePre,FileType c,cpp
            \ nnoremap <silent> <leader>= :w <bar>silent! !clang-format -style=file -i %<CR>
augroup END
]])


---------------------------------{ CMAKE }-------------------------------------
-- https://github.com/regen100/cmake-language-server
-- sudo pip3 install cmake-language-server

require'lspconfig'.cmake.setup {
    cmd = {"cmake-language-server"},
    filetypes = {"cmake"},
    init_options = {buildDirectory = "build"},
    -- root_dir = root_pattern(".git", "compile_commands.json", "build")
}


----------------------------------{ PYRIGHT }----------------------------------
-- https://github.com/microsoft/pyright
-- sudo npm install -g pyright
-- pip3 install isort
-- brew install black
-- pip3 install autopep8

require'lspconfig'.pyright.setup {
    cmd = {"pyright-langserver", "--stdio"},
    filetypes = {"python"},
    root_dir = function(fname)
        local root_files = {
            'pyproject.toml', 'setup.py', 'setup.cfg', 'requirements.txt', 'Pipfile',
            'pyrightconfig.json'
        }
        return util.root_pattern(unpack(root_files))(fname) or
        util.find_git_ancestor(fname) or util.path.dirname(fname)
    end,
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
        python = {
            analysis = {
                typeCheckingMode = "strict",
                autoSearchPaths = true,
                diagnosticMode = "workspace",
                useLibraryCodeForTypes = true
            },
        }
    }
}


-- Check if code formatters exist on system
if (os.execute("command -v black >/dev/null")
        or os.execute("command -v autopep8 >/dev/null"))
    and os.execute("command -v isort >/dev/null") then
    vim.cmd([[
    function! PythonFormatter() abort
        :write
        let l:formatter = 'black'
        if l:formatter == 'black'
            :silent! !black %
        elseif l:formatter == 'autopep8'
            :silent! !autopep8 --in-place --aggressive --aggressive %
        endif
        :silent! !isort %
        " Some problems arises with completion when buffer is changed externally
        " This will be fixed if I restart lsp server
        " And for whatever reason I need to have that redraw at the end, so that
        " I can suppress some errors
        :LspRestart <bar> redraw
    endfunction

    augroup PythonFormat
        autocmd!
        autocmd BufEnter,BufWrite,BufWritePre,FileType python
            \ nnoremap <silent> <leader>= :call PythonFormatter()<CR>
    augroup END
    ]])
end


--------------------------------{ Zeta-Note }----------------------------------
-- require'lspconfig'.zeta_note.setup {
    --   cmd = {'/usr/local/bin/zeta-note-language-server'},
    --   capabilities = capabilities,
    --   on_attach = on_attach,
    --   filetypes = {"markdown"},
    --   root_dir = function()
        --     return vim.loop.cwd()
        --   end
        -- }


---------------------------------{ TeXLab }------------------------------------
-- brew install texlab

nvim_lsp.texlab.setup{
    cmd = { "texlab" },
    -- on_attach = on_attach,
    capabilities = capabilities,
    filetypes = { "tex", "bib" },
    -- root_dir = vim's starting directory
    settings = {
        texlab = {
            auxDirectory = ".",
            bibtexFormatter = "texlab",
            build = {
                args = { "-pdfxe", "-interaction=nonstopmode", "-synctex=1", "%f" },
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


----------------------------{ GO }---------------------------------------------
nvim_lsp.gopls.setup{
    on_attach = on_attach,
    capabilities = capabilities,
    cmd = { "gopls" },
    filetype = { "go", "gomod", "gotmpl" },
    root_dir = util.root_pattern("go.mod", ".git"),
    single_file_support = true
}


---------------------------{ VIM }---------------------------------------------
nvim_lsp.vimls.setup{
    on_attach = on_attach,
    capabilities = capabilities,
    cmd = { "vim-language-server", "--stdio" },
    filetypes = { "vim" },
    init_options = {
        diagnostic = {
            enable = true
        },
        indexes = {
            count = 3,
            gap = 100,
            projectRootPatterns = {
                "runtime", "nvim", ".git", "autoload", "plugin"
            },
            runtimepath = true
        },
        isNeovim = true,
        iskeyword = "@,48-57,_,192-255,-#",
        runtimepath = "",
        suggest = {
            fromRuntimepath = true,
            fromVimruntime = true
        },
        vimruntime = ""
    },
    -- root_dir = ???,
    single_file_support = true,
}
