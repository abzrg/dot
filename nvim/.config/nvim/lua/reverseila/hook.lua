-- Some niceties
local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup


-- Do not force autocomment
local format_options_group = augroup("FormatOptions", { clear = true })
autocmd("FileType", {
  pattern = "*",
  callback = function()
    vim.opt.formatoptions:append({ "l", "j" })
    vim.opt.formatoptions:remove({ "t", "c", "o", "r" })
  end,
  group = format_options_group
})

-- For git commit buffers automatically break long lines as typing
autocmd("Filetype", {
  pattern = "gitcommit",
  callback = function() vim.opt_local.formatoptions:append("t") end,
  group = format_options_group,
})


-- Highlight yank
local highlight_yank_group = augroup("HighlightYank", { clear = true })
autocmd("TextYankPost", {
  pattern = "*",
  callback = function()
    vim.highlight.on_yank { higroup = "IncSearch", timeout = 100 }
  end,
  group = highlight_yank_group,
})


-- Auto resize splits upon window resize
local auto_resize_group = augroup("AutoResizeSplit", { clear = true })
autocmd("vimResized", {
  pattern = "*",
  command = vim.cmd('execute "normal! \\<C-w>="'),
  group = auto_resize_group,
})


-- Automatically quit Vim if quickfix window is the last
local close_qflist_group = augroup("CloseQuickFixListIfLast", { clear = true })
autocmd("BufEnter", {
  pattern = "*",
  callback = function()
    if vim.bo.buftype == "quickfix" and vim.fn.winnr("$") < 2 then
      vim.cmd("quit")
    end
  end,
  group = close_qflist_group,
})


-- -- xrdb update on save
-- vim.cmd([[
-- autocmd BufRead,BufNewFile xresources,xdefaults set filetype=xdefaults
-- autocmd BufWritePost .Xresources,.Xdefaults,.xresources,.xdefaults !xrdb %
-- ]])


-- --  Better help
-- vim.cmd([[
-- " Open help in a new tab instead of a split
-- augroup HelpInTabs
-- autocmd!
-- autocmd BufEnter *.txt call HelpInNewTab()
-- augroup END
-- --
-- function! HelpInNewTab()
-- if &buftype == 'help'
--   "Convert the help window to a tab...
--   execute "normal \<C-W>T"
--   endif
--   endfunction
-- ]])

-- -- Disable cursorline in insert mode
-- local cursorline_insert_group = augroup("CursorLineInsertMode", { clear = true })
--
-- autocmd("InsertEnter", {
--   pattern = "*",
--   callback = function()
--     vim.wo.cursorline = false
--   end,
--   group = cursorline_insert_group
-- })

-- autocmd("InsertLeavePre", {
--   pattern = "*",
--   callback = function()
--     vim.wo.cursorline = true
--   end,
--   group = cursorline_insert_group
-- })


-- -- focus
-- -- source: @wincent
-- local focus_group = augroup("FocusGroup", { clear = true })
--
-- -- When moving into a split
-- autocmd({ "VimEnter", "WinEnter", "BufEnter", "CmdWinEnter" }, {
--   pattern = "*",
--   callback = function()
--     -- If the two window are of the same buffer don't bother with gitsings
--     local lastbuf = vim.fn.expand("#")
--     local curbuf = vim.fn.expand("%")
--     if lastbuf ~= curbuf then
--       if vim.fn.exists(":Gitsigns") then
--         require("gitsigns").attach()
--       end
--     end
--     -- vim.cmd("ownsyntax on")
--     vim.wo.colorcolumn = '+' .. vim.fn.join(vim.fn.range(0, 254), ',+')
--     vim.wo.cursorline = true
--     -- vim.cmd("hi EndOfBuffer guibg=#000000")
--   end,
--   group = focus_group
-- })
--
-- -- When coming into vim
-- autocmd({ "FocusGained" }, {
--   pattern = "*",
--   callback = function()
--     vim.cmd("syntax on")
--     if vim.fn.exists(":TSEnable") then
--       vim.cmd("TSEnable highlight")
--     end
--     if vim.fn.exists(":Gitsigns") then
--       require("gitsigns").attach()
--     end
--     vim.wo.colorcolumn = '+' .. vim.fn.join(vim.fn.range(0, 254), ',+')
--     vim.wo.cursorline = true
--     -- vim.cmd("hi EndOfBuffer guibg=#252525")
--     -- vim.cmd("hi CursorLine guibg=#202020")
--     -- vim.cmd("hi VertSplit guibg=none")
--   end,
--   group = focus_group
-- })
--
-- -- When moving out of a splits
-- autocmd({ "WinLeave", "BufLeave" }, {
--   pattern = "*",
--   callback = function()
--     if vim.bo.filetype == "qf" then
--       return
--     else
--       -- If the two window are of the same buffer don't bother with gitsings
--       local lastwin = vim.api.nvim_win_get_buf(vim.fn.win_getid(vim.fn.winnr("#")))
--       local curwin = vim.api.nvim_win_get_buf(vim.api.nvim_get_current_win())
--       if lastwin ~= curwin then
--         if vim.fn.exists(":Gitsigns") then
--           require("gitsigns").detach()
--         end
--       end
--     end
--     vim.wo.cursorline = false
--     vim.wo.colorcolumn = vim.fn.join(vim.fn.range(1, 255), ',')
--     -- vim.cmd("hi EndOfBuffer guibg=#303030")
--   end,
--   group = focus_group
-- })
--
-- -- When going out of vim
-- autocmd({ "FocusLost" }, {
--   pattern = "*",
--   callback = function()
--     vim.cmd("syntax off")
--     if vim.fn.exists(":TSDisable") then
--       vim.cmd("TSDisable highlight")
--     end
--     if vim.fn.exists(":Gitsigns") then
--       require("gitsigns").detach_all()
--     end
--     vim.wo.cursorline = true
--     vim.wo.colorcolumn = vim.fn.join(vim.fn.range(1, 255), ',')
--     -- vim.cmd("hi CursorLine guibg=#303030")
--     -- vim.cmd("hi VertSplit guibg=#303030")
--     -- vim.cmd("hi EndOfBuffer guibg=#303030")
--   end,
--   group = focus_group
-- })
--

-- Disable line number in terminal
local term_disable_line_nr_group = augroup("TermDisableLineNr", { clear = true })
autocmd("TermOpen", {
  pattern = "*",
  command = "setlocal nonu nornu",
  group = term_disable_line_nr_group
})


-- Automatically quit Vim if quickfix window is the last
local netrw = augroup("netrwRelated", { clear = true })
autocmd("FileType", {
  pattern = "netrw",
  callback = function()
    vim.keymap.set({ "n", "v" }, "<C-h>", "<cmd>bp<cr>", { noremap = true, buffer = true })
    vim.keymap.set({ "n", "v" }, "<C-l>", "<cmd>bn<cr>", { noremap = true, buffer = true })
  end,
  group = netrw,
})

-- add relative line numbering in insert mode and remove it when you switch back to normal mode

local ins_rel_ln_nr = augroup("insModeRelLineNr", { clear = true })
autocmd("InsertEnter", {
  pattern = {"*.c", "*.cpp", "*.py", "*.java"},
  command = "set rnu",
  group = ins_rel_ln_nr
})
autocmd("InsertLeavePre", {
  pattern = {"*.c", "*.cpp", "*.py", "*.java"},
  command = "set nornu",
  group = ins_rel_ln_nr
})


-- enable wrap in quickfix list
local quickfixlist_wrapped = augroup("QuickFixListWrapped", { clear = true })
autocmd("BufEnter", {
  pattern = "*",
  callback = function()
    if vim.bo.buftype == "quickfix" then
      vim.cmd("set wrap")
    end
  end,
  group = quickfixlist_wrapped,
})



