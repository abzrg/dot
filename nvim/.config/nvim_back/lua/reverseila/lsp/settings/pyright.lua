-- Installation: pip install pyright
-- Does not support code formatting

local util = require("lspconfig.util")

return {
  cmd = { "pyright-langserver", "--stdio" },
  filetypes = { "python" },
  root_dir = function(fname)
    local root_files = {
      'pyproject.toml',
      'setup.py',
      'setup.cfg',
      'requirements.txt',
      'requirements-dev.txt',
      'Pipfile',
      'pyrightconfig.json'
    }
    return require('lspconfig.util').root_pattern(unpack(root_files))(fname) or
         require('lspconfig.util').find_git_ancestor(fname) or require('lspconfig.util').path.dirname(fname)
  end,
  settings = {
    python = {
      analysis = {
        typeCheckingMode = "basic", -- off, basic, strict
        autoSearchPaths = true,
        diagnosticMode = "workspace",
        useLibraryCodeForTypes = true,
        reportMissingTypeStubs = "none",
        single_file_support = true
      },
    }
  }
}
