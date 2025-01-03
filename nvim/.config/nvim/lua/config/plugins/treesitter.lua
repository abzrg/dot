-- return {
--   {
--     "nvim-treesitter/nvim-treesitter",
--     build = ":TSUpdate",
--     config = function()
--       require 'nvim-treesitter.configs'.setup {
--         ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline" },
--         auto_install = false,
--         highlight = {
--           enable = true,
--           disable = function(lang, buf)
--             local max_filesize = 100 * 1024 -- 100 KB
--             local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
--             if ok and stats and stats.size > max_filesize then
--               return true
--             end
--           end,
--           additional_vim_regex_highlighting = false,
--         },
--       }
--     end,
--   }
-- }


return {
  'nvim-treesitter/nvim-treesitter',

  dependencies = {
    'JoosepAlviste/nvim-ts-context-commentstring',
    'RRethy/nvim-treesitter-endwise',
    'windwp/nvim-ts-autotag',
    'nvim-treesitter/nvim-treesitter-context',
    'nvim-treesitter/nvim-treesitter-textobjects',
  },

  config = function()
    -- local treesitter_parsers = require('nvim-treesitter.parsers')
    --
    -- if treesitter_parsers.has_parser "cpp" then
    --   local folds_query = [[
    --     [
    --       (function_definition)
    --       (class_specifier)
    --     ] @fold
    --   ]]
    --
    --   require("vim.treesitter.query").set("cpp", "folds", folds_query)
    -- end

    -- if treesitter_parsers.has_parser "python" then
    --   local folds_query = [[
    --     [
    --       (function_definition)
    --     ] @fold
    --   ]]
    --   require("vim.treesitter.query").set("python", "folds", folds_query)
    -- end


    -- context_commentstring nvim-treesitter module is deprecated, use
    -- require('ts_context_commentstring').setup {} and set
    -- vim.g.skip_ts_context_commentstring_module = true to speed up loading
    -- instead. stack traceback:

    -- context commentstring (for html template languages)
    require('ts_context_commentstring').setup {}
    vim.g.skip_ts_context_commentstring_module = true

    -- sticky thing!
    require 'treesitter-context'.setup {
      enable = true,           -- Enable this plugin (Can be enabled/disabled later via commands)
      max_lines = 3,           -- How many lines the window should span. Values <= 0 mean no limit.
      min_window_height = 0,   -- Minimum editor window height to enable context. Values <= 0 mean no limit.
      line_numbers = true,
      multiline_threshold = 1, -- Maximum number of lines to show for a single context
      trim_scope = 'outer',    -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
      mode = 'cursor',         -- Line used to calculate context. Choices: 'cursor', 'topline'
      -- Separator between context and content. Should be a single character string, like '-'.
      -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
      separator = nil,
      zindex = 20,     -- The Z-index of the context window
      on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
    }

    -- treesitter
    require('nvim-treesitter.configs').setup {
      ensure_installed = { 'c', 'cpp', 'lua', 'python', 'comment', 'go', 'rust', 'vim', 'bash' },

      -- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
      auto_install = false,

      -- highlight = {
      --   -- disable = function(lang, bufnr) -- Disable in large C++ buffers
      --   --     return lang == "cpp" and vim.api.nvim_buf_line_count(bufnr) > 1000
      --   -- end,
      -- },

      highlight = {
        -- disable = { "c", "cpp" }
        enable = true,
        disable = function(lang, buf)
          if lang == "cpp" or lang == "c" then
            return true
          end
          local max_filesize = 100 * 1024 -- 100 KB
          local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
          if ok and stats and stats.size > max_filesize then
            return true
          end
        end,
        additional_vim_regex_highlighting = false,
      },

      indent = { enable = true, },


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
