-- Installation: brew install lua-language-server

-- return {
--   cmd = { "lua-language-server" };
--   settings = {
--     Lua = {
--       runtime = {
--         version = "LuaJIT",
--       },
--       diagnostics = {
--         -- Get the language server to recognize the `vim` global
--       },
--       workspace = {
--         -- Make the server aware of Neovim runtime files
--         -- library = vim.api.nvim_get_runtime_file("", true),
--         library = {
--           [vim.fn.expand("$VIMRUNTIME/lua")] = true,
--           [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
--         }
--       },
--       telemetry = {
--         enable = false,
--       },
--     },
--   },
-- }
--
return {
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {"vim", "use", "root"},
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
