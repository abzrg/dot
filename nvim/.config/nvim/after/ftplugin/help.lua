vim.wo.list = false

local group = vim.api.nvim_create_augroup("HelpTextWidthEighty", { clear = true })
vim.api.nvim_create_autocmd({ "FileType", "BufWinEnter" }, {
  pattern = { "help", "*" },
  callback = function()
    vim.bo.textwidth = 80
  end,
  group = group
})
