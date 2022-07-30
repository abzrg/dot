-- Installation: npm i -g typescript typescript-language-server

return {
  cmd = {"typescript-language-server", "--stdio"},
  filetypes = {
    "javascript", "javascriptreact", "javascript.jsx", "typescript",
    "typescriptreact", "typescript.tsx"
  },
  init_options = {hostInfo = "neovim"},
  root_dir = require("lspconfig.util").root_pattern("package.json", "tsconfig.json", ".git", ".js",
  vim.loop.cwd())
}
