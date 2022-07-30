-- Installation: npm i -g bash-language-server

return {
  cmd = { "bash-language-server", "start" },
  cmd_env = { GLOB_PATTERN = "*@(.sh|.inc|.bash|.command)" },
  filetypes = { "sh", "zsh" }
}
