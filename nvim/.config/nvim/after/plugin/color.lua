-- vim.g.tokyonight_style = "night"
-- vim.cmd("colorscheme tokyonight")
-- vim.cmd([[
--     "" hi Normal guibg=None
--     hi Vertsplit guifg=#3b4261
-- ]])

-- vim.cmd("colorscheme darkplus")
-- vim.cmd([[
--   hi NonText guifg=#808080
--   hi whitespace guifg=#808080
--   hi ColorColumn guifg=white guibg=darkred
--   hi link CursorColumn Cursorline
--   "hi Normal guibg=None
-- ]])

-- vim.cmd("colorscheme codedark")

vim.cmd("colo base16-bright")
vim.cmd([[
hi Cursorline guibg=#202020
hi CursorColumn guibg=#202020
hi Vertsplit guibg=none
hi Debug           ctermfg=1 guifg=#fb0120 guibg=#303030
hi DiagnosticError  ctermfg=1 guifg=red guibg=#000000
hi DiagnosticWarn  ctermfg=3 guifg=orange guibg=#000000
hi DiagnosticInfo  ctermfg=4 guifg=lightblue guibg=#000000
hi DiagnosticHint  ctermfg=7 guifg=lightgrey guibg=#000000
hi DiagnosticSignError ctermfg=1 guifg=red guibg=#303030
hi DiagnosticSignWarn ctermfg=3 guifg=orange guibg=#303030
hi DiagnosticSignInfo ctermfg=4 guifg=lightblue guibg=#303030
hi DiagnosticSignHint ctermfg=7 guifg=lightgrey guibg=#303030
hi NormalFloat guibg=None
hi matchparen guifg=#fda331 guibg=none gui=bold,underline
hi LspReferenceText guibg=#303030


]])

local statusline_highlight_group = vim.api.nvim_create_augroup("StatusLineHighligh", { clear = true })
vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "base16-bright",
  callback = function()
    vim.cmd([[
    hi LeftStatusline guibg=#fb0120
    hi LeftPowerlineStatusline guifg=#fb0120 guibg=#505050
    hi RightPowerlineStatusline guifg=#e0e0e0 guibg=#505050
    hi FileName gui=bold guibg=#505050
    hi LineCol guibg=#e0e0e0 guifg=#303030 gui=bold
    hi Git guibg=#505050 gui=italic
    ]])
  end,
  group = statusline_highlight_group
})

vim.cmd([[
hi LeftStatusline guibg=#fb0120
hi LeftPowerlineStatusline guifg=#fb0120 guibg=#505050
hi RightPowerlineStatusline guifg=#e0e0e0 guibg=#505050
hi FileName gui=bold guibg=#505050
hi LineCol guibg=#e0e0e0 guifg=#303030 gui=bold
hi Git guibg=#505050 gui=italic

" --------------------------------------------------------------------------- "
hi TSOperator guifg=#d381c3
]])
