return {
  'nvim-telescope/telescope.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-lua/popup.nvim'
  },
  lazy = true,
  keys = {
    { "<leader>f", function()
      -- Don't run telescope in Home directory
      local curr_dir = vim.fn.getcwd()
      if curr_dir == vim.fs.normalize("~") then
        print('Telescope in $HOME will be slow. Not running.')
        return
      end

      -- Check if you're in a git repo
      local _, ret = require('telescope.utils').get_os_command_output({
        "git", "rev-parse", "--is-inside-work-tree"
      })

      -- Options for a git repository
      local gitopts = {}
      -- Options for a non-git folders
      local fileopts = {}

      gitopts.prompt_title = "Git Files"
      gitopts.show_untracked = false
      gitopts.file_ignore_patterns = {
        ".git/",
        ".cache/",
        "__pycache__/",
        ".pytest_cache/",
        "tags",
        "build/",
      }

      fileopts.hidden = true
      fileopts.file_ignore_patterns = {
        "__pycache__", "googletest", ".pytest_cache", ".vim/", ".local/", ".cache/",
        "Downloads/", "Movies/", ".git/", "Dropbox/.*", "Library/.*", ".rustup/.*",
        ".cargo/registry/", ".woff", ".woff2", ".ttf", ".otf", "tags", "build/",
        ".metadata/", 'venv/.*',
        "node_modules", "__pycache__", "%.class",                              -- programming languages
        "%.mp4", "%.mkv", "%.webp", "%.png", "%.pdf", "%.eps",                 -- media
        "%.snm", "%.aux", "%.bbl", "%.blg", "%.fdb_latexmk", "%.dtx",          -- tex
        "%.ins", "%.lof", "%.fff", "%.ttt", "%.fls", "%.out", "%.spl", "%.lot" -- tex
      }

      if ret == 0 then
        require('telescope.builtin').git_files(gitopts)
      else
        require('telescope.builtin').find_files(fileopts)
      end
    end },
    { '<leader>rg', '<Cmd>Telescope live_grep<CR>', silent = true, noremap = true },
    { '<leader>F', "<Cmd>Telescope find_files<CR>" },
    { '<leader>b', '<Cmd>lua require"telescope.builtin".buffers({sort_lastused = true})<CR>' },
    { '<leader>h', '<Cmd>Telescope help_tags<CR>' },
    { '<leader>tm', '<Cmd>Telescope man_pages<CR>' },
    { '<leader>tk', '<Cmd>Telescope keymaps<CR>' },
    { '<leader>to', '<Cmd>Telescope oldfiles<CR>' },
    { '<leader>/', '<cmd>Telescope current_buffer_fuzzy_find<cr>' },
  },

  config = function()
    local actions = require('telescope.actions')
    require('telescope').setup {
      defaults = {
        theme = 'dropdown',
        path_display = { 'truncate' },
        color_devicons = true,

        layout_config = {
          prompt_position = 'bottom',
          horizontal = {
            width_padding = 0.04,
            height_padding = 0.1,
            preview_width = 0.6
          },
          vertical = {
            mirror = false,
            width_padding = 0.05,
            height_padding = 1,
            preview_height = 0.5
          }
        },

        file_ignore_patterns = {
          '.git', 'node_modules', 'venv/', '__pycache__', '.cache', 'build', '%.class',
          '%.mp4', '%.mkv', '%.webp', '%.png', '%.pdf', '%.eps', '%.snm', '%.aux',
          '%.bbl', '%.blg', '%.fdb_latexmk', '%.dtx', '%.ins', '%.lof', '%.fff',
          '%.ttt', '%.fls', '%.out', '%.spl', '%.lot'
        },

        vimgrep_arguments = {
          'rg', '--color=never', '--no-heading', '--with-filename',
          '--line-number', '--column', '--smart-case', '--hidden'
        },

        sorting_strategy = 'descending',

        mappings = {
          i = {
            ['<C-j>'] = actions.move_selection_next,
            ['<C-k>'] = actions.move_selection_previous,
          },
          n = {
            ['q'] = actions.close, ['<Esc>'] = actions.close,
          },
        },

        pickers = {
          man_pages = { sections = { '1', '3' } },
        },
      }
    }


    --
    -- Mappings
    --

    -- vim.keymap.set('n', '<leader>f', '<cmd>Telescope find_files<cr>', { silent = true, noremap = true })
    -- vim.keymap.set('n', '<leader>F', "<Cmd>Telescope find_files<CR>")
    -- vim.keymap.set('n', '<leader>rg', '<Cmd>Telescope live_grep<CR>', { silent = true, noremap = true })
    -- vim.keymap.set('n', '<leader>b', '<Cmd>lua require"telescope.builtin".buffers({sort_lastused = true})<CR>')
    -- vim.keymap.set('n', '<leader>h', '<Cmd>Telescope help_tags<CR>')
    -- vim.keymap.set('n', '<leader>tm', '<Cmd>Telescope man_pages<CR>')
    -- vim.keymap.set('n', '<leader>tk', '<Cmd>Telescope keymaps<CR>')
    -- vim.keymap.set('n', '<leader>to', '<Cmd>Telescope oldfiles<CR>')
    -- vim.keymap.set('n', '<leader>/', '<cmd>Telescope current_buffer_fuzzy_find<cr>')

    -- vim.keymap.set('n', '<leader>f', '', {
    --   callback = function()
    --     -- Don't run telescope in Home directory
    --     local curr_dir = vim.fn.getcwd()
    --     if curr_dir == vim.fs.normalize("~") then
    --       print('Telescope in $HOME will be slow. Not running.')
    --       return
    --     end
    --
    --     -- Check if you're in a git repo
    --     local _, ret = require('telescope.utils').get_os_command_output({ "git", "rev-parse",
    --       "--is-inside-work-tree" })
    --
    --     -- Options for a git repository
    --     local gitopts = {}
    --     -- Options for a non-git folders
    --     local fileopts = {}
    --
    --     gitopts.prompt_title = "Git Files"
    --     gitopts.show_untracked = false
    --     gitopts.file_ignore_patterns = {
    --       ".git/",
    --       ".cache/",
    --       "__pycache__/",
    --       ".pytest_cache/",
    --       "tags",
    --       "build/",
    --     }
    --
    --     fileopts.hidden = true
    --     fileopts.file_ignore_patterns = {
    --       "__pycache__", "googletest", ".pytest_cache", ".vim/", ".local/", ".cache/",
    --       "Downloads/", "Movies/", ".git/", "Dropbox/.*", "Library/.*", ".rustup/.*",
    --       ".cargo/registry/", ".woff", ".woff2", ".ttf", ".otf", "tags", "build/",
    --       ".metadata/",
    --       "node_modules", "__pycache__", "%.class",                              -- programming languages
    --       "%.mp4", "%.mkv", "%.webp", "%.png", "%.pdf", "%.eps",                 -- media
    --       "%.snm", "%.aux", "%.bbl", "%.blg", "%.fdb_latexmk", "%.dtx",          -- tex
    --       "%.ins", "%.lof", "%.fff", "%.ttt", "%.fls", "%.out", "%.spl", "%.lot" -- tex
    --     }
    --
    --     if ret == 0 then
    --       require('telescope.builtin').git_files(gitopts)
    --     else
    --       require('telescope.builtin').find_files(fileopts)
    --     end
    --   end
    -- })

  end
}
