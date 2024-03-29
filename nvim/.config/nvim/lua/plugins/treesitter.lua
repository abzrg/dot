return {
  'nvim-treesitter/nvim-treesitter',

  dependencies = {
    'JoosepAlviste/nvim-ts-context-commentstring',
    'RRethy/nvim-treesitter-endwise',
    'windwp/nvim-ts-autotag',
  },

  config = function()
    -- context_commentstring nvim-treesitter module is deprecated, use
    -- require('ts_context_commentstring').setup {} and set
    -- vim.g.skip_ts_context_commentstring_module = true to speed up loading
    -- instead. stack traceback:

    require('ts_context_commentstring').setup {}
    vim.g.skip_ts_context_commentstring_module = true

    require('nvim-treesitter.configs').setup {
      ensure_installed = { 'c', 'cpp', 'lua', 'python', 'comment', 'go', 'rust', 'vimdoc', 'vim', 'bash' },

      -- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
      auto_install = false,

      highlight = { enable = true, },
      indent = { enable = false, },

      --
      -- Plugins
      --

      endwise = { enable = true, },

      autotag = {
        enable = true,
        filetypes = { 'html', 'htmldjango', 'javascript', 'typescript',
          'javascriptreact', 'typescriptreact', 'svelte', 'vue', 'tsx', 'jsx',
          'rescript', 'xml', 'php', 'markdown', 'astro', 'glimmer', 'handlebars',
          'hbs' },
        skip_tags = { 'area', 'base', 'br', 'col', 'command', 'embed', 'hr', 'img',
          'slot', 'input', 'keygen', 'link', 'meta', 'param', 'source', 'track',
          'wbr', 'menuitem', 'option' },
      },

      -- context_commentstring = { enable = true, }, -- deprecated

      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = '<c-space>',
          node_incremental = '<c-space>',
          scope_incremental = '<c-s>',
          node_decremental = '<M-space>',
        },
      },

      textobjects = {
        select = {
          enable = true,
          lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
          keymaps = {
            -- You can use the capture groups defined in textobjects.scm
            ['aa'] = '@parameter.outer',
            ['ia'] = '@parameter.inner',
            ['af'] = '@function.outer',
            ['if'] = '@function.inner',
            ['ac'] = '@class.outer',
            ['ic'] = '@class.inner',
          },
        },
        move = {
          enable = true,
          set_jumps = true, -- whether to set jumps in the jumplist
          goto_next_start = {
            [']m'] = '@function.outer',
            [']]'] = '@class.outer',
          },
          goto_next_end = {
            [']M'] = '@function.outer',
            [']['] = '@class.outer',
          },
          goto_previous_start = {
            ['[m'] = '@function.outer',
            ['[['] = '@class.outer',
          },
          goto_previous_end = {
            ['[M'] = '@function.outer',
            ['[]'] = '@class.outer',
          },
        },
        swap = {
          enable = true,
          swap_next = {
            ['<leader>a'] = '@parameter.inner',
          },
          swap_previous = {
            ['<leader>A'] = '@parameter.inner',
          },
        },
      },

    }
  end
}
