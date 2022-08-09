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

-- Disable cursorline in insert mode
local cursorline_insert_group = augroup("CursorLineInsertMode", { clear = true })

autocmd("InsertEnter", {
  pattern = "*",
  callback = function()
    vim.wo.cursorline = false
  end,
  group = cursorline_insert_group
})

autocmd("InsertLeavePre", {
  pattern = "*",
  callback = function()
    vim.wo.cursorline = true
  end,
  group = cursorline_insert_group
})


-- focus
-- source: @wincent
local focus_group = augroup("FocusGroup", { clear = true })

-- When moving into a split
autocmd({ "VimEnter", "WinEnter", "BufEnter" }, {
  pattern = "*",
  callback = function()
    if vim.fn.exists(":Gitsigns") then
      require("gitsigns").attach()
    end
    vim.wo.colorcolumn = '+' .. vim.fn.join(vim.fn.range(0, 254), ',+')
    vim.wo.cursorline = true
  end,
  group = focus_group
})

-- When coming into vim
autocmd({ "FocusGained" }, {
  pattern = "*",
  callback = function()
    vim.cmd("syntax on")
    if vim.fn.exists(":TSEnable") then
      vim.cmd("TSEnable highlight")
    end
    if vim.fn.exists(":Gitsigns") then
      require("gitsigns").attach()
    end
    vim.wo.colorcolumn = '+' .. vim.fn.join(vim.fn.range(0, 254), ',+')
    vim.wo.cursorline = true
    vim.cmd("hi EndOfBuffer guibg=none")
    vim.cmd("hi CursorLine guibg=#202020")
    vim.cmd("hi VertSplit guibg=none")
  end,
  group = focus_group
})

-- When moving out of a splits
autocmd({ "WinLeave" }, {
  pattern = "*",
  callback = function()
    if vim.bo.filetype == "qf" then
      return
    end
    if vim.fn.exists(":Gitsigns") then
      require("gitsigns").detach()
    end
    vim.wo.cursorline = false
    vim.wo.colorcolumn = vim.fn.join(vim.fn.range(1, 255), ',')
  end,
  group = focus_group
})

-- When going out of vim
autocmd({ "FocusLost" }, {
  pattern = "*",
  callback = function()
    if vim.fn.exists(":TSDisable") then
      vim.cmd("TSDisable highlight")
    end
    vim.cmd("syntax off")
    if vim.fn.exists(":Gitsigns") then
      require("gitsigns").detach_all()
    end
    vim.wo.cursorline = true
    vim.wo.colorcolumn = vim.fn.join(vim.fn.range(1, 255), ',')
    vim.cmd("hi EndOfBuffer guibg=#303030")
    vim.cmd("hi CursorLine guibg=#303030")
    vim.cmd("hi VertSplit guibg=#303030")
  end,
  group = focus_group
})
