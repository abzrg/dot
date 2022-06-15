local luasnip = require "luasnip"
luasnip.config.set_config {
  history = true,
  updateevents = "TextChanged,TextChangedI",
}
-- luasnip.

luasnip.filetype_extend("latex", {})

-- lsp specification on snippet syntax:
-- https://microsoft.github.io/language-server-protocol/specification#snippet_syntax



-- source: https://github.com/L3MON4D3/LuaSnip/blob/72323c10fe2d91695f7593e572496ab9f004afee/Examples/snippets.lua#L263-L274
-- Also look at: https://old.reddit.com/r/neovim/comments/qilze2/luasnip_friendly_snippets_configuration/

--[[
-- Beside defining your own snippets you can also load snippets from "vscode-like" packages
-- that expose snippets in json files, for example <https://github.com/rafamadriz/friendly-snippets>.
-- Mind that this will extend  `ls.snippets` so you need to do it after your own snippets or you
-- will need to extend the table yourself instead of setting a new one.
]]

-- require("luasnip/loaders/from_vscode").load({ include = { "python" } }) -- Load only python snippets
-- require("luasnip/loaders/from_vscode").load({ paths = { "./my-snippets" } }) -- Load snippets from my-snippets folder

-- You can also use lazy loading so you only get in memory snippets of languages you use
require("luasnip/loaders/from_vscode").lazy_load() -- You can pass { path = "./my-snippets/"} as well
