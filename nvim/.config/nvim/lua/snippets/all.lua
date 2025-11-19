---@diagnostic disable: unused-local

local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local d = ls.dynamic_node
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local rep = require("luasnip.extras").rep

return {
    s({ trig = "ddate", snippetType = "autosnippet", regTrig = true, wordTrig = false, hidden = true }, {
        f(function()
            local result = io.popen("date +'%d/%m/%Y %a'"):read("*a")
            return result:gsub("\n", "") -- Remove trailing newline
        end, {})
    }),

    s("rdate", t(os.date("%Y/%m/%d"))),
    s("date", t(os.date("%d/%m/%Y"))),
    s("usdate", t(os.date("%m/%d/%Y"))),
}
