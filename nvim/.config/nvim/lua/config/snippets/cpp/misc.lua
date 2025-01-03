local helpers = require('config.snippets.snippet_helper')
local get_visual = helpers.get_visual

return {
  -- Expand ;; to ::
  s(
    { trig = ";;", wordTrig = false, snippetType = "autosnippet" }, -- Trigger is ;;, not constrained to word boundaries
    fmta(
      "<>",
      {
        t("::"), -- Text node for the replacement
      }
    )
  ),

  -- Expand ,, to <<
  s(
    { trig = ",,", wordTrig = false, snippetType = "autosnippet" }, -- Trigger is ;;, not constrained to word boundaries
    fmta(
      "<>",
      {
        t("<<"), -- Text node for the replacement
      }
    )
  ),

  -- Expand ,. to >>
  s(
    { trig = ",.", wordTrig = false, snippetType = "autosnippet" }, -- Trigger is ;;, not constrained to word boundaries
    fmta(
      "<>",
      {
        t(">>"), -- Text node for the replacement
      }
    )
  ),
}
