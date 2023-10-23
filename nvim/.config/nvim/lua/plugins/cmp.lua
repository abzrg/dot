-- find more here: https://www.nerdfonts.com/cheat-sheet
local kind_icons = {
  Text = "",
  Method = "m",
  Function = "",
  Constructor = "",
  Field = "",
  Variable = "",
  Class = "",
  Interface = "",
  Module = "",
  Property = "",
  Unit = "",
  Value = "",
  Enum = "",
  Keyword = "",
  Snippet = "",
  Color = "",
  File = "",
  Reference = "",
  Folder = "",
  EnumMember = "",
  Constant = "",
  Struct = "",
  Event = "",
  Operator = "",
  TypeParameter = "",
}

return {
  'hrsh7th/nvim-cmp',

  dependencies = {
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-nvim-lua',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-cmdline',
    'L3MON4D3/LuaSnip',
    'saadparwaiz1/cmp_luasnip',
    'rafamadriz/friendly-snippets',
  },

  config = function()
    local cmp = require 'cmp'
    local luasnip = require 'luasnip'
    require('luasnip.loaders.from_vscode').lazy_load()
    luasnip.config.set_config {
      history = false,
      updateevents = "TextChanged,TextChangedI",
    }

    -- maximum width
    -- src: https://github.com/hrsh7th/nvim-cmp/discussions/609#discussioncomment-3395522
    local ELLIPSIS_CHAR = '…'
    local MAX_LABEL_WIDTH = 25
    -- local MAX_KIND_WIDTH = 14

    local get_ws = function(max, len)
      return (" "):rep(max - len)
    end


    ---@diagnostic disable-next-line missing-fields
    cmp.setup {
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },

      window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      },

      mapping = cmp.mapping.preset.insert {
        -- ['<C-n>']     = 'Nop',
        -- ['<C-p>']     = 'Nop',

        ['<C-n>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i' }),
        ['<C-p>'] = cmp.mapping(cmp.mapping.select_prev_item(), { 'i' }),

        -- ['<C-p>'] = cmp.mapping({
        --   i = cmp.mapping.select_prev_item(),
        --   c = function(fallback)
        --     fallback()
        --   end
        -- }),

        -- ['<C-n>'] = cmp.mapping({
        --   i = cmp.mapping.select_next_item(),
        --   c = function(fallback)
        --     fallback()
        --   end
        -- }),





        ['<C-d>']     = cmp.mapping.scroll_docs(-4),
        ['<C-e>']     = cmp.mapping.abort(),
        ['<C-f>']     = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete {},
        ['<CR>']      = cmp.mapping.confirm {
          behavior = cmp.ConfirmBehavior.Replace,
          select = false,
        },
        ['<Tab>']     = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.expand_or_locally_jumpable() then
            luasnip.expand_or_jump()
          else
            fallback()
          end
        end, { 'i', 's' }),
        ['<S-Tab>']   = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.locally_jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { 'i', 's' }),
      },

      ---@diagnostic disable-next-line missing-fields
      sorting = {
        comparators = {
          cmp.config.compare.offset,
          cmp.config.compare.exact,
          cmp.config.compare.recently_used,
          require("clangd_extensions.cmp_scores"),
          cmp.config.compare.kind,
          cmp.config.compare.sort_text,
          cmp.config.compare.length,
          cmp.config.compare.order,
        },
      },

      ---@diagnostic disable-next-line missing-fields
      formatting = {
        fields = { "abbr", "kind", "menu" },
        format = function(entry, vim_item)
          local content = vim_item.abbr
          vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
          vim_item.menu = ({
            luasnip = "[Snippet]",
            nvim_lua = "[NvLua]",
            nvim_lsp = "[LSP]",
            pandoc_references = "[Ref]",
            cmp_git = "[Git]",
            buffer = "[Buffer]",
            path = "[Path]",
          })[entry.source.name]

          -- maximum width
          -- src: https://github.com/hrsh7th/nvim-cmp/discussions/609#discussioncomment-3395522
          if #content > MAX_LABEL_WIDTH then
            vim_item.abbr = vim.fn.strcharpart(content, 0, MAX_LABEL_WIDTH) .. ELLIPSIS_CHAR
          else
            vim_item.abbr = content .. get_ws(MAX_LABEL_WIDTH, #content)
          end

          return vim_item
        end,
      },

      sources = {
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
        { name = "nvim_lua" },
        { name = "buffer" --[[,  keyword_length = 5]] },
        { name = "path" },
      },

      autocomplete = true,
      completeopt = 'menu,menuone,noinsert,select',
    }


    -- Set configuration for specific filetype.
    ---@diagnostic disable-next-line missing-fields
    cmp.setup.filetype('gitcommit', {
      sources = cmp.config.sources({
        { name = 'git' }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
      }, {
        { name = 'buffer' },
      })
    })

    -- ---@diagnostic disable-next-line missing-fields
    -- cmp.setup.cmdline({ '/', '?' }, {
    --   mapping = cmp.mapping.preset.cmdline(),
    --   sources = {
    --     {
    --       name = 'buffer',
    --       option = { }
    --     }
    --   }
    -- })

    -- -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
    -- ---@diagnostic disable-next-line missing-fields
    -- cmp.setup.cmdline(':', {
    --   mapping = cmp.mapping.preset.cmdline(),
    --   sources = cmp.config.sources({
    --     { name = 'path' }
    --   }, {
    --     {
    --       name = 'cmdline',
    --       option = {
    --         ignore_cmds = { "Man", "!", "q", "w" },
    --       },
    --     }
    --   }, {
    --     name = 'buffer'
    --   })
    -- })

  end
}
