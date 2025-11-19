local helpers = require('snippets.snippet_helper')
local get_visual = helpers.get_visual

local line_begin = require("luasnip.extras.expand_conditions").line_begin

return
{
  -- PRINTF
  s({ trig = "cout" },
    fmta(
      [[std::cout <<<< <> <<<< std::endl;]],
      {
        i(1)
      }
    ),
    { condition = line_begin }
  ),
  s({ trig = "cerr" },
    fmta(
      [[std::cerr <<<< <> <<<< std::endl;]],
      {
        i(1)
      }
    ),
    { condition = line_begin }
  ),
  s({ trig = "cin" },
    fmta(
      [[std::cin >>>> <>;]],
      {
        i(1)
      }
    ),
    { condition = line_begin }
  ),
  -- -- GETLINE BOILERPLATE
  -- s({ trig = "gll", snippetType = "autosnippet" },
  --   fmta(
  --     [[
  --     char *line = NULL;
  --     size_t len = 0;
  --     ssize_t nread;
  --     nread = getline(&line, &len, stdin);
  --     <>
  --     free(line);
  --     ]],
  --     { i(0) }
  --   )
  -- ),
}
