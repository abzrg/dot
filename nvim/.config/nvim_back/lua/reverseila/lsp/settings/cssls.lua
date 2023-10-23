-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#cssls
-- Installation: npm i -g vscode-langservers-extracted

local util = require("lspconfig.util")

return {
  cmd = { "vscode-css-language-server", "--stdio" },
  filetypes = { "css", "scss", "less" },
  root_dir = function(fname)
    local root_files = {
      'package.json', '.git', 'styles.css'
    }
    return util.root_pattern(unpack(root_files))(fname) or
        util.find_git_ancestor(fname) or util.path.dirname(fname)
  end,
  settings = {
    css = {
      validate = true
    },
    less = {
      validate = true
    },
    scss = {
      validate = true
    }
  },
  single_file_support = true,
}
