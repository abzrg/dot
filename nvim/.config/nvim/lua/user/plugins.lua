local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({
    'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path
  })
  execute 'packadd packer.nvim'
end

local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

packer.startup({function()
  -- Your plugins here
end,})

return packer.startup({function(use)
    -- packer itself
    use { 'wbthomason/packer.nvim' }

    -- lsp
    use { 'neovim/nvim-lspconfig', config = [[ require('plugins/lspconfig') ]] }

    -- treesitter
    use { 'nvim-treesitter/playground' }
    use { 'nvim-treesitter/nvim-treesitter', config = [[ require('plugins/treesitter') ]] }
    use { 'windwp/nvim-ts-autotag',
        opt = true,
        event = {
          'FileType html', 'FileType javascript', 'FileType jsx', 'FileType xml'
        },
        config = [[ require('plugins/ts-autotag') ]]
    }

    -- telescope
    use { 'nvim-lua/popup.nvim' }
    use { 'nvim-lua/plenary.nvim' }
    use { 'nvim-telescope/telescope.nvim', config = [[ require('plugins/telescope') ]] }
    use { "nvim-telescope/telescope-file-browser.nvim" }

    -- autocomplete
    use { 'hrsh7th/nvim-cmp', config = [[ require('plugins/nvim-cmp') ]] }
    use { 'hrsh7th/cmp-nvim-lsp' }
    use { 'hrsh7th/cmp-nvim-lua' }
    use { 'hrsh7th/cmp-buffer' }
    use { 'hrsh7th/cmp-path' }
    use { 'hrsh7th/cmp-omni' }
    use { 'hrsh7th/cmp-copilot' }

    -- snippet
    use { 'L3MON4D3/LuaSnip', config = [[ require('plugins/luasnip') ]] }
    use { 'saadparwaiz1/cmp_luasnip' }
    use { 'rafamadriz/friendly-snippets' }

    -- autopair
    use { 'windwp/nvim-autopairs', config = [[ require('plugins/autopairs') ]] }

    -- statusline
    use { 'nvim-lualine/lualine.nvim',
        requires = {'kyazdani42/nvim-web-devicons', opt = true},
        config = [[ require('plugins/lualine')]]
    }

    -- fuzzy finder and ...
    use {'junegunn/fzf', dir = '~/.local/share/nvim/site/pack/packer/start/fzf/install', run = './install --all' }
    use {'junegunn/fzf.vim'}

    -- Comment
    use { 'numToStr/Comment.nvim', config = function() require('Comment').setup() end }

    -- timpope
    -- use { 'tpope/vim-commentary', config = [[ require('plugins/vim-commentary') ]] }
    use { 'tpope/vim-fugitive', config = [[ require('plugins/vim-fugitive') ]] }
    use { 'tpope/vim-rhubarb' }
    use { 'tpope/vim-rsi' }
    use { 'tpope/vim-repeat' }
    use { 'tpope/vim-surround' }
    use { 'tpope/vim-eunuch' }
    use { 'tpope/vim-scriptease' }
    -- use { 'github/copilot.vim' }
    use { 'tpope/vim-dispatch', opt = true, cmd = { 'Dispatch', 'Make', 'Focus', 'Start' } }
    -- use { 'tpope/vim-flagship', config = [[ vim.cmd('let g:tablabel=""') ]] }

    -- Themes
    use { "morhetz/gruvbox" }

    -- misc
    use { 'dbmrq/vim-chalk' }
    use { 'panozzaj/vim-autocorrect', config = [[
        vim.cmd('autocmd BufReadPost ~/Documents/notes/* call AutoCorrect()')
    ]] }
    use { 'christoomey/vim-tmux-navigator', config = [[ require("plugins/vim-tmux-navigator") ]] }
    use { 'wsdjeg/vim-fetch' }
    use { 'wellle/targets.vim' }
    use { 'rhysd/committia.vim', config = [[ require('plugins/committia') ]] }
    use { 'rhysd/clever-f.vim' }
    use { 'ironhouzi/starlite-nvim', config = [[ require('plugins/starlite') ]] }
    use { 'nacro90/numb.nvim', config = [[ require('plugins/numb') ]] }
    use { 'reverseila/vim-cheat' }
    use { 'lewis6991/gitsigns.nvim', config = [[ require('plugins/gitsigns') ]] }
    use { 'jceb/vim-hier' }
    use { 'norcalli/nvim-colorizer.lua', config = [[ require('plugins/colorizer') ]] }
    use { 'lervag/vim-foam'}
    use { 'iamcco/markdown-preview.nvim',
      opt = true, cmd = { 'MarkdownPreview', },
      run = function() vim.fn['mkdp#util#install']() end, ft = { 'markdown' }
    }
    use { "folke/zen-mode.nvim", config = function() require("zen-mode").setup { } end }
    use { "ThePrimeagen/harpoon" }
end,

config = {
  display = {
    open_fn = function()
      return require('packer.util').float({ border = 'rounded' })
    end
  }
}

})
