local ls = require("luasnip")
local sn = ls.snippet_node
local i = ls.insert_node

local function get_ISO_8601_date()
  return os.date("%Y-%m-%d")
end

local function get_visual(args, parent)
  if (#parent.snippet.env.LS_SELECT_RAW > 0) then
    return sn(nil, i(1, parent.snippet.env.LS_SELECT_RAW))
  else
    return sn(nil, i(1, ''))
  end
end

local line_begin = require("luasnip.extras.expand_conditions").line_begin

-- Math context detection
local tex = {}
tex.in_mathzone = function() return vim.fn['vimtex#syntax#in_mathzone']() == 1 end
tex.in_text = function() return not tex.in_mathzone() end

-- Return snippet tables
return
{
  -- -- ANNOTATE (custom command for annotating equation derivations)
  -- s({ trig = "ann", snippetType = "autosnippet" },
  --   fmta(
  --     [[
  --     \annotate{<>}{<>}
  --     ]],
  --     {
  --       i(1),
  --       d(2, get_visual),
  --     }
  --   )
  -- ),
  -- REFERENCE
  s({ trig = "ref" },
    fmta(
      [[
       ~\ref{<>}
      ]],
      {
        d(1, get_visual),
      }
    )
  ),
  s({ trig = "cref" },
    fmta(
      [[
       ~\cref{<>}
      ]],
      {
        d(1, get_visual),
      }
    )
  ),
  s({ trig = "Cref" },
    fmta(
      [[
       ~\Cref{<>}
      ]],
      {
        d(1, get_visual),
      }
    )
  ),
  -- DOCUMENTCLASS
  s({ trig = "documentclass" },
    fmta(
      [=[
        \documentclass[<>]{<>}
        ]=],
      {
        i(1, "a4paper"),
        i(2, "article"),
      }
    ),
    { condition = line_begin }
  ),
  -- USE A LATEX PACKAGE
  s({ trig = "pack", snippetType = "autosnippet" },
    fmta(
      [[
        \usepackage{<>}
        ]],
      {
        d(1, get_visual),
      }
    ),
    { condition = line_begin }
  ),
  -- INPUT a LaTeX file
  s({ trig = "input" },
    fmta(
      [[
      \input{<>}
      ]],
      {
        i(1)
      }
    ),
    { condition = line_begin }
  ),
  -- LABEL
  s({ trig = "label", priority = 1010 },
    fmta(
      [[
      \label{<>}
      ]],
      {
        d(1, get_visual),
      }
    )
  ),
  -- HPHANTOM
  s({ trig = "hphantom", priority = 100 },
    fmta(
      [[
      \hphantom{<>}
      ]],
      {
        d(1, get_visual),
      }
    )
  ),
  s({ trig = "TODOO", snippetType = "autosnippet" },
    fmta(
      [[\TODO{<>}]],
      {
        d(1, get_visual),
      }
    )
  ),
  s({ trig = "newcommand" },
    fmta(
      [[\newcommand{<>}{<>}]],
      {
        i(1),
        i(2)
      }
    ),
    { condition = line_begin }
  ),
  s({ trig = "si", dscr = "SI Unit" },
    fmta(
      [[\si{<>}]],
      {
        i(1),
      }
    )
  ),
  s({ trig = "qty", dscr = "SI Quantity: Value Unit" },
    fmta(
      [[\qty{<>}{<>}]],
      {
        i(1),
        i(2)
      }
    )
  ),
  -- URL
  s({ trig = "url" },
    fmta(
      [[\url{<>}]],
      {
        d(1, get_visual),
      }
    )
  ),
  -- href command with URL in visual selection
  s({ trig = "href" },
    fmta(
      [[\href{<>}{<>}]],
      {
        i(1),
        i(2)
      }
    )
  ),
  -- HSPACE
  s({ trig = "hspace", priority = 100 },
    fmta(
      [[\hspace{<>}]],
      {
        d(1, get_visual),
      }
    )
  ),
  -- VSPACE
  s({ trig = "vspace" },
    fmta(
      [[\vspace{<>}]],
      {
        d(1, get_visual),
      }
    )
  ),
  -- SECTION
  s({ trig = "section" },
    fmta(
      [[\section{<>}]],
      {
        d(1, get_visual),
      }
    )
  ),
  -- SUBSECTION
  s({ trig = "subsection" },
    fmta(
      [[\subsection{<>}]],
      {
        d(1, get_visual),
      }
    )
  ),
  -- SUBSUBSECTION
  s({ trig = "subsubsection" },
    fmta(
      [[\subsubsection{<>}]],
      {
        d(1, get_visual),
      }
    )
  ),
}
