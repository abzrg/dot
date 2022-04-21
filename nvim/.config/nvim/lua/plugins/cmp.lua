vim.opt.completeopt = { "menu", "menuone", "noselect" }

-- load nvim-cmp.
local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
  return
end

-- load luasnip
local snip_status_ok, luasnip = pcall(require, "luasnip")
if not snip_status_ok then
  return
end

-- load lspkind
local kind_status_ok, lspkind = pcall(require, "lspkind")
if not kind_status_ok then
  return
end
lspkind.init()


cmp.setup({
    view = {
        entries = 'native'
    },

    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
      end,
    },

    window = {
      -- completion = cmp.config.window.bordered(),
      -- documentation = cmp.config.window.bordered(),
    },

    mapping = cmp.mapping.preset.insert({
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),

        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),

        -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
        --['<CR>'] = cmp.mapping.confirm { behavior = cmp.ConfirmBehavior.Insert, select = true, },

        ['<C-k>'] = cmp.mapping.select_prev_item(),
        ['<C-j>'] = cmp.mapping.select_next_item(),

        --['<c-q>'] = cmp.mapping.confirm { behavior = cmp.ConfirmBehavior.Replace, select = true, },

        ['<Tab>'] = cmp.mapping(function(fallback)
            if luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
            if luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { 'i', 's' }),
    }),

    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = "nvim_lua" },
        { name = 'luasnip' }, -- For luasnip users.
        --{ name = 'copilot' },
        { name = "path" },
        { name = 'omni', keyword_length = 0 },
        { name = "buffer", keyword_length = 5 },
    }),

    sorting = {
        comparators = {
            cmp.config.compare.offset,
            cmp.config.compare.exact,
            cmp.config.compare.score,

            -- copied from cmp-under, but I don't think I need the plugin for this.
            -- I might add some more of my own.
            function(entry1, entry2)
                local _, entry1_under = entry1.completion_item.label:find "^_+"
                local _, entry2_under = entry2.completion_item.label:find "^_+"
                entry1_under = entry1_under or 0
                entry2_under = entry2_under or 0
                if entry1_under > entry2_under then
                    return false
                elseif entry1_under < entry2_under then
                    return true
                end
            end,

            cmp.config.compare.kind,
            cmp.config.compare.sort_text,
            cmp.config.compare.length,
            cmp.config.compare.order,
        },
    },

    formatting = {
        format = lspkind.cmp_format {
            with_text = true,
            maxwidth = 30,
            menu = {
                buffer   = "[buf]",
                nvim_lsp = "[LSP]",
                nvim_lua = "[api]",
                path     = "[path]",
                luasnip  = "[snip]",
                -- gh_issues = "[issues]",
            },
        },
    },

    experimental = {
        -- Let's play with this for a day or two
        -- ghost_text = false
        ghost_text = {
            enable = false,
            hl_group = {"whitespace"}
        }
    },

})

-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
sources = cmp.config.sources({
  { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
}, {
  { name = 'buffer' },
})
})

-- -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
-- cmp.setup.cmdline('/', {
-- mapping = cmp.mapping.preset.cmdline(),
-- sources = {
--   { name = 'buffer' }
-- }
-- })

-- -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
-- cmp.setup.cmdline(':', {
-- mapping = cmp.mapping.preset.cmdline(),
-- sources = cmp.config.sources({
--   { name = 'path' }
-- }, {
--   { name = 'cmdline' }
-- })
-- })

-- Highlighting gourps
vim.cmd([[
    " hi link CmpItemAbbr Comment
    " hi link CmpItemAbbrDeprecated Error
    " hi link CmpItemAbbrMatchFuzzy MoreMsg
    " hi link CmpItemKind Special
    " hi link CmpItemMenu LineNr
    highlight! link CmpItemAbbr Pmenu
    highlight! link CmpItemKind Pmenu
    highlight! link CmpItemMenu Pmenu
]])
