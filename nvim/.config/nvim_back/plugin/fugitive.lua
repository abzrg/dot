vim.keymap.set("n", "<space>gs", ":G<cr>")

-- Don't list fugitive buffers
local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

local fugitive = augroup("fugitive", { clear = true })

-- autocmd("FileType", {
--   pattern = "fugitive",
--   callback = function()
--     vim.bo.nobuflisted = true
--   end,
--   group = fugitive,
-- })

autocmd("BufReadPost", {
  pattern = "*.git/index",
  callback = function()
    vim.bo.nobuflisted = true
  end,
  group = fugitive,
})
