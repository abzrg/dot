-- Some niceties
local nnoremap = require("reverseila.utils.keymap").nnoremap


-- [ Formatter ] -----------------------------------------

-- Check if a black is installed
if vim.fn.executable("black") == 1
    and vim.fn.executable("isort") then
  nnoremap("<leader>=", "", {
    buffer = true, silent = true,
    callback = function()
      -- First write the file
      vim.cmd("write")

      -- Set the formatter and formatter command
      local formatter = "black"
      local format_cmd = formatter .. " " .. vim.fn.expand("%")

      -- Format and grab status code of code formatter
      vim.fn.system(format_cmd)
      local format_status = 1
      if vim.v.shell_error ~= 0 then
        format_status = 0
      end

      -- Sort imports
      vim.fn.system("isort --ws " .. vim.fn.expand("%"))

      -- Re-read buffer after changes
      vim.cmd("silent! edit!")

      -- Inform user how it did went
      if format_status == 1 then
        print("[" .. vim.fn.toupper(formatter) .. "]: DONE!")
      else
        print("[" .. vim.fn.toupper(formatter) .. "]: FAILED!")
      end
    end
  })
end


-- [ Pylint ] ---------------------------------------

if vim.fn.executable("pylint") == 1 then
  nnoremap("<leader>l", "", {
    buffer = true, silent = true,
    callback = function()
      vim.opt_local.makeprg = "pylint --output-format=parseable %"
      if vim.fn.exists(":Make") then
        vim.cmd("w | Make")
      else
        vim.cmd("w | make")
      end
    end
  })
end
