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

    -- telescope
    use { 'nvim-lua/popup.nvim' }
    use { 'nvim-lua/plenary.nvim' }
    use { 'nvim-telescope/telescope.nvim', config = [[ require('plugins/telescope') ]] }
    use { 'nvim-telescope/telescope-file-browser.nvim' }
    use { 'LinArcX/telescope-env.nvim', config = [[ require('telescope').load_extension('env') ]] }

    -- -- simple and fast auto complete for (n)vim
    -- use { 'lifepillar/vim-mucomplete' }

    -- autopair
    use { 'windwp/nvim-autopairs', config = [[ require('plugins/autopairs') ]] }

    -- fuzzy finder and ...
    use { 'junegunn/fzf',
        dir = '~/.local/share/nvim/site/pack/packer/start/fzf/install',
        run = './install --all'
    }
    use { 'junegunn/fzf.vim'}

    -- timpope --
        -- use { 'tpope/vim-commentary', config = [[ require('plugins/vim-commentary') ]] } -- replaced with comment.nvim

        -- git integration for vim (i don't use it often, but maybe someday)
        use { 'tpope/vim-fugitive', config = [[ require('plugins/vim-fugitive') ]] }

        -- readline bindings (C-a, C-e, C-u, C-k) in command/insert mode and
        use { 'tpope/vim-rsi' }

        -- add repeatablity to surround, commenting, ...
        use { 'tpope/vim-repeat' }

        -- surround them with brackets easily
        use { 'tpope/vim-surround' }

        -- unix commands in command mode (Delete, Unlink, Move, ...)
        use { 'tpope/vim-eunuch' }

        -- end constructs like for, if, while in languages like ruby, vim, lua, etc
        use { 'tpope/vim-endwise' }

        -- better compilation
        use { 'tpope/vim-dispatch', opt = true, cmd = { 'Dispatch', 'Make', 'Focus', 'Start' } }

        -- -- statusline for vim
        -- use { 'tpope/vim-flagship', config = [[ vim.cmd('let g:tablabel=""') ]] }

        -- increment date/time intelligently
        use { 'tpope/vim-speeddating' }

    -- misc --

        -- comment
        use { 'numToStr/Comment.nvim', config = function() require('Comment').setup() end }

        -- easier nested marked folding facility
        use { 'dbmrq/vim-chalk' }

        -- auto correct misspelling in my notes
        use { 'panozzaj/vim-autocorrect', config = [[ vim.cmd('autocmd BufReadPost ~/Documents/notes/* call AutoCorrect()') ]] }

        -- seamless navigation between tmux panes and vim panes
        use { 'christoomey/vim-tmux-navigator', config = [[ require("plugins/vim-tmux-navigator") ]] }

        -- open files from cli like this: nvim file:linenumber
        use { 'wsdjeg/vim-fetch' }

        -- change in next brackets while you are not on it. cinn[
        use { 'wellle/targets.vim' }

        -- split screen with details for better commit
        use { 'rhysd/committia.vim', config = [[ require('plugins/committia') ]] }

        -- clever f instead of the dumb default
        use { 'rhysd/clever-f.vim' }

        -- better * and # that don't jump immediately
        use { 'ironhouzi/starlite-nvim', config = [[ require('plugins/starlite') ]] }

        -- peeks lines of the buffer in non-obtrusive way
        use { 'nacro90/numb.nvim', config = [[ require('plugins/numb') ]] }

        -- read chet sheet within vim (does not seem to work)
        use { 'reverseila/vim-cheat' }

        -- -- Git integration for buffers (show what has changed, removed, added,...)
        -- use { 'lewis6991/gitsigns.nvim', config = [[ require('plugins/gitsigns') ]] }

        -- -- colorize the buffer
        -- use { 'norcalli/nvim-colorizer.lua', config = [[ require('plugins/colorizer') ]] }

        -- vim filetype plugin for syntax highlighting of openfoam DSL
        use { 'lervag/vim-foam'}

        -- a good markdown preview plugins
        use { 'iamcco/markdown-preview.nvim',
          opt = true, cmd = { 'MarkdownPreview', },
          run = function() vim.fn['mkdp#util#install']() end, ft = { 'markdown' }
        }

        -- focus editing
        use { 'folke/zen-mode.nvim', config = [[ require('plugins/zen-mode') ]] }
        use { 'folke/twilight.nvim' }

        -- highlight match under cursor different from other matches
        use { 'adamheins/vim-highlight-match-under-cursor' }
end,

config = {
  display = {
    open_fn = function()
      return require('packer.util').float({ border = 'rounded' })
    end
  }
}

})
