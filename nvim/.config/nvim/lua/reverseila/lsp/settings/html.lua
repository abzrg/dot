-- Installation: npm install --global vscode-html-languageserver-bin

return {
  cmd = {"html-languageserver", "--stdio"},
  filetypes = {"html"},
  init_options = {
    configurationSection = {"html", "css", "javascript"},
    embeddedLanguages = {css = true, javascript = true}
  },
  root_dir = function(fname)
    return require("lspconfig.util")(fname) or vim.loop.os_homedir()
  end,
  settings = {},
}
