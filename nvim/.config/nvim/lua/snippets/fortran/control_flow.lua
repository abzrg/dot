local ls = require("luasnip")
local i = ls.insert_node
local fmta = require("luasnip.extras.fmt").fmta
local s = ls.snippet
local rep = require("luasnip.extras").rep

local helpers = require('snippets.snippet_helper')
local get_visual = helpers.get_visual
local line_begin = require("luasnip.extras.expand_conditions").line_begin

return {
  -- IF
  s({ trig = "iff", snippetType = "autosnippet" },
    fmta(
      [[
      if (<>) then
        <>
      end if<>
      ]],
      {
        i(1),
        i(2),
        i(0)
      }
    ),
    {}
  ),
  -- IF with Label
  s({ trig = "ifl", snippetType = "autosnippet" },
    fmta(
      [[
      <>: if (<>) then
        <>
      end if <><>
      ]],
      {
        i(1, "label"),
        i(2),
        i(3),
        rep(1),
        i(0)
      }
    ),
    {}
  ),
  -- DO LOOP
  s({ trig = "doo", snippetType = "autosnippet" },
    fmta(
      [[
      do <> = <>
        <>
      end do<>
      ]],
      {
        i(1, "n"),
        i(2, "1, 10"),
        i(3),
        i(0)
      }
    ),
    { condition = line_begin }
  ),
  -- DO LOOP Label
  s({ trig = "dol", snippetType = "autosnippet" },
    fmta(
      [[
      <>: do <> = <>
        <>
      end do <><>
      ]],
      {
        i(1, "label"),
        i(2, "n"),
        i(3, "1, 10"),
        i(4),
        rep(1),
        i(0)
      }
    ),
    { condition = line_begin }
  ),
  -- DO WHILE LOOP
  s({ trig = "dww", snippetType = "autosnippet" },
    fmta(
      [[
      do while (<>)
        <>
      end do<>
      ]],
      {
        i(1),
        i(2),
        i(0)
      }
    ),
    { condition = line_begin }
  ),
  -- DO WHILE LOOP LABEL
  s({ trig = "dwl", snippetType = "autosnippet" },
    fmta(
      [[
      <>: do while (<>)
        <>
      end do <><>
      ]],
      {
        i(1, "label"),
        i(2),
        i(3),
        rep(1),
        i(0)
      }
    ),
    { condition = line_begin }
  ),
}
