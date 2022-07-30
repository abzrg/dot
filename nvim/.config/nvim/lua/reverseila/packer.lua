-- Some niceties
local execute = vim.api.nvim_command
local fn = vim.fn

-- If it's the first time, download packer and install it
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({
        "git", "clone", "https://github.com/wbthomason/packer.nvim", install_path
    })
    execute "packadd packer.nvim"
end

-- Check packer is installed and proceed
local status_ok, packer = pcall(require, "packer")
if not status_ok then
    return
end


-- [ Plugins ] --------------------------------

return packer.startup({function()
    use "wbthomason/packer.nvim"

    -- Colorscheme
    use "folke/tokyonight.nvim"
    -- use 'martinsione/darkplus.nvim'
    use "LunarVim/darkplus.nvim"

    -- Comment
    use "numToStr/Comment.nvim"

    -- Tim Pope
    use "tpope/vim-surround"  -- Delete/change/add parentheses/quotes/XML-tags/much more with ease
    use "tpope/vim-repeat"  -- Enable repeating supported plugin maps with "."
    use "tpope/vim-unimpaired"  -- Pairs of handy bracket mappings
    use "tpope/vim-rsi"  -- Readline style insertion
    use { "tpope/vim-dispatch",  -- Asynchronous build and test dispatcher
        opt = true,
        cmd = { "Dispatch", "Make", "Focus", "Start" }
    }

    -- LSP
    use "neovim/nvim-lspconfig"  -- Quickstart configs for Nvim LSP
    use "onsails/lspkind.nvim"
    use "RRethy/vim-illuminate"  -- Automatically highlighting other uses of the word under the cursor

    -- Treesitter
    use "nvim-treesitter/nvim-treesitter"  -- Treesitter configurations and abstraction layer for Neovim.
    use "RRethy/nvim-treesitter-endwise"  -- Wisely add "end" in Ruby, Vimscript, Lua, etc. Tree-sitter aware alternative to tpope's vim-endwise


    -- Telescope
    use "nvim-lua/popup.nvim"  -- Dependency for Telescope
    use "nvim-lua/plenary.nvim"  -- Dependency for Telescope
    use "nvim-telescope/telescope.nvim"  -- Find, Filter, Preview, Pick. All lua, all the time.
    use "nvim-telescope/telescope-file-browser.nvim"  -- File Browser extension for telescope.nvim
    use "kyazdani42/nvim-web-devicons"  -- Lua `fork` of vim-web-devicons for neovim


    -- Git integration
    use "tpope/vim-fugitive"  -- A Git wrapper so awesome, it should be illegal
    use "lewis6991/gitsigns.nvim"  -- Git integration for buffers


    -- Auto-Completion
    use "hrsh7th/nvim-cmp"  -- A completion plugin for neovim coded in Lua.
    use "hrsh7th/cmp-buffer"  -- nvim-cmp source for buffer words
    use "hrsh7th/cmp-path"  -- nvim-cmp source for path
    use "hrsh7th/cmp-nvim-lsp"  -- vim-cmp source for neovim builtin LSP client
    use "hrsh7th/cmp-nvim-lua"  -- nvim-cmp source for nvim lua
    use "hrsh7th/cmp-omni"  -- nvim-cmp source for omnifunc
    use "petertriho/cmp-git"  -- Git source for nvim-cmp


    -- Snippet
    use "L3MON4D3/LuaSnip"
    use "saadparwaiz1/cmp_luasnip"
    use "rafamadriz/friendly-snippets"


    -- Auto-Pair
    use "windwp/nvim-autopairs"  -- A super powerful autopair plugin for Neovim that supports multiple characters.


    -- Misc.
    use "ethanholz/nvim-lastplace"
    use "christoomey/vim-tmux-navigator"  -- Seamless navigation between tmux panes and vim panes
    use "rhysd/committia.vim"  -- Split screen with details for better commit
    use "ironhouzi/starlite-nvim"  -- better * and # that don't jump immediately
    use "nacro90/numb.nvim"  -- peeks lines of the buffer in non-obtrusive way
    use "norcalli/nvim-colorizer.lua"  -- colorize the buffer
    use "nanotee/nvim-lua-guide"  -- lua guide for neovim
    -- use  "lervag/vim-foam"  -- vim filetype plugin for syntax highlighting of openfoam DSL
    -- use  "rhysd/clever-f.vim"  -- clever f instead of the dumb default

end,
config = {
    display = {
        open_fn = function()
            return require('packer.util').float({ border = 'rounded' })
        end
    }
}
})
