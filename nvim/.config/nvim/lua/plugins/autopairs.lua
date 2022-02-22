-- local status, autopairs = pcall(require, "nvim-autopairs")
-- if (not status) then
--     return
-- end
-- local Rule = require("nvim-autopairs.rule")

-- autopairs.setup({ map_cr = true })
-- autopairs.add_rule(Rule("$$", "$$", "tex"))
-- autopairs.add_rule(Rule("/*", "*/", {"c", "cpp", "css", "javascript"}))

-- local disable_in_macro = false  -- disable when recording or executing a macro
-- local ignored_next_char = string.gsub([[ [%w%%%'%[%"%.] ]],"%s+", "")
-- local enable_moveright = true
-- local enable_afterquote = true  -- add bracket pairs after quote
-- local enable_check_bracket_line = true  --- check bracket in same line
-- local check_ts = false
-- local map_bs = true -- map the <BS> key
-- local map_c_w = false -- map <c-w> to delete an pair if possible


-- -- autopairs.setup({
-- --     disable_filetype = {"TelescopePrompt"},
-- --     -- fast_wrap = {},
-- --     fast_wrap = {
-- --         map = "<M-e>",
-- --         chars = {"{", "[", "(", '"', "'"},
-- --         pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
-- --         end_key = "$",
-- --         keys = "qwertyuiopzxcvbnmasdfghjkl",
-- --         check_comma = true,
-- --         hightlight = "Search",
-- --         map_cr = true
-- --     }
-- -- })



local status, autopairs = pcall(require, "nvim-autopairs")
if (not status) then
  return
end

autopairs.setup(
  {
    disable_filetype = {"TelescopePrompt"},
    -- fast_wrap = {},
    fast_wrap = {
      map = "<M-e>",
      chars = {"{", "[", "(", '"', "'"},
      pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
      end_key = "$",
      keys = "qwertyuiopzxcvbnmasdfghjkl",
      check_comma = true,
      hightlight = "Search"
    }
  }
)

-- custom rules
local Rule = require("nvim-autopairs.rule")

autopairs.add_rule(Rule("$$", "$$", "tex"))

autopairs.add_rule(Rule("/*", "*/", {"c", "cpp", "css", "javascript"}))
