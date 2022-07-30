-- Installation: pip3 install cmake-language-server

return {
  cmd = { "cmake-language-server" },
  filetypes = { "cmake" },
  init_options = { buildDirectory = "build" },
  root_dir = require("lspconfig.util").root_pattern(".git", "compile_commands.json", "build")
}
