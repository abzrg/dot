-------------------
-- SDCV in NeoVIM |
-------------------

-- Check sdcv is installed on system
if vim.fn.executable("sdcv") ~= 1 then
  print("sdcv is not installed.")
  return
end


local function normal_dict(word)
  -- Get the width of the window
  local winwidth = vim.fn.winwidth(0)
  if winwidth >= 80 then
    winwidth = 80
  end

  -- -- Create a split scratch buffer
  vim.cmd("botright split")
  local win = vim.api.nvim_get_current_win()
  local buf = vim.api.nvim_create_buf(true, true)
  vim.api.nvim_win_set_buf(win, buf)

  -- Buffer local settings
  vim.bo.buflisted = false
  vim.bo.buftype = "nofile"
  vim.bo.bufhidden = "wipe"
  vim.bo.swapfile = false
  vim.bo.textwidth = winwidth
  vim.wo.relativenumber = false
  vim.wo.number = false
  vim.wo.signcolumn = "no"

  -- Buffer local mappings
  --   source (nowait): https://vi.stackexchange.com/a/24555/30665
  vim.keymap.set("n", "q", "<cmd>q<CR>", { noremap = true, nowait = true, buffer = true })
  vim.keymap.set("n", "<Space>", "<C-f>", { noremap = true, nowait = true, buffer = true })
  vim.keymap.set("n", "<Shift><Space>", "<C-b>", { noremap = true, nowait = true, buffer = true })
  vim.keymap.set("n", "d", "<C-d>", { noremap = true, nowait = true, buffer = true })
  vim.keymap.set("n", "u", "<C-u>", { noremap = true, nowait = true, buffer = true })

  -- Put output of the external into split
  local cmd = {
    "sdcv", "-n", "--utf8-output", word, "2>&1",
  }

  vim.api.nvim_put(vim.fn.systemlist(table.concat(cmd, " ")), "", false, false)

  -- Clear output
  vim.cmd([[silent! %s/\v\<.?b\>//g]])
  vim.cmd([[silent! %s/\v\<br\>/\r/g]])
  vim.cmd([[silent! %s/\v\<[^>]*\>//g]])
  vim.cmd([[silent! %s/\/\//\r/g]])
  vim.cmd([[silent! %s/\v(\s+)--/\1● /g]])
  vim.cmd([[silent! %s/\v\~/●/g]])
  vim.cmd([[silent! %s/\s*$//g]])

  -- Format according to textwidth
  vim.cmd("silent g/./ normal gqq")

  -- Move to top
  vim.cmd("norm gg")

  -- Fill search register with the search query
  vim.cmd("/" .. word)

  vim.cmd("nohl")

  -- Better color support
  -- Vim regexp
  --   Non-greedy: .\{-} instead of .* (https://vi.stackexchange.com/a/199/30665)
  --   Multiline regexp: \_. instead of . (https://stackoverflow.com/a/784203/13041067)
  --   ignorecase: \c
  --   magic: \v
  --   word boundary: \<word\>
  vim.cmd [[
    syntax match NvimString "\~"
    syntax match NonText "\v\c^\d\d?"
    syntax match NonText "\v\csee also.+$"
    syntax match PmenuSel "\v\c<(-ing|-ed)>"
    syntax match PmenuSel "\v\c<(supp|poss|brd-neg)>"
    syntax match PmenuSel "\v\c<ADJ|ADV|PHR>\.?"
    syntax match PmenuSel "\v\c<noun|verb>"
    syntax match DiffAdd "\v\c<FORMAL|INFORMAL>"
    syntax match PmenuSel "\v\c<V-ed>"
    syntax match PmenuSel "\v\c<[pvn]>"
    syntax match DiffAdd " \zs\/[^ \/]*\/\ze "
    syntax match NonText "-->.*"
    syntax match String +●\_.\{-}\(\.\.\?\.\?\|?\|!\)$+
  ]]
  vim.cmd("syntax match DiffDelete +\\[[^\\]]*\\]+")
  vim.cmd("syntax match Question +\\c" .. word .. "+")
  vim.cmd("syntax match Question +\\c" .. word .. "+")

  vim.bo.readonly = true
  vim.bo.modifiable = false
  vim.wo.cursorline = false
end

-- Keybinding
vim.keymap.set("n", "<leader>?", function()
  normal_dict(vim.fn.expand("<cword>"))
end, { noremap = true })
