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

-- CursorHold
    local function lsp_highlight_document(client)
        -- Set autocommands conditional on server_capabilities
        if client.server_capabilities.document_highlight then
            vim.api.nvim_exec([[
            " vscode dark
            hi LspReferenceRead cterm=none ctermbg=darkgrey ctermfg=none
            hi LspReferenceText cterm=none ctermbg=darkgrey ctermfg=none
            hi LspReferenceWrite cterm=none ctermbg=darkgrey ctermfg=none

            " vscode light
            "hi LspReferenceRead cterm=bold ctermbg=red guibg=#d4d4d4
            "hi LspReferenceText cterm=bold ctermbg=red guibg=#d4d4d4
            "hi LspReferenceWrite cterm=bold ctermbg=red guibg=#d4d4d4

            augroup lsp_document_highlight
            autocmd! * <buffer>
            autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
            autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
            augroup END
            ]], false)
        end
    end

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
    local on_attach = function(client, bufnr)
        -- Enable completion triggered by <c-x><c-o>
        vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

        -- enable cursor hold
        lsp_highlight_document(client)

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


                ---------------------- lsp server settings -------------------------

-- --------------------{ TSSERVER LANGUAGE-SERVER }-------------------------------
--
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
--
-- ------------------{ VSCODE HTML LANGUAGE-SERVER }------------------------------
--
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


-- require'lspconfig'.sumneko_lua.setup {
--     capabilities = capabilities,
--     on_attach = on_attach,
--     cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"},
--     settings = {
--         Lua = {
--             runtime = {
--                 -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
--                 version = 'LuaJIT',
--                 -- Setup your lua path
--                 path = vim.split(package.path, ';')
--             },
--             diagnostics = {
--                 -- Get the language server to recognize the `vim` global
--                 globals = {'vim'}
--             },
--             workspace = {
--                 -- Make the server aware of Neovim runtime files
--                 library = {
--                     [vim.fn.expand('$VIMRUNTIME/lua')] = true,
--                     [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true
--                 },
--                 preloadFileSize = 500
--             },
--             -- Do not send telemetry data containing a randomized but unique identifier
--             telemetry = {
--                 enable = false,
--             }
--         }
--     }
-- }


-- ----------------------------{ EMMET LANGUAGE SERVER }--------------------------
--
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
--

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

require'lspconfig'.clangd.setup {
    capabilities = capabilities,
    on_attach = on_attach,
    cmd = {"clangd", "--background-index"},
    filetypes = {"c", "cpp", "objc", "objcpp"},
    -- on_init = function to handle changing offsetEncoding,
    root_dir =
            util.root_pattern("compile_commands.json", "compile_flags.txt", ".git")
        or
            function()
                return vim.loop.cwd()
            end
}


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

require'lspconfig'.pyright.setup {
    -- - PyrightOrganizeImports: Organize Imports
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
                autoSearchPaths = true,
                diagnosticMode = "workspace",
                useLibraryCodeForTypes = true
            }
        }
    }
}


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

require'lspconfig'.texlab.setup{
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



-----------------------------------{ GO }---------------------------------------------

require'lspconfig'.gopls.setup{
    on_attach = on_attach,
    capabilities = capabilities,
    cmd = { "gopls" },
    filetype = { "go", "gomod", "gotmpl" },
    root_dir = util.root_pattern("go.mod", ".git"),
    single_file_support = true
}


----------------------------------{ VIM }---------------------------------------------

require'lspconfig'.vimls.setup{
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
            projectRootPatterns = { "runtime", "nvim", ".git", "autoload", "plugin" },
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
