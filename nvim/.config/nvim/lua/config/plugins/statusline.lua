return {
  'tjdevries/express_line.nvim',
  config = function()
    local builtin = require "el.builtin"
    local extensions = require "el.extensions"
    local subscribe = require "el.subscribe"
    local sections = require "el.sections"

    -- local mymode = require("el.extensions.gen_mode")()


    vim.opt.laststatus = 3

    require("el").setup {
      generator = function()
        local segments = {}

        local mode_opts = { format_string = "[%.1s]" }

        table.insert(segments, extensions.gen_mode(mode_opts))
        table.insert(segments, " ")

        table.insert(
          segments,
          subscribe.buf_autocmd("el-git-branch", "BufEnter", function(win, buf)
            local branch = extensions.git_branch(win, buf)
            if branch then
              return ' ' .. branch .. ' '
            end
          end)
        )
        table.insert(
          segments,
          subscribe.buf_autocmd("el-git-changes", "BufWritePost", function(win, buf)
            local changes = extensions.git_changes(win, buf)
            if changes then
              return changes .. ' '
            end
          end)
        )
        -- table.insert(segments, function()
        --   local task_count = #require("misery.scheduler").tasks
        --   if task_count == 0 then
        --     return ""
        --   else
        --     return string.format(" (Queued Events: %d)", task_count)
        --   end
        -- end)
        -- table.insert(segments, sections.split)
        table.insert(segments, "%f %m")
        table.insert(segments, sections.split)
        table.insert(segments, builtin.filetype)
        table.insert(segments, "[")
        table.insert(segments, builtin.line_with_width(3))
        table.insert(segments, ":")
        table.insert(segments, builtin.column_with_width(2))
        table.insert(segments, "]")

        return segments
      end,
    }
  end

}


--
--
--
--
--
-- return {
-- 	
-- 	config = function()
-- 		local Job = require "plenary.job"
-- 		local git_branch = function(_, buffer)
-- 			local j = Job:new {
-- 				command = "git",
-- 				args = { "branch", "--show-current" },
-- 				cwd = vim.fn.fnamemodify(buffer.name, ":h"),
-- 			}
--
-- 			local ok, result = pcall(function()
-- 				return vim.trim(j:sync()[1])
-- 			end)
--
-- 			if ok then
-- 				return '(' .. result .. ')'
-- 			end
-- 		end
--
-- 		require('el').setup {
-- 			generator = function(win_id)
-- 				local extensions = require('el.extensions')   -- extensions.mode
-- 				local builtin = require('el.builtin')         -- builtin.file
--
-- 				local el_segments = {}
--
-- 				table.insert(el_segments, git_branch)
-- 				-- table.insert(el_segments, '%f ')
-- 				-- table.insert(el_segments, extensions.mode) -- mode returns the current mode.
--
-- 				-- table.insert(el_segments, builtin.file_relative)
--
-- 				table.insert(el_segments, '%t %m%r%h%w %y ')
--
-- 				-- table.insert(el_segments, extensions.git_branch)
-- 				table.insert(el_segments, '%=%l,%v  %P')
--
-- 				return el_segments
-- 			end
-- 		}
-- 	end
-- }
