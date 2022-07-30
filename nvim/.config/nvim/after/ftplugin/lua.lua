vim.opt_local.tabstop = 2
vim.opt_local.shiftwidth = 2
vim.opt_local.expandtab = true

local nnoremap = require("reverseila.utils.keymap").nnoremap

nnoremap("<leader>=", "", {
  buffer = true,
  callback = function()
    vim.cmd("write")
    vim.cmd("execute 'lua vim.lsp.buf.format{async=false}'")
    vim.cmd("write")
  end })
