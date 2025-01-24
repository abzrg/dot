-- Disable editorconfig right away
vim.b.editorconfig = false

-- Enable the following settings after neovim has been loaded.
-- This is done because otherwise neovim will overwrite them.
-- Another way to achieve this is to set up autocommands but this is enough.
vim.defer_fn(function()
  vim.opt_local.colorcolumn = "50,72"

  -- https://tbaggery.com/2008/04/19/a-note-about-git-commit-messages.html
  vim.bo.textwidth = 72
  vim.bo.tabstop = 2
  vim.bo.shiftwidth = 2

  vim.opt_local.formatoptions = {
    c = false, -- Auto-wrap comments using 'textwidth'
    l = true,  -- Auto-wrap long lines in insert mode
    q = false, -- Allow formatting of comments with "gq"
    t = true,  -- Auto-wrap text using 'textwidth'
    n = true,  -- Recognize numbered lists.
    j = true,  -- Remove a comment leader when joining
  }
end, 1)

-- Enable spell checking
vim.opt_local.spell = true
vim.opt_local.spellcapcheck = ""

-- Wrap text
vim.opt_local.wrap = true
-- Wrap long lines (visually) at 'breakat'
vim.opt_local.linebreak = true

-- We don't need line numbers
vim.opt_local.number = false
vim.opt_local.relativenumber = false

-- ...Nor we do signcolumns
vim.opt_local.signcolumn = "no"

-- If the git commit message buffer is not displayed then delete the buffer so that we
-- don't save the incomplet git message by mistake.
vim.opt_local.bufhidden = "delete"
