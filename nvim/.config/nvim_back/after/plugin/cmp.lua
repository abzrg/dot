local cmp_loaded, cmp = pcall(require, "cmp")
if not cmp_loaded then
  return
end

local luasnip_loaded, luasnip = pcall(require, "luasnip")
if not luasnip_loaded then
  return
end

-- maximum width
-- src: https://github.com/hrsh7th/nvim-cmp/discussions/609#discussioncomment-3395522
local ELLIPSIS_CHAR = '…'
local MAX_LABEL_WIDTH = 25
local MAX_KIND_WIDTH = 14
local get_ws = function(max, len)
  return (" "):rep(max - len)
end


-- Luasnipt config
luasnip.config.set_config {
  history = false,
  updateevents = "TextChanged,TextChangedI",
}
require("luasnip/loaders/from_vscode").lazy_load()


--   פּ ﯟ   some other good icons
-- find more here: https://www.nerdfonts.com/cheat-sheet

-- local kind_icons = {
--   Text = "txt",
--   Method = "mthd",
--   Function = "func",
--   Constructor = "ctor",
--   Field = "field",
--   Variable = "var",
--   Class = "cls",
--   Interface = "interface",
--   Module = "mod",
--   Property = "prop",
--   Unit = "unit",
--   Value = "val",
--   Enum = "enum",
--   Keyword = "kw",
--   Snippet = "snip",
--   Color = "color",
--   File = "file",
--   Reference = "ref",
--   Folder = "folder",
--   EnumMember = "eunmMem",
--   Constant = "const",
--   Struct = "struct",
--   Event = "event",
--   Operator = "op",
--   TypeParameter = "typeParam",
-- }
--

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

-- Used for super tab behavior
local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

-- Setup
cmp.setup {
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },

  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },

  mapping = cmp.mapping.preset.insert({
    ["<C-p>"]     = cmp.mapping.select_prev_item(),
    ["<C-n>"]     = cmp.mapping.select_next_item(),
    ['<C-b>']     = cmp.mapping.scroll_docs(-4),
    ['<C-f>']     = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>']     = cmp.mapping.abort(),
    ['<C-y>']     = cmp.mapping.abort(),
    ['<CR>']      = cmp.mapping.confirm({ select = true }),
    -- ["<Tab>"]     = cmp.mapping(function(fallback)
    --   if cmp.visible() then
    --     cmp.confirm({ select = false })
    --   elseif luasnip.expand_or_jumpable() then
    --     luasnip.expand_or_jump()
    --   elseif has_words_before() then
    --     cmp.complete()
    --   else
    --     fallback()
    --   end
    -- end, { "i", "s" }),
    -- ["<S-Tab>"]   = cmp.mapping(function(fallback)
    --   if cmp.visible() then
    --     cmp.confirm({ select = false })
    --   elseif luasnip.jumpable(-1) then
    --     luasnip.jump(-1)
    --   else
    --     fallback()
    --   end
    -- end, { "i", "s" }),
  }),


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
        -- omni = "[Omni]"
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

  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = "nvim_lua" },
    { name = 'luasnip' },
    { name = "pandoc_references" },
    { name = "cmp_git" },
    -- { name = 'omni', keyword_length = 0 },
    { name = "buffer",           keyword_length = 5 },
    { name = "path" },
  }),

  completion = {
    -- autocomplete = true,
    completeopt = 'menu,menuone,noinsert,select'
  },

  confirm_opts = {
    behavior = cmp.ConfirmBehavior.Replace,
    select = false,
  },
}


-- -- Set configuration for specific filetypes
-- cmp.setup.filetype('gitcommit', {
--   sources = cmp.config.sources({
--     { name = 'cmp_git' },
--   }, {
--     { name = 'buffer' },
--   })
-- })

-- cmp.setup.filetype('markdown', {
--   sources = cmp.config.sources({
--     { name = 'pandoc-references' },
--   }, {
--     { name = 'buffer' },
--   })
-- })

-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
  sources = cmp.config.sources({
    { name = 'git' },   -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
  }, {
    { name = 'buffer' },
  })
})

cmp.setup.cmdline({ '/', '?' }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})


-- Set up lspconfig.
local capabilities = require('cmp_nvim_lsp').default_capabilities()
-- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
require('lspconfig')['clangd'].setup {
  capabilities = capabilities
}
