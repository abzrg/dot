-- Installation: Your os package manager has it

local clangd_flags = {
  "--fallback-style=google",
  "--all-scopes-completion",
  "--log=error",
  "--completion-style=detailed",
  "--header-insertion=iwyu",
  "--header-insertion-decorators",
  "--enable-config",
  "--offset-encoding=utf-16",
  "--ranking-model=heuristics",
  "--folding-ranges",
  "--clang-tidy",
  "-j=12",
  "--limit-references=100",
  "--limit-results=20",
  "--background-index",
  "--pch-storage=memory",
}

local clangd_bin = "clangd"

return {
  cmd = { clangd_bin, unpack(clangd_flags) },
  filetypes = { "c", "cpp", "objc", "objcpp" },
  root_dir =
  require("lspconfig.util").root_pattern("compile_commands.json", "compile_flags.txt", ".git")
  or
  function()
    return vim.loop.cwd()
  end
}
