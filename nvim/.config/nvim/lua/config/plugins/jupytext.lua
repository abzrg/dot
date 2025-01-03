return {
  'goerz/jupytext.nvim',
  config = function()
    require("jupytext").setup {
      jupytext = 'jupytext',
      format = "markdown",
      update = true,
      filetype = require("jupytext").get_filetype,
      new_template = require("jupytext").default_new_template(),
      sync_patterns = { '*.md', '*.py', '*.jl', '*.R', '*.Rmd', '*.qmd' },
      autosync = true,
    }
  end
}
