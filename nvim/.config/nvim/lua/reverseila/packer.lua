-- Install packer
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup({ function()
  use "wbthomason/packer.nvim"


  -- LSP Configuration & Plugins
  use { "neovim/nvim-lspconfig", }


  -- Auto-Completion
  use { -- Autocompletion
    "hrsh7th/nvim-cmp",
    requires = {
      "hrsh7th/cmp-nvim-lsp", -- vim-cmp source for neovim builtin LSP client
      "hrsh7th/cmp-nvim-lua", -- nvim-cmp source for nvim lua
      "hrsh7th/cmp-buffer", -- nvim-cmp source for buffer words
      "hrsh7th/cmp-path", -- nvim-cmp source for path
      "L3MON4D3/LuaSnip", -- Snippet
      "saadparwaiz1/cmp_luasnip",
      "rafamadriz/friendly-snippets", -- Extra snippets
      "onsails/lspkind.nvim", -- vscode-like pictograms for neovim lsp completion items
    },
  }


  -- Telescope (Find, Filter, Preview, Pick)
  use {
    "nvim-telescope/telescope.nvim",
    requires = {
      "nvim-lua/plenary.nvim",
      "nvim-lua/popup.nvim"
    }
  }
  -- Fuzzy Finder Algorithm which requires local dependencies to be built. Only load if `make` is available
  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make', cond = vim.fn.executable 'make' == 1 }


  -- Git integration
  use { "tpope/vim-fugitive" }


  -- Tim Pope
  use "tpope/vim-surround" -- Delete/change/add parentheses/quotes/XML-tags/much more with ease
  use "tpope/vim-repeat" -- Enable repeating supported plugin maps with "."
  use "tpope/vim-unimpaired" -- Pairs of handy bracket mappings
  use "tpope/vim-rsi" -- Readline style insertion
  use { "tpope/vim-dispatch", -- Asynchronous build and test dispatcher
    opt = true,
    cmd = { "Dispatch", "Make", "Focus", "Start" }
  }


  -- Misc.
  use "windwp/nvim-autopairs" -- A super powerful autopair plugin for Neovim that supports multiple characters.
  use "numToStr/Comment.nvim" -- "gc" to comment visual regions/lines
  use "Mofiqul/vscode.nvim" -- Theme inspired by visual studio code
  use "ethanholz/nvim-lastplace"
  use "christoomey/vim-tmux-navigator" -- Seamless navigation between tmux panes and vim panes
  use "rhysd/committia.vim" -- Split screen with details for better commit
  use "ironhouzi/starlite-nvim" -- better * and # that don't jump immediately
  use "nacro90/numb.nvim" -- peeks lines of the buffer in non-obtrusive way
  use { -- colorize the buffer
    "norcalli/nvim-colorizer.lua",
    opt = true,
    cmd = {
      "ColorizerAttachToBuffer",
      "ColorizerDetachFromBuffer",
      "ColorizerReloadAllBuffers",
      "ColorizerToggle"
    }

  }
  use "rhysd/clever-f.vim" -- clever f instead of the dumb default
  use { "folke/zen-mode.nvim", opt = true, cmd = { "ZenMode" } }
  use { "folke/twilight.nvim", opt = true, cmd = { "Twilight" } }
  if packer_bootstrap then
    require('packer').sync()
  end
end,
  config = {
    display = {
      open_fn = function()
        return require("packer.util").float({ border = "rounded" })
      end
    }
  }
})
