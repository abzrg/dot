" Add fzf to vim runtime
set rtp+=/opt/homebrew/opt/fzf

let g:fzf_layout = {
            \ 'down':'~40%',
            \ 'window': {
                \ 'width': 0.8,
                \ 'height': 0.8,
                \ 'yoffset':0.5,
                \ 'xoffset': 0.5,
                \ 'highlight': 'Todo',
                \ 'border': 'sharp'}}

" let g:fzf_layout = { 'down': '~40%' }

" Disable line numbering in fzf buffer
autocmd TermOpen * setlocal nonumber nornu signcolumn=no

function! s:IsGitRepo() abort
    silent! !git rev-parse --is-inside-work-tree
    return v:shell_error
endfunction
" If inside a git repo run GitFiles instead of Files
nnoremap <expr> ;f (<SID>IsGitRepo() == 0) ? ':GitFiles<cr>' : ':Files<cr>'

" nnoremap ;j  :Buffers<cr>
" nnoremap ;r  :Rg<CR>
" nnoremap ;o  :History<CR>
" nnoremap ;;  :Helptags<CR>
" nnoremap ;n  :Files ~/Documents/Notes/<CR>
" nnoremap ;c  :FZFDotFiles<CR>

" Fix linger/delay exiting with ESC
autocmd! FileType fzf tnoremap <buffer> <Esc> <C-c>

" Replace the default dictionary completion with fzf-based fuzzy completion
inoremap <expr> <c-x><c-k> fzf#vim#complete('cat /usr/share/dict/words')

" Global line completion (not just open buffers. ripgrep required.)
inoremap <expr> <c-x><c-l> fzf#vim#complete(fzf#wrap({
  \ 'prefix': '^.*$',
  \ 'source': 'rg -n ^ --color always',
  \ 'options': '--ansi --delimiter : --nth 3..',
  \ 'reducer': { lines -> join(split(lines[0], ':\zs')[2:], '') }}))

" Easier Thesaurus
function! s:make_sentence(lines)
  return substitute(join(a:lines), '^.', '\=toupper(submatch(0))', '').'.'
endfunction

inoremap <expr> <c-x><c-s> fzf#vim#complete({
  \ 'source':  'cat /usr/share/dict/words',
  \ 'reducer': function('<sid>make_sentence'),
  \ 'options': '--multi --reverse --margin 15%,0',
  \ 'left':    20})

command! FZFDotFiles call fzf#run(fzf#wrap({
\   'options'    : '-m -x --preview="bat --color=always --style=plain {}"',
\   'sink'       : 'edit ',
\   'source'     : 'git --git-dir=$HOME/repos/dotfiles/ --work-tree=$HOME ls-tree --full-tree -r HEAD | awk \{print\ \$4\} | sed s\\^\\$HOME/\\',
\ }))

command! -nargs=? Apropos call
            \ fzf#run({'source': 'man -k -s 1 '.shellescape(<q-args>) .
            \ ' \ | cut -d " " -f 1', 'sink': 'tab Man',
            \ 'options': ['--preview', 'MANPAGER=cat MANWIDTH='.
            \ (winwidth(0)/2-4).' man {}']})
