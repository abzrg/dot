local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup({
  function()
    use 'wbthomason/packer.nvim'

    use { 'neovim/nvim-lspconfig', requires = { 'folke/neodev.nvim' }, }

    -- use {
    --   'nvim-treesitter/nvim-treesitter',
    --   requires = {
    --     'RRethy/nvim-treesitter-endwise',
    --     'windwp/nvim-ts-autotag',
    --     'JoosepAlviste/nvim-ts-context-commentstring',
    --   },
    -- }

    use {
      'hrsh7th/nvim-cmp',
      requires = {
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-nvim-lua',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-path',
        'L3MON4D3/LuaSnip',
        'saadparwaiz1/cmp_luasnip',
        'rafamadriz/friendly-snippets',
      },
    }

    use {
      'nvim-telescope/telescope.nvim',
      requires = {
        'nvim-lua/plenary.nvim',
        'nvim-lua/popup.nvim'
      }
    }
    use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make', cond = vim.fn.executable 'make' == 1 }

    use 'lewis6991/gitsigns.nvim'
    use 'tpope/vim-fugitive'
    use 'tpope/vim-surround'
    use 'tpope/vim-endwise'
    use 'tpope/vim-sleuth'
    use 'tpope/vim-repeat'
    use 'tpope/vim-unimpaired'
    use 'tpope/vim-rsi'
    use { 'tpope/vim-dispatch', opt = true, cmd = { 'Dispatch', 'Make', 'Focus', 'Start' } }

    use 'windwp/nvim-autopairs'
    use 'numToStr/Comment.nvim'
    use { 'stevearc/oil.nvim', requires = { 'nvim-tree/nvim-web-devicons' } }
    use 'ethanholz/nvim-lastplace'
    use 'christoomey/vim-tmux-navigator'
    use 'rhysd/committia.vim'
    use 'ironhouzi/starlite-nvim'
    use 'nacro90/numb.nvim'
    use 'NvChad/nvim-colorizer.lua'
    use 'rhysd/clever-f.vim'
    use { 'folke/zen-mode.nvim', opt = true, cmd = { 'ZenMode' } }
    use { 'folke/twilight.nvim', opt = true, cmd = { 'Twilight' } }
    use 'simrat39/symbols-outline.nvim'

    use 'Mofiqul/vscode.nvim'

    if packer_bootstrap then
      require('packer').sync()
    end
  end,

  config = {
    display = {
      open_fn = function()
        return require('packer.util').float({ border = 'rounded' })
      end
    },

    -- Changing compile_path from plugin/packer_compiled.lua to data directory
    compile_path = vim.fn.stdpath 'data' .. '/site/pack/loader/start/packer.nvim/plugin/packer.lua',
  }

})
