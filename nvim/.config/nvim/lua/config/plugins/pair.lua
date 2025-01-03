return {
  'windwp/nvim-autopairs',

  config = function(_, opts)
    require('nvim-autopairs').setup({
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
      },

      disable_in_macro = true,        -- disable when recording or executing a macro
      disable_in_visualblock = false, -- disable when insert after visual block mode
      disable_in_replace_mode = true,
      ignored_next_char = [=[[%w%%%'%[%"%.%`%$]]=],
      enable_moveright = true,
      enable_afterquote = true,         -- add bracket pairs after quote
      enable_check_bracket_line = true, --- check bracket in same line
      enable_bracket_in_quote = true,   --
      enable_abbr = false,              -- trigger abbreviation
      break_undo = true,                -- switch for basic rule break undo sequence
      check_ts = false,
      map_cr = true,
      map_bs = true,   -- map the <BS> key
      map_c_h = false, -- Map the <C-h> key to delete a pair
      map_c_w = false, -- map <c-w> to delete a pair if possible
    })

    -- Custom rules
    local Rule = require("nvim-autopairs.rule")
    local npairs = require('nvim-autopairs')

    npairs.add_rule(Rule("$", "$", "tex"))
    npairs.add_rule(Rule("/*", "*/", { "c", "cpp", "css", "javascript" }))
    npairs.add_rule(Rule("(", "", { "tex", "latex" }))
    npairs.add_rule(Rule("'", "", { "tex", "latex" }))
    npairs.get_rules("'")[1].not_filetypes = { "scheme", "lisp", "tex", "latex" }

    local brackets = { { '(', ')' }, { '[', ']' }, { '{', '}' } }
    npairs.add_rules {
      Rule(' ', ' ')
          :with_pair(function(opts)
            local pair = opts.line:sub(opts.col - 1, opts.col)
            return vim.tbl_contains({
              brackets[1][1] .. brackets[1][2],
              brackets[2][1] .. brackets[2][2],
              brackets[3][1] .. brackets[3][2],
            }, pair)
          end)
    }
    for _, bracket in pairs(brackets) do
      npairs.add_rules {
        Rule(bracket[1] .. ' ', ' ' .. bracket[2])
            :with_pair(function() return false end)
            :with_move(function(opts)
              return opts.prev_char:match('.%' .. bracket[2]) ~= nil
            end)
            :use_key(bracket[2])
      }
    end
  end
}
