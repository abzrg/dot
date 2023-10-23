vim.opt_local.number = true
vim.opt_local.relativenumber = true
vim.opt.signcolumn  = "yes"

vim.opt_local.cinoptions= { "l1" }
vim.opt_local.cinoptions = vim.opt_local.cinoptions + 'g0' -- do not indent public/private/protected in c++ files
