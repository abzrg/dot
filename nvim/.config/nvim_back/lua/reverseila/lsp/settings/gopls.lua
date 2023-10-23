-- Installation: go install golang.org/x/tools/gopls@latest

return {
  cmd = { "gopls" },
  filetype = { "go", "gomod", "gotmpl" },
  root_dir = require("lspconfig.util").root_pattern("go.mod", ".git"),
  single_file_support = true
}
