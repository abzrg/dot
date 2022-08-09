-- Open github handles with gx
-- source: https://sbulav.github.io/vim/neovim-opening-github-repos/

local function url_repo()
  local cursorword = vim.fn.expand "<cfile>"
  if string.find(cursorword, "^[a-zA-Z0-9.-]*/[a-zA-Z0-9.-]*$") then
    cursorword = "https://github.com/" .. cursorword
  end
  return cursorword or ""
end

local open_command = "xdg-open"
if vim.fn.has "mac" == 1 then
  open_command = "open"
end
vim.keymap.set("n", "gx", function()
  vim.fn.jobstart({ open_command, url_repo() }, { detach = true })
end, { silent = true })
