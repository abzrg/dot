-- [ Formatter ] -----------------------------------------

-- Check if a black is installed
if vim.fn.executable("black") == 1
    and vim.fn.executable("isort") then
  vim.keymap.set("n", "<leader>=",
    function()
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
        vim.cmd("write")
        print("[" .. vim.fn.toupper(formatter) .. "]: DONE!")
      else
        print("[" .. vim.fn.toupper(formatter) .. "]: FAILED!")
      end
    end,
    { buffer = true, silent = true, })
end

-- -- Does not work properly
-- -- Use formatter in gq command
-- if vim.fn.executable("black") then
--   -- set formatprg
--   vim.bo.formatprg = "black -q -l 80 - 2>/dev/null"
--
--   -- Ensure we formatprg instead of formatexpr
--   vim.bo.formatexpr = ""
-- end


-- [ Pylint ] ---------------------------------------

if vim.fn.executable("pylint") == 1 then
  vim.keymap.set("n", "<leader>L", "", {
    buffer = true,
    silent = true,
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


-- [ Run Python ] ----------------------------------------------------------

vim.keymap.set("n", "<F5>", "", {
  buffer = true,
  silent = true,
  callback = function()
    vim.cmd("compiler python")
    vim.opt_local.makeprg = "python %"
    vim.cmd("Make")
  end
})


-- [ Run Pytest ] -----------------------------------------------------------

vim.api.nvim_buf_create_user_command(0, "Pytest", "compiler pytest | Make", {})


-- [ fold ] -----------------------------------------------------------------

-- vim.opt_local.foldmethod = "expr"
vim.opt_local.foldexpr = 'nvim_treesitter#foldexpr()'
vim.opt_local.foldenable = false -- Disable folding at startup.

local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

vim.api.nvim_create_autocmd({ "BufEnter" }, { pattern = { "*" }, command = "normal zx", })
-- enable wrap in quickfix list
local fold_python = augroup("FoldPython", { clear = true })
autocmd("BufEnter", {
  pattern = "*.py",
  command = "normal zx",
  group = fold_python
})

-- https://github.com/nvim-treesitter/nvim-treesitter/issues/1564#issuecomment-931000867
-- only fold class and functions
vim.treesitter.set_query("python", "folds", [[
  (function_definition (block) @fold)
  (class_definition (block) @fold)
]])


vim.keymap.set("n", "<CR>", "za", { buffer=true, noremap=true, silent=true })


---- [ Enable Numbering ] ---------------

vim.opt_local.number = true
vim.opt.signcolumn  = "yes"
