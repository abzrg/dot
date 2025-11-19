return {
    cmd = { 'lua-language-server' },
    filetypes = { 'lua' },
    root_markers = {
        '.luarc.json',
        '.luarc.jsonc',
        '.stylua.toml',
        'stylua.toml',
        '.git',
    },
    -- https://github.com/disrupted/dotfiles/blob/.config/nvim/lsp/lua_ls.lua
    settings = {
        Lua = {
            completion = {
                callSnippet = 'Replace',
            },
            workspace = { checkThirdParty = false },
            codeLens = { enable = true },
            telemetry = { enable = false },
            doc = { privateName = { '^_' } },
            diagnostics = {
                unusedLocalExclude = { '_*' },
                -- disable = { "missing-parameters", "missing-fields" }
            },
            format = { enable = true },
            hint = {
                enable = true,
                setType = false,
                paramType = true,
                arrayIndex = 'Disable',
            },
        },
    },
}
