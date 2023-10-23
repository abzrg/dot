vim.bo.spelllang = "en_us"
vim.opt_local.spell = true  -- window option
vim.bo.tabstop = 2
vim.bo.shiftwidth = 2
vim.opt_local.wrap = true  -- window option
vim.opt_local.number = false
vim.opt_local.relativenumber = false

vim.g.markdown_fenced_languages = { 'html', 'python', 'vim', 'cpp', 'c', 'sh' }


vim.cmd([[
let b:surround_{char2nr('c')} = "```\1Language: \1\r```"
]])
