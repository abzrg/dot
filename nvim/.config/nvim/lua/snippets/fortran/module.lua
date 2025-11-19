local ls = require("luasnip")
local i = ls.insert_node
local fmta = require("luasnip.extras.fmt").fmta
local s = ls.snippet
local rep = require("luasnip.extras").rep

local line_begin = require("luasnip.extras.expand_conditions").line_begin



return
{
  -- PROGRAM
  -- s({ trig = "program", name = "Fortran Program", dscr = "Fortran program boilerplate" },
  s({ trig = "prg", snippetType = "autosnippet" },
    fmta(
      [[
      program <>
        use iso_fortran_env
        implicit none

        <>

      end program <>
      ]],
      {
        i(1, "main"),
        i(0),
        rep(1)
      }
    ),
    { condition = line_begin }
  ),
  -- s({ trig = "module", name = "Fortran Module", dscr = "Fortran module boilerplate" },
  s({ trig = "modd", snippetType = "autosnippet" },
    fmta(
      [[
      module <>
        use iso_fortran_env
        implicit none

        <>

      contains

      ! Your procedures go here

      end module <>
      ]],
      {
        i(1, "module"),
        i(0),
        rep(1)
      }
    ),
    { condition = line_begin }
  ),
}
