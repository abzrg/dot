vim.opt.autoread        = true
-- vim.opt.number          = true       -- show line numbers
-- vim.opt.relativenumber  = true       -- show relative numbers
vim.opt.cursorline      = true       -- highlight current line
vim.opt.cursorcolumn    = false
vim.opt.hidden          = true        -- allows you to hide buffers with unsaved changes without being prompted
vim.opt.hlsearch        = true        -- highlight search items
vim.opt.ignorecase      = true        -- case insensitive search
vim.opt.infercase       = true
vim.opt.backup          = false
vim.opt.equalalways     = false
vim.opt.joinspaces      = false       -- don't autoinsert two spaces after '.', '?', '!' for join command
vim.opt.showmatch       = false
vim.opt.showmode        = false
vim.opt.swapfile        = false       -- don't create swap file
vim.opt.emoji           = false       -- don't assume all emoji are double width
vim.opt.lazyredraw      = false        -- don't bother updating screen during macro playback
vim.opt.wrap            = false
vim.opt.writebackup     = false
vim.opt.smartcase       = true
vim.opt.splitbelow      = true        -- open horizontall splits to the below of the current window
vim.opt.splitright      = true        -- open verticall splits to the right of the current window
vim.opt.termguicolors   = true
vim.opt.title           = true
vim.opt.virtualedit     = 'block'     -- allow cursor to move where there is no text in visual block mode
vim.opt.signcolumn      = 'number'
vim.opt.inccommand      = 'split'     -- live preview of :s results
vim.opt.mouse           = 'a'         -- enable mouse
vim.opt.scrolloff       = 3           -- start scroll 3 lines before edge of the viewport
vim.opt.sidescrolloff   = 3
vim.opt.pumblend        = 0           -- pseudo-transparency for pop-up menu
vim.opt.laststatus      = 3           -- always show status line
vim.opt.cmdheight       = 1
vim.opt.updatetime      = 500         -- CursorHold interval
vim.opt.textwidth       = 80          -- automatically hard wrap at 120 columns
-- vim.opt.pumheight       = 10          -- Makes pop up-menu smaller
-- vim.opt.pumwidth        = 10          -- Makes pop up-menu smaller


vim.g.ruler             = true
vim.g.rulerformat       = [[ %m%=%l,%c%V%=%P ]]

-- Help nvim+fugitive be a faster experience
vim.opt.shell = "/bin/zsh"

vim.opt.path            = '**'        -- Fuzzy find files like a boss!
vim.opt.path            = vim.opt.path + vim.fn.expand('~/.config/nvim')

vim.opt.isfname         = vim.opt.isfname - '='          -- Avoid recognizing = as part of file name
vim.opt.iskeyword       = vim.opt.iskeyword + '-'        -- treat dash separated words as a word text object

vim.opt.shortmess = 'filnxtToOIc'

vim.opt.completeopt = 'menuone'                          -- show menu even if there is only one candidate
vim.opt.completeopt = vim.opt.completeopt + 'noselect'   -- don't automatically select candidate
vim.opt.clipboard   = vim.opt.clipboard + 'unnamedplus'  -- communicate with system clipboard

vim.opt.fileformat    = 'unix'
vim.opt.encoding      = 'utf-8'
vim.opt.fileencodings = { 'utf-8', 'sjis', 'euc-jp', 'latin' }

vim.opt.wildignore      = vim.opt.wildignore + {    -- patterns to ingore durng file navigation
'*.git/*', '*.tags', 'tags', '*.o', '*.class'
}
vim.opt.wildignorecase  = true
vim.opt.wildmenu        = true                      -- show options as list when switching to buffers etc
vim.opt.wildmode        = {                         -- shell-like autocomplete to unambigious portion
'longest', 'list', 'full'
}
vim.opt.wildchar        = 9                         -- ('<Tab>') character to trigger wildcard expansion
vim.opt.wildcharm       = 26                        -- ('<C-z>') substitue for 'wildchar' in macros

if root then
    vim.opt.undofile  = false                             -- don't create root-owned files
else
    vim.opt.undodir   = vim.fn.expand(                    -- keep undo file out of the way
    '~/.local/share/nvim/undo/')
    vim.opt.undodir   = vim.opt.undodir + '.'             -- fallback
    vim.opt.undofile  = true                              -- use undo files
end

vim.opt.autoindent  = true          -- maintain indent of current line
vim.opt.tabstop     = 4             -- spaces per tab
vim.opt.shiftwidth  = 4
vim.opt.expandtab   = true          -- always use tabs instead of spaces
vim.opt.smarttab    = true          -- <tab>/<BS> indent/deindent in loading whitespace
if vim.v.progname  ~= 'vi' then     -- if not using vi (use vim.v to access vim variable)
    vim.opt.softtabstop = -1            -- use 'shiftwidth' for tab/bs at end of line
end

-- Auto indent for c/c++ files (private: will be deindented)
--    source: https://stackoverflow.com/a/7623017/13041067
-- vim.opt.cindent         = true
-- vim.opt.cinoptions      = vim.opt.cinoptions + 'g0' -- do not indent public/private/protected in c++ files
-- vim.opt.cinoptions      = vim.opt.cinoptions + '#1s' -- actually keep the indentation of # directives in openfoam codes
vim.cmd([[
augroup CIndentation
autocmd!
autocmd Filetype c,cpp set cindent
autocmd Filetype c,cpp set cinoptions+=g0
augroup END
]])

vim.opt.fillchars       = {
    diff                  = '∙',       -- BULLET OPERATOR (U+2219, UTF-8: E2 88 99)
    -- eob                   = ' ',       -- NO-BREAK SPACE (U+00A0, UTF-8: C2 A0) to suppress ~ at EndOfBuffer
    fold                  = ' ',       -- Space
    vert                  = '┃',       -- BOX DRAWINGS HEAVY VERTICAL (U+2503, UTF-8: E2 94 83)
}

vim.opt.list = true
vim.opt.listchars = {
    nbsp                  = '¬',       -- NOT SIGN (U+00AC, UTF-8: C2 AC)
    extends               = '»',       -- RIGHT-POINTING DOUBLE ANGLE QUOTATION MARK (U+00BB, UTF-8: C2 BB)
    precedes              = '«',       -- LEFT-POINTING DOUBLE ANGLE QUOTATION MARK (U+00AB, UTF-8: C2 AB)
    tab                   = '▸ ',      -- BLACK RIGHT-POINTING SMALL TRIANGLE (U+25B8, UTF-8: E2 96 B8)
    trail                 = '•',       -- BULLET (U+2022, UTF-8: E2 80 A2)
}
vim.cmd([[
augroup HelpNoListChars
autocmd!
autocmd FileType help setlocal nolist
augroup END
]])

-- -- Fold settings
vim.opt.foldmethod = 'marker'
vim.cmd([[
function! MyFoldText()
let line = getline(v:foldstart)
return line . ' ▼ '
endfunction
set foldtext=MyFoldText()
]])

-- VSCode
if not vim.fn.exists('g:vscode') and vim.fn.has("nvim") then
    vim.opt.modifiable = true
end
