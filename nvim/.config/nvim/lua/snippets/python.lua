local helpers = require('snippets.snippet_helper')
local get_visual = helpers.get_visual

return {
  -- '; ' -> ': '
  s(
    { trig = "; ", wordTrig = false, snippetType = "autosnippet" },
    fmta(
      "<>",
      {
        t(": "), -- Text node for the replacement
      }
    )
  ),
}
