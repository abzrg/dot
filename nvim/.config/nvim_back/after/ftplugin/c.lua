-- Auto indent for c/c++ files (private: will be deindented)
--    source: https://stackoverflow.com/a/7623017/13041067
-- vim.opt.cindent         = true
vim.opt_local.cinoptions = vim.opt_local.cinoptions + 'g0' -- do not indent public/private/protected in c++ files

vim.opt_local.cindent = true

-- vim.opt_local.cinoptions:append({"g0", "#1s"})
-- actually keep the indentation of # directives in openfoam codes

-- local nnoremap = require("reverseila.utils.keymap").nnoremap
-- nnoremap("<leader>=", ":w <bar>silent! !clang-format -style=file -i %<CR>", {silent = true, buffer = true})

-- vim.opt_local.tabstop = 4
-- vim.opt_local.shiftwidth = 4
-- vim.opt_local.expandtab = false

vim.opt_local.number = true
vim.opt_local.relativenumber = true
vim.opt.signcolumn  = "yes"

-- fix switch case indentation
-- src: https://stackoverflow.com/a/3445040/13041067
vim.opt_local.cinoptions = vim.opt_local.cinoptions + { "l1" }

