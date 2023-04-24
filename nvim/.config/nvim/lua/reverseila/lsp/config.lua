local servers = {
  --[[
    server name,     executable name
  --]]
  { "rust_analyzer", "rust-analyzer" }, -- It has it's own plugin
  { "jsonls",        "vscode-json-language-server" },
  { "pyright",       "pyright-langserver" },
  { "clangd",        "clangd" },
  { "lua_ls",        "lua-language-server" },
  { "texlab",        "texlab" },
  { "gopls",         "gopls" },
  { "tsserver",      "typescript-language-server" },
  { "html",          "vscode-html-language-server" },
  { "cssls",         "vscode-css-language-server" },
  { "emmet_ls",      "emmet-ls" },
  { "bashls",        "bash-language-server" },
  { "cmake",         "cmake-language-server" },
  { "vimls",         "vim-language-server" },
  { "jdtls",         "jdtls" },
}

for _, server in pairs(servers) do
  local server_name = server[1]
  local server_exec = server[2]

  -- Check if server is installed, if not continue
  if vim.fn.executable(server_exec) ~= 1 then
    goto skip_to_next
  end

  local opts = {
    on_attach = require("reverseila/lsp/handlers").on_attach,
    capabilities = require("reverseila.lsp.handlers").capabilities,
  }
  local has_custom_opts, server_custom_opts = pcall(require, "reverseila.lsp.settings." .. server_name)
  if has_custom_opts then
    opts = vim.tbl_deep_extend("force", opts, server_custom_opts)
  end
  require('lspconfig')[server_name].setup(opts)

  ::skip_to_next::
end
