-- Jump to the last known cursor position
if vim.fn.has("autocmd") == 1 then
  vim.cmd([[ au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | endif ]])
end

-- Highlight yank
vim.cmd([[
augroup highlight_yank
autocmd!
au TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=400}
augroup END
]])

-- Auto resize splits upon window resize
vim.cmd([[autocmd vimResized * execute "normal! \<C-w>="]])

-- Turn off paste mode when leaving insert
vim.cmd([[autocmd InsertLeave * set nopaste]])

-- Runs a script that cleans out tex build files whenever I close out of a .tex file.
vim.cmd([[autocmd VimLeave *.tex !texclear %]])

-- Automatically quit Vim if quickfix window is the last
vim.cmd([[
au BufEnter * call QuitIfQuickfixIsLastWindow()
function! QuitIfQuickfixIsLastWindow()
" if the window is quickfix go on
if &buftype=="quickfix"
  " if this window is last on screen quit without warning
  if winnr('$') < 2
    quit
    endif
    endif
    endfunction
]])

-- xrdb update on save
vim.cmd([[
autocmd BufRead,BufNewFile xresources,xdefaults set filetype=xdefaults
autocmd BufWritePost .Xresources,.Xdefaults,.xresources,.xdefaults !xrdb %
]])

-- File types
vim.cmd([[
au BufNewFile,BufRead *.es6 setf javascript
au BufNewFile,BufRead *.tsx setf typescriptreact
au BufNewFile,BufRead *.md set filetype=markdown
au BufNewFile,BufRead *.flow set filetype=javascript
au BufNewFile,BufRead *.rss,*.atom setfiletype xml
set suffixesadd=.js,.es,.jsx,.json,.css,.less,.sass,.styl,.php,.py,.md
au FileType coffee setlocal shiftwidth=2 tabstop=2
au FileType ruby setlocal shiftwidth=2 tabstop=2
au FileType yaml setlocal shiftwidth=2 tabstop=2
]])

--  Better help
vim.cmd([[
" Open help in a new tab instead of a split
augroup HelpInTabs
autocmd!
autocmd BufEnter *.txt call HelpInNewTab()
augroup END

function! HelpInNewTab()
if &buftype == 'help'
  "Convert the help window to a tab...
  execute "normal \<C-W>T"
  endif
  endfunction
]])

-- openfoam
vim.cmd([[

augroup OpenFoam
autocmd!
autocmd BufEnter,BufReadPost,BufRead *.C :setlocal path+=~/OpenFOAM/OpenFOAM-7/**
autocmd BufEnter,BufReadPost,BufRead *.H :setlocal path+=~/OpenFOAM/OpenFOAM-7/**
autocmd BufEnter,BufReadPost,BufRead,BufNewFile $HOME/OpenFOAM/** :LspStop
augroup END

]])

vim.cmd('autocmd Filetype text set commentstring="%s')

vim.cmd([[

autocmd BufEnter,BufReadPost,BufRead *.tsv :setfiletype tsv
autocmd BufEnter,BufReadPost,BufRead *.csv :setfiletype csv

]])
