-- Some niceties
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
  -- Manage yourself!
  use "wbthomason/packer.nvim"


  -- LSP Configuration & Plugins
  use {
    "neovim/nvim-lspconfig",
    requires = {
      -- Useful status updates for LSP
      "j-hui/fidget.nvim",
    },
  }


  -- Auto-Completion
  use { -- Autocompletion
    "hrsh7th/nvim-cmp",
    requires = {
      "hrsh7th/cmp-nvim-lsp", -- vim-cmp source for neovim builtin LSP client
      "hrsh7th/cmp-nvim-lua", -- nvim-cmp source for nvim lua
      "hrsh7th/cmp-buffer", -- nvim-cmp source for buffer words
      "hrsh7th/cmp-path", -- nvim-cmp source for path
      "hrsh7th/cmp-omni", -- nvim-cmp source for omnifunc
      "petertriho/cmp-git", -- Git source for nvim-cmp
      "jc-doyle/cmp-pandoc-references", -- Completion for bibliography, reference and cross-ref items

      "L3MON4D3/LuaSnip", -- Snippet
      "saadparwaiz1/cmp_luasnip",
      "rafamadriz/friendly-snippets", -- Extra snippets

      "onsails/lspkind.nvim", -- vscode-like pictograms for neovim lsp completion items
      "folke/tokyonight.nvim",
    },
  }


  -- Treesitter
  use { -- Highlight, edit, and navigate code
    "nvim-treesitter/nvim-treesitter",
    run = function()
      pcall(require("nvim-treesitter.install").update { with_sync = true })
    end,
    requires = {
      "RRethy/nvim-treesitter-endwise",
      { "nvim-treesitter/nvim-treesitter-textobjects", after = "nvim-treesitter" },
      "nvim-treesitter/playground"
    }
  }


  -- Telescope (Find, Filter, Preview, Pick)
  use {
    "nvim-telescope/telescope.nvim",
    requires = {
      "nvim-lua/plenary.nvim",
      "nvim-lua/popup.nvim"
    }
  }
  -- File Browser extension for telescope.nvim
  use "nvim-telescope/telescope-file-browser.nvim"
  -- Fuzzy Finder Algorithm which requires local dependencies to be built. Only load if `make` is available
  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make', cond = vim.fn.executable 'make' == 1 }


  -- Git integration
  use "tpope/vim-fugitive" -- A Git wrapper so awesome, it should be illegal
  use "lewis6991/gitsigns.nvim" -- Git integration for buffers


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
  use "Mofiqul/vscode.nvim" -- Theme inspired by visual studio code
  use "numToStr/Comment.nvim" -- "gc" to comment visual regions/lines
  use "ethanholz/nvim-lastplace"
  use "christoomey/vim-tmux-navigator" -- Seamless navigation between tmux panes and vim panes
  use "rhysd/committia.vim" -- Split screen with details for better commit
  use "ironhouzi/starlite-nvim" -- better * and # that don't jump immediately
  use "nacro90/numb.nvim" -- peeks lines of the buffer in non-obtrusive way
  use "norcalli/nvim-colorizer.lua" -- colorize the buffer
  use "nanotee/nvim-lua-guide" -- lua guide for neovim
  use "rhysd/clever-f.vim" -- clever f instead of the dumb default
  use "folke/zen-mode.nvim"
  use "folke/twilight.nvim"
  use { "akinsho/bufferline.nvim", tag = "v3.*", requires = "nvim-tree/nvim-web-devicons" }
  use { "pboettch/vim-cmake-syntax" } -- Vim syntax highlighting rules for modern CMake.
  use "tartansandal/vim-compiler-pytest"
  use "lukas-reineke/indent-blankline.nvim"

  -- test
  use "projekt0n/github-nvim-theme"
  use "rose-pine/neovim"
  use 'navarasu/onedark.nvim'
  use 'shaunsingh/nord.nvim'

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
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
