-- local kind_icons = {
--   Text = '󰉿',
--   Method = '󰊕',
--   Function = '󰊕',
--   Constructor = '󰒓',
--
--   Field = '󰜢',
--   Variable = '󰆦',
--   Property = '󰖷',
--
--   Class = '󱡠',
--   Interface = '󱡠',
--   Struct = '󱡠',
--   Module = '󰅩',
--
--   Unit = '󰪚',
--   Value = '󰦨',
--   Enum = '󰦨',
--   EnumMember = '󰦨',
--
--   Keyword = '󰻾',
--   Constant = '󰏿',
--
--   Snippet = '󱄽',
--   Color = '󰏘',
--   File = '󰈔',
--   Reference = '󰬲',
--   Folder = '󰉋',
--   Event = '󱐋',
--   Operator = '󰪚',
--   TypeParameter = '󰬛',
-- }
--
-- return {
--   {
--     'hrsh7th/nvim-cmp',
--     dependencies = {
--       'hrsh7th/cmp-nvim-lsp',
--       'hrsh7th/cmp-nvim-lua',
--       'hrsh7th/cmp-buffer',
--       'hrsh7th/cmp-path',
--       'hrsh7th/cmp-cmdline',
--       'hrsh7th/cmp-nvim-lsp-signature-help',
--       'L3MON4D3/LuaSnip',
--       'saadparwaiz1/cmp_luasnip',
--       { 'p00f/clangd_extensions.nvim', lazy = true, }
--     },
--
--
--     config = function()
--       local cmp_autopairs = require('nvim-autopairs.completion.cmp')
--       local cmp = require('cmp')
--       cmp.event:on(
--         'confirm_done',
--         cmp_autopairs.on_confirm_done()
--       )
--
--       local ELLIPSIS_CHAR = '…'
--       local MAX_LABEL_WIDTH = 25
--
--       local get_ws = function(max, len)
--         return (" "):rep(max - len)
--       end
--
--       local cmp = require 'cmp'
--       local luasnip = require 'luasnip'
--
--       cmp.setup {
--         snippet = {
--           expand = function(args)
--             luasnip.lsp_expand(args.body)
--           end,
--         },
--
--         window = {
--           completion = cmp.config.window.bordered(),
--           documentation = cmp.config.window.bordered(),
--         },
--
--         mapping = cmp.mapping.preset.insert {
--           ['<C-n>']     = cmp.mapping(cmp.mapping.select_next_item(), { 'i' }),
--           ['<C-p>']     = cmp.mapping(cmp.mapping.select_prev_item(), { 'i' }),
--           ['<C-d>']     = cmp.mapping.scroll_docs(-4),
--           ['<C-e>']     = cmp.mapping.abort(),
--           ['jk']        = cmp.mapping.abort(),
--           ['<C-f>']     = cmp.mapping.scroll_docs(4),
--           ['<C-Space>'] = cmp.mapping.complete {},
--           ['<CR>']      = cmp.mapping.confirm {
--             behavior = cmp.ConfirmBehavior.Replace,
--             select = true,
--           },
--           ['<Tab>']     = cmp.mapping(function(fallback)
--             if cmp.visible() then
--               cmp.select_next_item()
--             elseif luasnip.expand_or_locally_jumpable() then
--               luasnip.expand_or_jump()
--             else
--               fallback()
--             end
--           end, { 'i', 's' }),
--           ['<S-Tab>']   = cmp.mapping(function(fallback)
--             if cmp.visible() then
--               cmp.select_prev_item()
--             elseif luasnip.locally_jumpable(-1) then
--               luasnip.jump(-1)
--             else
--               fallback()
--             end
--           end, { 'i', 's' }),
--         },
--
--         sorting = {
--           comparators = {
--             cmp.config.compare.offset,
--             cmp.config.compare.exact,
--             cmp.config.compare.recently_used,
--             require("clangd_extensions.cmp_scores"),
--             cmp.config.compare.kind,
--             cmp.config.compare.sort_text,
--             cmp.config.compare.length,
--             cmp.config.compare.order,
--           },
--         },
--
--         formatting = {
--           fields = { "kind","abbr",  "menu" },
--           format = function(entry, vim_item)
--             local content = vim_item.abbr
--             vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
--             vim_item.menu = ({
--               luasnip =  "[Snp]",
--               nvim_lua = "[Nvm]",
--               nvim_lsp = "[Lsp]",
--               pandoc_references = "[Ref]",
--               cmp_git = "[Git]",
--               buffer = "[Buf]",
--               path = "[Pth]",
--             })[entry.source.name]
--
--             if #content > MAX_LABEL_WIDTH then
--               vim_item.abbr = vim.fn.strcharpart(content, 0, MAX_LABEL_WIDTH) .. ELLIPSIS_CHAR
--             else
--               vim_item.abbr = content .. get_ws(MAX_LABEL_WIDTH, #content)
--             end
--
--             return vim_item
--           end,
--         },
--
--         sources = {
--           { name = 'nvim_lsp' },
--           { name = 'nvim_lsp_signature_help' },
--           { name = 'luasnip' },
--           { name = "nvim_lua" },
--           { name = "buffer",                 keyword_length = 5 },
--           { name = "path" },
--         },
--
--         autocomplete = true,
--         completeopt = 'menu,menuone,noinsert,select',
--       }
--
--       cmp.setup.filetype('gitcommit', {
--         sources = cmp.config.sources({
--           { name = 'git' },
--         }, {
--           { name = 'buffer' },
--         })
--       })
--     end,
--   },
--   {
--     'L3MON4D3/LuaSnip',
--     config = function()
--       local luasnip = require 'luasnip'
--       require('luasnip.loaders.from_vscode').lazy_load()
--
--       luasnip.config.set_config {
--         history = true,
--         updateevents = "TextChanged,TextChangedI",
--         enable_autosnippets = true,
--         store_selection_keys = "<Tab>",
--       }
--
--       require("luasnip.loaders.from_lua").lazy_load({
--         paths = vim.fn.stdpath("config") .. "/lua/config/snippets"
--       })
--     end
--   },
-- }


return {
  {
    'saghen/blink.cmp',
    dependencies = { 'L3MON4D3/LuaSnip', },
    event = { "InsertEnter", }, -- "CmdLineEnter"
    version = 'v0.*',
    build = 'cargo build --release',
    opts = {
      fuzzy = {
        prebuilt_binaries = {
          download = false,
        }
      },
      appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = 'mono'
      },

      snippets = {
        expand = function(snippet) require('luasnip').lsp_expand(snippet) end,
        active = function(filter)
          if filter and filter.direction then
            return require('luasnip').jumpable(filter.direction)
          end
          return require('luasnip').in_snippet()
        end,
        jump = function(direction) require('luasnip').jump(direction) end,
      },

      completion = {
        -- 'foo_|_bar' will match 'foo_' for 'prefix' and 'foo__bar' for 'full'
        keyword = { range = 'full', },

        -- Insert completion item on selection, don't select by default
        list = { selection = 'auto_insert' },

        -- Show documentation when selecting a completion item
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 0,
          -- window = {
          --   border = "rounded",
          -- }

        },

        -- Display a preview of the selected item on the current line
        ghost_text = { enabled = true },

        menu = {
          -- border = "rounded",
          -- winhighlight = "Normal:Normal",
          -- draw = {
          --   columns = { { 'kind_icon' }, { 'label' } },
          -- }
        },

        trigger = {
          show_on_insert_on_trigger_character = false,
        },

        accept = { auto_brackets = { enabled = true } },
      },

      sources = {
        default = { 'lsp', 'path', 'luasnip', 'buffer' },

        providers = {
          buffer = {
            min_keyword_length = 5,
          }
        },

        -- Disable cmdline completions
        cmdline = {},
      },

      signature = { enabled = true },

      keymap = {
        preset = "enter",
        ["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
        ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
        [","] = { 'hide', 'fallback' },
      },
    },
  },

  {
    'L3MON4D3/LuaSnip',
    config = function()
      local luasnip = require 'luasnip'
      require('luasnip.loaders.from_vscode').lazy_load()

      luasnip.config.set_config {
        history = true,
        updateevents = "TextChanged,TextChangedI",
        enable_autosnippets = true,
        store_selection_keys = "<Tab>",
      }

      require("luasnip.loaders.from_lua").lazy_load({
        paths = vim.fn.stdpath("config") .. "/lua/config/snippets"
      })
    end
  },
}
