-- Check it is installed
local status_ok, autopairs = pcall(require, "nvim-autopairs")
if (not status_ok) then
  return
end


-- Setup
autopairs.setup {
  disable_filetype = { "TelescopePrompt" },
  fast_wrap = {
    map = "<M-e>",
    chars = { "{", "[", "(", '"', "'" },
    pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
    end_key = "$",
    keys = "qwertyuiopzxcvbnmasdfghjkl",
    check_comma = true,
    hightlight = "Search",
    map_cr = false
  }
}


-- Custom rules
local Rule = require("nvim-autopairs.rule")

autopairs.add_rule(Rule("$$", "$$", "tex"))
autopairs.add_rule(Rule("/*", "*/", { "c", "cpp", "css", "javascript" }))
