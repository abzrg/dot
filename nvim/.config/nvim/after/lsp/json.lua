return {
  cmd = { "vscode-json-language-server", "--stdio" },
  filetypes = { "json", "jsonrc" },
  root_markers = { ".git" },
  init_options = {
    provideFormatter = true,
  },
}
