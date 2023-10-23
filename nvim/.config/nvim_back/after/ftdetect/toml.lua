-- local autocmd = vim.api.nvim_create_autocmd
-- local augroup = vim.api.nvim_create_augroup
-- -- Detect .cfg as toml file
-- local ft_detect_cfg_as_toml = augroup("FTCFGTOML", { clear = true })
-- autocmd({ "BufNewFile", "BufRead" }, {
--   pattern = "*.cfg",
--   command = vim.cmd('setlocal ft=toml'),
--   group = ft_detect_cfg_as_toml,
-- })

