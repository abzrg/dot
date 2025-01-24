return {
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    dependencies = {
      'nvim-lua/plenary.nvim',
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' }
    },
    config = function()
      require('telescope').setup {
        pickers = {
          find_files = {
            theme = "ivy"
          },

          live_grep = {
            theme = "ivy"
          }
        },
        extensions = {
          fzf = {}
        }
      }

      require('telescope').load_extension('fzf')

      -- vim.keymap.set("n", "<space>h", require('telescope.builtin').help_tags)
      -- vim.keymap.set("n", "<space>fd", require('telescope.builtin').find_files)

      -- Edit (n)eovim files
      vim.keymap.set("n", "<space>en", function()
        require('telescope.builtin').find_files {
          cwd = vim.fn.stdpath("config")
        }
      end)

      -- Edit (p)lugin files
      vim.keymap.set("n", "<space>ep", function()
        require('telescope.builtin').find_files {
          cwd = vim.fs.joinpath(vim.fn.stdpath("data"), "lazy")
        }
      end)

      -- Grep (rg)
      vim.keymap.set('n', '<leader>rg', "<Cmd>Telescope live_grep<CR>",
        { silent = true, noremap = true })

      -- require "config.telescope.multigrep".setup()
    end
  }
}
