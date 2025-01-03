-- source: https://ejmastnak.github.io/tutorials/vim-latex/compilation.html
-- The code code sets Vim's errorformat for compiling LaTeX.
-- Important: The errorformat used below works only if the LaTeX source 
-- file is compiled with pdflatex's `-file-line-error` option enabled.

-- Match file name
vim.bo.errorformat = '%-P**%f'
vim.bo.errorformat = vim.bo.errorformat .. '%-P**"%f"'

-- Match LaTeX errors
vim.bo.errorformat = vim.bo.errorformat .. [[%E! LaTeX %trror: %m]]
vim.bo.errorformat = vim.bo.errorformat .. [[%E%f:%l: %m]]
vim.bo.errorformat = vim.bo.errorformat .. [[%E! %m]]

-- More info for undefined control sequences
vim.bo.errorformat = vim.bo.errorformat .. [[%Z<argument> %m]]

-- More info for some errors
vim.bo.errorformat = vim.bo.errorformat .. [[%Cl.%l %m]]

-- Catch-all to ignore unmatched lines
vim.bo.errorformat = vim.bo.errorformat .. [[%-G%.%#]]
