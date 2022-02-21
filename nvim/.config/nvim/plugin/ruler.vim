finish
"=====[ Improve ruler with various useful information]=================================
let g:BRF_new_rulerformat = '%40(%#Question# %v⇢ %l⇣ %= %{BRF_ErrStatus()}  %<%{BRF_WordCount()} %L⤓  %P%)'

function! BRF_ErrStatus()
    " Count errors and warnings in quickfix list...
    let [errors, warnings] = [0,0]
    for type in map(getqflist(), {key, val -> get(val, "type", "?")})
        if     type == "" || type == 'e'  |  let errors   += 1
        elseif               type == 'w'  |  let warnings += 1
        endif
    endfor

    " Count matches and distinct files in location list...
    let loclist  = getloclist(0)
    let matches  = len(loclist)
    let files    = {}
    for locelem in loclist
        let files[locelem.bufnr] = 1
    endfor
    let buffers  = len(files)

    " Generate report for ruler...
    let status = []
    if errors   | call add(status, errors   . 'ꜝ') | endif
    if warnings | call add(status, warnings . 'ʷ') | endif
    if matches  | call add(status, matches  . 'ᵐ ' . buffers . 'ᵇ') | endif

    return join(status, ' ')
endfunction

let g:BRF_interval = 1
function! BRF_WordCount()

    " Skip an increasing percentage of increasingly expensive updates, as the file gets longer...
    let g:BRF_interval += 1
    if exists("b:BRF_wordcount")
        let timestamp = get(b:,'BRF_timestamp', -1)
        if g:BRF_interval < b:BRF_wordcount / 500
            return b:BRF_wordcount . (timestamp == undotree().seq_cur ? '⁞' : '⁞̃' )
        endif
        let g:BRF_interval = 1
    endif

    " Otherwise, recount the file...
    if &modified || !exists("b:BRF_wordcount")
        let lines = join(getline(1,'$'), ' ')
        let lines = substitute(lines, '\d\.\d',         'X', 'g')
        let lines = substitute(lines, '\a[''-]\a',      'X', 'g')
        let lines = substitute(lines, '[[:alnum:]]\+',  'X', 'g')
        let lines = substitute(lines, '[^[:alnum:]]\+', '',  'g')
        let b:BRF_wordcount = strlen(lines)
        let b:BRF_timestamp = undotree().seq_cur
    endif

    " Return the precise count...
    return b:BRF_wordcount . '⁞'
endfunction

function! BRF_ToggleRuler ()
    if strlen(&rulerformat)
        let &rulerformat = ''
    else
        let &rulerformat = g:BRF_new_rulerformat
    endif
    set ruler
    redraw
endfunction

nmap <silent> ;w :silent call BRF_ToggleRuler()<CR><C-L>

let &rulerformat = g:BRF_new_rulerformat
set ruler
