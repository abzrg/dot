" The problem is if there is only one error in the buffer, and in the qflist it
" is pointed on that error, in the buffer if you move past that error you cannot
" jump back with ]q, or jump forward with [q.
function! UnimparedCycleNext() abort
    try
        cnext
    catch
        cc
    endtry
endfunction

function! UnimparedCyclePrevious() abort
    try
        cprev
    catch
        cc
    endtry
endfunction

nnoremap ]q :call UnimparedCycleNext()<CR>
nnoremap [q :call UnimparedCyclePrevious()<CR>
