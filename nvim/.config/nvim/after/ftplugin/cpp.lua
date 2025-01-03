vim.cmd [[
" https://stackoverflow.com/a/3021157/13041067

" Don't indent namespace and template
function! CppNoNamespaceAndTemplateIndent()
    let l:cline_num = line('.')
    let l:cline = getline(l:cline_num)
    let l:pline_num = prevnonblank(l:cline_num - 1)
    let l:pline = getline(l:pline_num)
    while l:pline =~# '\(^\s*{\s*\|^\s*//\|^\s*/\*\|\*/\s*$\)'
        let l:pline_num = prevnonblank(l:pline_num - 1)
        let l:pline = getline(l:pline_num)
    endwhile
    let l:retv = cindent('.')
    let l:pindent = indent(l:pline_num)
    if l:pline =~# '^\s*template\s*\s*$'
        let l:retv = l:pindent
    elseif l:pline =~# '\s*typename\s*.*,\s*$'
        let l:retv = l:pindent
    elseif l:cline =~# '^\s*>\s*$'
        let l:retv = l:pindent - &shiftwidth
    elseif l:pline =~# '\s*typename\s*.*>\s*$'
        let l:retv = l:pindent - &shiftwidth
    elseif l:pline =~# '^\s*namespace.*'
        let l:retv = 0
    endif
    return l:retv
endfunction

if has("autocmd")
    autocmd BufEnter *.{cc,cxx,cpp,h,hh,hpp,hxx} setlocal indentexpr=CppNoNamespaceAndTemplateIndent()
endif
]]

-- vim.cmd.highlight "@lsp.type.namespace.cpp guifg=#bdb76b"
-- vim.cmd.highlight "cType gui=italic guifg=#4ec9b0"
-- vim.cmd.highlight "cppStructure gui=italic guifg=#b5cea8"
-- vim.cmd.highlight "cStructure gui=italic guifg=#b5cea8"
-- vim.cmd.highlight "@lsp.type.property.cpp guifg=#8DB6DF"
-- vim.cmd.highlight "@lsp.type.method.cpp guifg=#ff8000"
-- vim.cmd.highlight "@lsp.type.function.cpp guifg=#ffd700"


-- vim.cmd.highlight "@keyword.modifier.cpp gui=italic guifg=#ce9178"
-- vim.cmd.highlight "@constant.builtin.cpp guifg=#f44747"


-- vim.opt.foldmethod      = 'expr'
local treesitter_parsers = require('nvim-treesitter.parsers')

if treesitter_parsers.has_parser "cpp" then
  local folds_query = [[
    [
      (function_definition)
      (class_specifier)
    ] @fold
  ]]

  require("vim.treesitter.query").set("cpp", "folds", folds_query)
end

-- vim.keymap.set('i', ';;', '::', { nowait = true, noremap = true, silent = true, buffer = true })
