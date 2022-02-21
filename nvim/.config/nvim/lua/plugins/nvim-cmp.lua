vim.opt.completeopt = { "menu", "menuone", "noselect" }
-- Don't show the dumb matching stuff.
vim.opt.shortmess:append "c"

local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
  return
end

local snip_status_ok, luasnip = pcall(require, "luasnip")
if not snip_status_ok then
  return
end

--local lspkind = require "lspkind"
--spkind.init()

cmp.setup {
    -- completion = {
    --     autocomplete = true
    -- },
    mapping = {
        ["<C-k>"] = cmp.mapping.select_prev_item(),
        ["<C-j>"] = cmp.mapping.select_next_item(),
        ["<C-d>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-e>"] = cmp.mapping.close(),
        ["<CR>"] = cmp.mapping.confirm { behavior = cmp.ConfirmBehavior.Insert, select = true, },
        ["<c-q>"] = cmp.mapping.confirm { behavior = cmp.ConfirmBehavior.Replace, select = true, },
        ["<c-space>"] = cmp.mapping.complete(),
        ["<Tab>"] = cmp.mapping(function(fallback)
            if luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { "i", "s" }),
    },

    -- the order of your sources matter (by default). That gives them priority
    -- you can configure:
    -- - keyword_length
    -- - priority
    -- - max_item_count
    -- - (more?)
    sources = {
        -- Could enable this only for lua, but nvim_lua handles that already.
        { name = 'copilot' },
        { name = "nvim_lua" },
        { name = "nvim_lsp" },
        { name = "path" },
        { name = "luasnip" },
        { name = 'omni', keyword_length = 0 },
        { name = "buffer", keyword_length = 5 },
    },

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

    snippet = {
        expand = function(args)
            require("luasnip").lsp_expand(args.body)
        end,
    },

    -- formatting = {
    --     format = lspkind.cmp_format {
    --         with_text = true,
    --         maxwidth = 30,
    --         menu = {
    --             buffer   = "[buf]",
    --             nvim_lsp = "[LSP]",
    --             nvim_lua = "[api]",
    --             path     = "[path]",
    --             luasnip  = "[snip]",
    --             -- gh_issues = "[issues]",
    --         },
    --     },
    -- },

    experimental = {
        -- Let's play with this for a day or two
        -- ghost_text = false
        ghost_text = {
            enable = false,
            hl_group = {"whitespace"}
        }
    },

    documentation = {
        border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
    }
}

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
