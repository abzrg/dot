-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#html
-- Installation: npm i -g vscode-langservers-extracted

return {
  cmd = { "vscode-html-language-server", "--stdio" },
  filetypes = { "html" },
  init_options = {
    configurationSection = {
      "html",
      "css",
      "javascript"
    },
    embeddedLanguages = {
      css = true,
      javascript = true
    },
  },
  -- root_dir = function(fname)
  --   return require("lspconfig.util")(fname) or vim.loop.os_homedir()
  -- end,
  settings = {},
  single_file_support = true,
}
