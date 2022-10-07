-- -- -- -- vim.g.tokyonight_style = "night"
-- -- -- -- vim.cmd("colorscheme tokyonight")
-- -- -- -- vim.cmd([[
-- -- -- --     "" hi Normal guibg=None
-- -- -- --     hi Vertsplit guifg=#3b4261
-- -- -- -- ]])
-- -- --
-- -- -- -- vim.cmd("colorscheme darkplus")
-- -- -- -- vim.cmd([[
-- -- -- --   hi NonText guifg=#808080
-- -- -- --   hi whitespace guifg=#808080
-- -- -- --   hi ColorColumn guifg=white guibg=darkred
-- -- -- --   hi link CursorColumn Cursorline
-- -- -- --   "hi Normal guibg=None
-- -- -- -- ]])
--
-- -- vim.cmd("colorscheme codedark")
--
--
-- -- -- [ base16-bright ] --------------------------------------------
-- -- vim.cmd("colo base16-bright")
-- -- vim.cmd([[
-- -- hi Normal guibg=none
-- -- "hi Cursorline guibg=#202020
-- -- hi CursorColumn guibg=#202020
-- -- hi Vertsplit guibg=none
-- -- hi Debug           ctermfg=1 guifg=#fb0120 guibg=#303030
-- -- hi DiagnosticError  ctermfg=1 guifg=red guibg=#000000
-- -- hi DiagnosticWarn  ctermfg=3 guifg=orange guibg=#000000
-- -- hi DiagnosticInfo  ctermfg=4 guifg=lightblue guibg=#000000
-- -- hi DiagnosticHint  ctermfg=7 guifg=lightgrey guibg=#000000
-- -- hi DiagnosticSignError ctermfg=1 guifg=red guibg=#303030
-- -- hi DiagnosticSignWarn ctermfg=3 guifg=orange guibg=#303030
-- -- hi DiagnosticSignInfo ctermfg=4 guifg=lightblue guibg=#303030
-- -- hi DiagnosticSignHint ctermfg=7 guifg=lightgrey guibg=#303030
-- -- hi NormalFloat guibg=None
-- -- hi matchparen guifg=#fda331 guibg=none gui=bold,underline
-- -- hi LspReferenceText guibg=#303030
-- -- hi LspReferenceRead gui=none guibg=#373737 guifg=none
-- -- hi LspReferenceText gui=none guibg=#373737 guifg=none
-- -- hi LspReferenceWrite gui=none guibg=#373737 guifg=none
-- -- ]])
-- -- -- local statusline_highlight_group = vim.api.nvim_create_augroup("StatusLineHighligh", { clear = true })
-- -- vim.api.nvim_create_autocmd("ColorScheme", {
-- --   pattern = "base16-bright",
-- --   callback = function()
-- --     vim.cmd([[
-- --     hi LeftStatusline guibg=#fb0120
-- --     hi LeftPowerlineStatusline guifg=#fb0120 guibg=#505050
-- --     hi RightPowerlineStatusline guifg=#e0e0e0 guibg=#505050
-- --     hi FileName gui=bold guibg=#505050
-- --     hi LineCol guibg=#e0e0e0 guifg=#303030 gui=bold
-- --     hi Git guibg=#505050 gui=italic
-- --     hi CursorColumn guibg=#202020
-- --     ]])
-- --   end,
-- --   group = statusline_highlight_group
-- -- })
-- -- vim.cmd([[
-- -- hi LeftStatusline guibg=#fb0120
-- -- hi LeftPowerlineStatusline guifg=#fb0120 guibg=#505050
-- -- hi RightPowerlineStatusline guifg=#e0e0e0 guibg=#505050
-- -- hi FileName gui=bold guibg=#505050
-- -- hi LineCol guibg=#e0e0e0 guifg=#303030 gui=bold
-- -- hi Git guibg=#505050 gui=italic
-- -- " --------------------------------------------------------------------------- "
-- -- hi TSOperator guifg=#d381c3
-- -- ]])
--
--
--
-- -- -- [ Nord ] -------------------------------
-- --
-- -- -- vim.cmd([[colo nord]])
-- -- -- -- local statusline_highlight_group = vim.api.nvim_create_augroup("StatusLineHighligh", { clear = true })
-- -- -- vim.api.nvim_create_autocmd("ColorScheme", {
-- -- --   pattern = "nord",
-- -- --   callback = function()
-- -- --     vim.cmd([[
-- -- --     hi LeftStatusline guibg=#bf616a
-- -- --     hi LeftPowerlineStatusline guifg=#bf616a guibg=#434c5e
-- -- --     hi RightPowerlineStatusline guifg=#d8dee9 guibg=#505050
-- -- --     hi FileName gui=bold guibg=#434c5e
-- -- --     hi LineCol guibg=#d8dee9 guifg=#2e3440 gui=bold
-- -- --     hi Git guibg=#434c5e gui=italic
-- -- --     ]])
-- -- --   end,
-- -- --   group = statusline_highlight_group
-- -- -- })
-- -- -- vim.cmd([[
-- -- -- hi LeftStatusline guibg=#bf616a
-- -- -- hi LeftPowerlineStatusline guifg=#bf616a guibg=#505050
-- -- -- hi RightPowerlineStatusline guifg=#d8dee9 guibg=#505050
-- -- -- hi FileName gui=bold guibg=#505050
-- -- -- hi LineCol guibg=#d8dee9 guifg=#2e3440 gui=bold
-- -- -- hi Git guibg=#434c5e gui=italic
-- -- -- ]])
-- --
-- --
--
-- -- [ darkplus ] -------------------------------
--
-- vim.cmd([[colo codedark]])
-- -- local statusline_highlight_group = vim.api.nvim_create_augroup("StatusLineHighligh", { clear = true })
-- vim.api.nvim_create_autocmd("ColorScheme", {
--   pattern =  "codedark",
--   callback = function()
--     vim.cmd([[
--     hi LeftStatusline guibg=#f44747
--     hi LeftPowerlineStatusline guifg=#f44747 guibg=#3e3e3e
--     hi RightPowerlineStatusline guifg=#d8dee9 guibg=#3e3e3e
--     hi FileName gui=bold guibg=#3e3e3e
--     hi LineCol guibg=#d8dee9 guifg=#3e3e3e gui=bold
--     hi Git guibg=#3e3e3e guifg=#949494 gui=italic
--
--     hi GitSignsAdd guibg=#252525
--     hi GitSignsChange guibg=#252525
--     hi GitSignsDelete guibg=#252525
--
--     hi DiagnosticError guifg=#f44747 guibg=#252525
--     hi DiagnosticWarn  guifg=#ff8800 guibg=#252525
--     hi DiagnosticInfo  guifg=#ffcc66 guibg=#252525
--     hi DiagnosticHint  guifg=#4bc1fe guibg=#252525
--
--     hi LspDiagnosticsSignError guibg=#252525
--     hi LspDiagnosticsSignInfo guibg=#252525
--     hi LspDiagnosticsSignWarning guibg=#252525
--     hi LspDiagnosticsSignHint guibg=#252525
--     hi LspDiagnosticsSignInformation guibg=#252525
--
--     hi Normal guibg=None
--     hi LineNr guibg=#252525
--     hi CursorLineNr guibg=#252525
--     hi SignColumn guibg=#252525
--     hi StatusLine guifg=#949494 guibg=#3e3e3e
--     hi StatusLineNC gui=italic guifg=#5e5e5e
--     hi NonText guifg=#808080
--     hi whitespace guifg=#808080
--     hi link CursorColumn Cursorline
--
--     hi TelescopeSelection  guibg=#252525
--     hi TelescopeSelectionCaret  guifg=#d16969 guibg=#000000
--     hi TelescopeMultiSelection   guibg=#000000
--     hi TelescopeMultiIcon   guibg=#000000
--     hi TelescopeNormal  guifg=#d4d4d4 guibg=#202123 guibg=#000000
--     hi TelescopePromptNormal   guibg=#000000
--     hi TelescopeResultsNormal   guibg=#000000
--     hi TelescopeBorder  guifg=#a4a4a4 guibg=#000000
--     hi TelescopePromptBorder   guibg=#000000
--     hi TelescopeResultsBorder   guibg=#000000
--     hi TelescopePreviewBorder   guibg=#000000
--     hi TelescopeTitle   guibg=#000000
--     hi TelescopePromptTitle  cterm=bold gui=bold guifg=#e8ab53 guibg=#000000
--     hi TelescopeResultsTitle  cterm=bold gui=bold guifg=#e8ab53 guibg=#000000
--     hi TelescopePreviewTitle  cterm=bold gui=bold guifg=#e8ab53 guibg=#000000
--     hi TelescopePromptCounter  guifg=#d16969 guibg=#000000
--     hi TelescopeMatching  cterm=bold,italic gui=bold,italic guifg=#ffcc66 guibg=#000000
--     hi TelescopePromptPrefix  guifg=#4bc1fe guibg=#000000
--     hi TelescopePreviewLine   guibg=#000000
--     hi TelescopePreviewMatch  guibg=#000000
--     hi TelescopePreviewLine   guibg=#264f78
--
--     ]])
--   end,
--   group = statusline_highlight_group
-- })
--
-- vim.cmd([[
--   hi GitSignsAdd guibg=#252525
--   hi GitSignsChange guibg=#252525
--   hi GitSignsDelete guibg=#252525
--
--   hi DiagnosticError guifg=#f44747 guibg=#252525
--   hi DiagnosticWarn  guifg=#ff8800 guibg=#252525
--   hi DiagnosticInfo  guifg=#ffcc66 guibg=#252525
--   hi DiagnosticHint  guifg=#4bc1fe guibg=#252525
--
--   hi LspDiagnosticsSignError guibg=#252525
--   hi LspDiagnosticsSignInfo guibg=#252525
--   hi LspDiagnosticsSignWarning guibg=#252525
--   hi LspDiagnosticsSignHint guibg=#252525
--   hi LspDiagnosticsSignInformation guibg=#252525
--
--   hi Normal guibg=None
--   hi LineNr guibg=#252525
--   hi CursorLineNr guibg=#252525
--   hi SignColumn guibg=#252525
--   hi StatusLine guifg=#949494 guibg=#3e3e3e
--   hi StatusLineNC gui=italic guifg=#5e5e5e
--   hi NonText guifg=#808080
--   hi whitespace guifg=#808080
--   hi link CursorColumn Cursorline
--
--   hi LeftStatusline guibg=#f44747
--   hi LeftPowerlineStatusline guifg=#f44747 guibg=#3e3e3e
--   hi RightPowerlineStatusline guifg=#d8dee9 guibg=#3e3e3e
--   hi FileName gui=bold guibg=#3e3e3e
--   hi LineCol guibg=#d8dee9 guifg=#2e3440 gui=bold
--   hi Git guibg=#3e3e3e guifg=#949494 gui=italic
--
--   hi TelescopeSelection  guibg=#252525
--   hi TelescopeSelectionCaret  guifg=#d16969 guibg=#000000
--   hi TelescopeMultiSelection   guibg=#000000
--   hi TelescopeMultiIcon   guibg=#000000
--   hi TelescopeNormal  guifg=#d4d4d4 guibg=#202123 guibg=#000000
--   hi TelescopePromptNormal   guibg=#000000
--   hi TelescopeResultsNormal   guibg=#000000
--   hi TelescopeBorder  guifg=#a4a4a4 guibg=#000000
--   hi TelescopePromptBorder   guibg=#000000
--   hi TelescopeResultsBorder   guibg=#000000
--   hi TelescopePreviewBorder   guibg=#000000
--   hi TelescopeTitle   guibg=#000000
--   hi TelescopePromptTitle  cterm=bold gui=bold guifg=#e8ab53 guibg=#000000
--   hi TelescopeResultsTitle  cterm=bold gui=bold guifg=#e8ab53 guibg=#000000
--   hi TelescopePreviewTitle  cterm=bold gui=bold guifg=#e8ab53 guibg=#000000
--   hi TelescopePromptCounter  guifg=#d16969 guibg=#000000
--   hi TelescopeMatching  cterm=bold,italic gui=bold,italic guifg=#ffcc66 guibg=#000000
--   hi TelescopePromptPrefix  guifg=#4bc1fe guibg=#000000
--   hi TelescopePreviewLine   guibg=#264f78
--   hi TelescopePreviewMatch   guibg=#000000
--
-- ]])
-- vim.cmd([[
-- colo codedark
-- ]])

-- vim.cmd([[
-- colo darkblue
-- hi Normal guibg=none
-- set nonu nornu signcolumn=no laststatus=0
-- " hi Visual guibg=#555555
-- hi CursorLine guibg=#44444a
-- hi Pmenu          ctermfg=253 ctermbg=238 guifg=Yellow guibg=darkblue
-- "hi PmenuSel       ctermfg=16 ctermbg=226 guifg=#000000 guibg=#ffff00
-- "hi PmenuSbar      ctermbg=16 guibg=#000000
-- "hi PmenuThumb     ctermbg=242 guibg=#6c6c6c
-- hi LspReferenceText guibg=#404040
-- hi LspReferenceRead gui=none guibg=#3a3a3e guifg=none
-- hi LspReferenceText gui=none guibg=#3a3a3e guifg=none
-- hi LspReferenceWrite gui=none guibg=#3a3a3e guifg=none
-- hi floatborder guibg=none guifg=lightblue
-- hi normalfloat guibg=none
-- ]])

-- vim.cmd([[
-- colo tokyonight
-- hi signcolumn guibg=none
-- hi Normal guibg=none
-- hi Comment guifg=#767fa9 gui=none
-- ]])


-- -- Light experiment
-- vim.cmd([[
-- set bg=light
-- hi GitSignsAdd    guifg=#587c0c guibg=none
-- hi GitSignsChange guifg=#0c7d9d guibg=none
-- hi GitSignsDelete guifg=#94151b guibg=none
-- hi LineNr         guifg=gray
-- hi SignColumn     guibg=none
-- hi EndOfBuffer    gui=none      guibg=none        guifg=gray
-- hi StatusLine     gui=none      guibg=lightgray   guifg=black
-- hi CursorLineNr   gui=none      guibg=none        guifg=black
-- hi NonText        ctermfg=12    gui=none          guifg=Blue
-- hi MoreMsg        ctermfg=2     gui=none          guifg=SeaGreen
-- hi ModeMsg        cterm=none    gui=none
-- hi Question       ctermfg=2     gui=none          guifg=SeaGreen
-- hi Title          ctermfg=5     gui=none          guifg=Magenta
-- hi DiffDelete     ctermfg=12    ctermbg=159       gui=none        guifg=Blue  guibg=LightCyan
-- hi DiffText       cterm=none    ctermbg=9         gui=none        guibg=Red
-- hi TabLineSel     cterm=none    gui=none
-- hi WinBar         cterm=none    gui=none
-- hi Statement      ctermfg=130   gui=none          guifg=Brown
-- hi Type           ctermfg=2     gui=none          guifg=SeaGreen
-- ]])


vim.cmd([[
  colo codedark
  hi GitSignsAdd    guifg=#587c0c guibg=none
  hi GitSignsChange guifg=#0c7d9d guibg=none
  hi GitSignsDelete guifg=#94151b guibg=none
]])