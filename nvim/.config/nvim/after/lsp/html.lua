return {
  cmd = { "vscode-html-language-server", "--stdio" },
  filetypes = { "html", "templ", "htmldjango" },
  root_markers = { "package.json", ".git" },
  init_options = {
    provideFormatter = true,
    configurationSection = { "html", "css", "javascript" },
    embeddedLanguages = { css = true, javascript = true },
  },
  settings = {
    html = {
      hover = {
        documentation = true,
        references = true,
      },
    },
  },
  single_file_support = true,
}
