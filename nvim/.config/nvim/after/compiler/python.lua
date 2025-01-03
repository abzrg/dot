-- source: https://vi.stackexchange.com/a/16919/30665
vim.cmd([[
CompilerSet errorformat=
      \%*\\sFile\ \"%f\"\\,\ line\ %l\\,\ %m,
      \%*\\sFile\ \"%f\"\\,\ line\ %l,
CompilerSet makeprg=python3\ %
]])
