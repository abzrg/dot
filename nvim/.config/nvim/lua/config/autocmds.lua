local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup


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


-- Formatting options only achieved this way
local format_options_group = augroup("FormatOptions", { clear = true })
autocmd({"FileType"}, {
  pattern = "*",
  callback = function()
    vim.opt.formatoptions = "jcqnl"
  end,
  group = format_options_group
})

-- When editing a file, always jump to the last known cursor position.
-- Don't do it when the position is invalid, when inside an event handler
-- (happens when dropping a file on gvim) and for a commit message (it's
-- likely a different one than last time).
local lastplace_group = augroup("LastPlace", { clear = true })
vim.api.nvim_create_autocmd('BufReadPost', {
  group = lastplace_group,
  callback = function(args)
    local valid_line = vim.fn.line([['"]]) >= 1 and vim.fn.line([['"]]) < vim.fn.line('$')
    local not_commit = vim.b[args.buf].filetype ~= 'commit'

    if valid_line and not_commit then
      vim.cmd([[normal! g`"]])
    end
  end,
})
