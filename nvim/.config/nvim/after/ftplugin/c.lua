-- Auto indent for c/c++ files (private: will be deindented)
--    source: https://stackoverflow.com/a/7623017/13041067
-- vim.opt.cindent         = true
vim.opt.cinoptions      = vim.opt.cinoptions + 'g0' -- do not indent public/private/protected in c++ files

vim.opt_local.cindent = true
vim.opt_local.cinoptions:append({"g0", "#1s"})
 -- actually keep the indentation of # directives in openfoam codes


local nnoremap = require("reverseila.utils.keymap").nnoremap
nnoremap("<leader>=", ":w <bar>silent! !clang-format -style=file -i %<CR>", {silent = true, buffer = true})

