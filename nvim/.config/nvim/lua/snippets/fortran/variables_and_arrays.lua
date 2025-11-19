local ls = require("luasnip")
local i = ls.insert_node
local fmta = require("luasnip.extras.fmt").fmta
local s = ls.snippet
local rep = require("luasnip.extras").rep

local helpers = require('snippets.snippet_helper')
local get_visual = helpers.get_visual
local line_begin = require("luasnip.extras.expand_conditions").line_begin

return {
  s(
    { trig = "var", name = "Fortran Variable", dscr = "Declare a typed variable" },
    fmta(
      [[
      <> :: <>
      ]],
      {
        i(1, "integer"), -- Type (default: integer)
        i(0, "var_name") -- Variable name
      }
    ),
    {}
  ),
  s(
    { trig = "arr", name = "Fortran Array", dscr = "Declare an array with shape" },
    fmta(
      [[
      <>, dimension(<>) :: <>
      ]],
      {
        i(1, "real"),      -- Type (default: real)
        i(2, "1:10"),      -- Dimensions
        i(0, "array_name") -- Variable name
      }
    ),
    {}
  ),
  s(
    { trig = "darr", name = "Dynamic Array", dscr = "Declare a dynamic allocatable array" },
    fmta(
      [[
      <>, dimension (<>), allocatable :: <>
      ]],
      {
        i(1, "real"),          -- Type
        i(2, ":"),             -- Declaration dimension
        i(0, "dynamic_array"), -- Array name
      }
    ),
    {}
  ),
}
