nnoremap <leader>= :w <bar>call system("clang-format -style=file -i " . expand('%')) <bar> edit<CR>

setlocal commentstring=//\ %s
" setlocal noexpandtab
" setlocal ts=8 sw=8

setlocal path=**
setlocal path+=/opt/homebrew/Cellar/llvm/16.0.6/include/c++/v1/,/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk/usr/include/


