-- Installation: Your os package manager has it

local clangd_flags = {
  "--fallback-style=google",
  "--background-index",
  "-j=12",
  "--all-scopes-completion",
  "--pch-storage=disk",
  "--clang-tidy",
  "--log=error",
  "--completion-style=detailed",
  "--header-insertion=iwyu",
  "--header-insertion-decorators",
  "--enable-config",
  "--offset-encoding=utf-16",
  "--ranking-model=heuristics",
  "--folding-ranges",
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
