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
