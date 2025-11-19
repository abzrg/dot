return {
  "windwp/nvim-autopairs",
  config = function()
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

    local Rule = require("nvim-autopairs.rule")
    local npairs = require('nvim-autopairs')
    local cond = require('nvim-autopairs.conds')

    npairs.add_rule(Rule("$", "$", "tex"))
    npairs.add_rule(Rule("/*", "*/", { "c", "cpp", "css", "javascript" }))
    npairs.add_rule(Rule("(", "", { "tex", "latex" }))
    npairs.add_rule(Rule("'", "", { "tex", "latex" }))
    npairs.get_rules("'")[1].not_filetypes = { "scheme", "lisp", "tex", "latex" }

    local brackets = { { '(', ')' }, { '[', ']' }, { '{', '}' } }

    --
    -- Following rules from: https://github.com/ilias777/nvim
    --

    -- ADD SPACES BETWEEN PARENTHESES
    npairs.add_rules({
      -- Rule for a pair with left-side ' ' and right side ' '
      Rule(' ', ' ', { "-markdown", "-", "-text", "-todowork", "-wordlist" })
      -- Pair will only occur if the conditional function returns true
          :with_pair(
            function(opts)
              -- We are checking if we are inserting a space in (), [], or {}
              local pair = opts.line:sub(opts.col - 1, opts.col)
              return vim.tbl_contains({
                brackets[1][1] .. brackets[1][2],
                brackets[2][1] .. brackets[2][2],
                brackets[3][1] .. brackets[3][2],
              }, pair)
            end
          )
          :with_move(cond.none())
          :with_cr(cond.none())
      -- We only want to delete the pair of spaces when the cursor is as such: ( | )
          :with_del(
            function(opts)
              local col = vim.api.nvim_win_get_cursor(0)[2]
              local context = opts.line:sub(col - 1, col + 2)
              return vim.tbl_contains({
                brackets[1][1] .. '  ' .. brackets[1][2],
                brackets[2][1] .. '  ' .. brackets[2][2],
                brackets[3][1] .. '  ' .. brackets[3][2],
              }, context)
            end
          ),
    })

    -- -- AUTO ADDSPACE ON =
    -- npairs.add_rules({
    --   Rule('=', '', { "-markdown", "-text", "-" })
    --       :with_pair(cond.not_inside_quote())
    --       :with_pair(function(opts)
    --         local last_char = opts.line:sub(opts.col - 1, opts.col - 1)
    --         if last_char:match('[%w%=%s]') then
    --           return true
    --         end
    --         return false
    --       end)
    --       :replace_endpair(function(opts)
    --         local prev_2char = opts.line:sub(opts.col - 2, opts.col - 1)
    --         local next_char = opts.line:sub(opts.col, opts.col)
    --         next_char = next_char == ' ' and '' or ' '
    --         if prev_2char:match('%w$') then
    --           return '<bs> =' .. next_char
    --         end
    --         if prev_2char:match('%=$') then
    --           return next_char
    --         end
    --         if prev_2char:match('=') then
    --           return '<bs><bs>=' .. next_char
    --         end
    --         return ''
    --       end)
    --       :set_end_pair_length(0)
    --       :with_move(cond.none())
    --       :with_del(cond.none()),
    -- })

    -- For each pair of brackets we will add another rule
    for _, bracket in pairs(brackets) do
      npairs.add_rules({
        -- Each of these rules is for a pair with left-side '( ' and right-side ' )' for each bracket type
        Rule(bracket[1] .. ' ', ' ' .. bracket[2])
            :with_pair(cond.none())
            :with_move(function(opts)
              return opts.char == bracket[2]
            end)
            :with_del(cond.none())
            :use_key(bracket[2])
        -- Removes the trailing whitespace that can occur without this
            :replace_map_cr(
              function(_)
                return '<C-c>2xi<CR><C-c>O'
              end
            ),
      })
    end

    -- MOVE PAST COMMAS AND SEMICOLONS
    for _, punct in pairs({ ',', ';' }) do
      require('nvim-autopairs').add_rules({
        require('nvim-autopairs.rule')('', punct)
            :with_move(function(opts)
              return opts.char == punct
            end)
            :with_pair(function()
              return false
            end)
            :with_del(function()
              return false
            end)
            :with_cr(function()
              return false
            end)
            :use_key(punct),
      })
    end
  end
}
