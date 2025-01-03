-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out,                            "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end

-- Hey! Put lazy into the runtimepath for neovim!
vim.opt.runtimepath:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    {
      "Mofiqul/vscode.nvim",
      opt = {
        transparent = true
      },
      config = function()
        require('vscode').setup({
          style = 'dark',
          transparent = true,
          italic_comments = false,
          underline_links = true,
          disable_nvimtree_bg = true,
        })
        vim.cmd.colorscheme "vscode"
      end
    },
    { import = "config.plugins" },
  },
  change_detection = {
    -- automatically check for config file changes and reload the ui
    enabled = false,
    -- get a notification when changes are found
    notify = false,
  },
})
