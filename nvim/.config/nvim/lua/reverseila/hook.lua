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
    vim.highlight.on_yank { higroup = "IncSearch", timeout = 400 }
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
