local api = vim.api

-- We need gitsigns
local status_ok, gitsigns = pcall(require, "gitsigns")
if not status_ok then
  return
end

local M = {}


-- Highlight groups
M.colors = {
  left            = '%#LeftStatusline#',
  left_powerline  = '%#LeftPowerlineStatusline#',
  right_powerline = '%#RightPowerlineStatusline#',
  sep_right       = '%#SeparatorRight#',
  active          = '%#StatusLine#',
  inactive        = '%#StatuslineNC#',
  mode            = '%#Mode#',
  git             = '%#Git#',
  filename        = '%#FileName#',
  filetype        = '%#FileType#',
  line_col        = '%#LineCol#',
}

-- Specify the width to which compents should be truncated
M.trunc_width = setmetatable({
  mode       = 80,
  git_status = 90,
  filename   = 80,
  filedir    = 80,
  line_col   = 80,
}, {
  __index = function()
    return 80
  end
})

M.is_truncated = function(_, width)
  local current_width = api.nvim_win_get_width(0)
  return current_width < width
end

M.get_git_status = function(self)
  -- use fallback because it doesn't set this variable on the initial `BufEnter`
  local signs = vim.b.gitsigns_status_dict or { head = '', added = 0, changed = 0, removed = 0 }
  local is_head_empty = signs.head ~= ''

  if self:is_truncated(self.trunc_width.git_status) then
    return is_head_empty and string.format(' (%s) ', signs.head or '') or ''
  end

  return is_head_empty and string.format(
    ' (%s) ', signs.head
  -- ' (%s) +%s ~%s -%s |',
  -- signs.head, signs.added, signs.changed, signs.removed
  ) or ''
end

-- Get directory name of the current buffer
M.get_dir = function(self)
  if vim.fn.bufname() == '' then
    return ''
  end
  if self:is_truncated(self.trunc_width.filedir) then return "" end

  -- Don't print ./init.lua; only init.lua
  local dirname = vim.fn.expand("%:h")
  if dirname == "." then
    return ''
  end

  -- If it's a help buffer don't bother to show dir path
  if vim.bo.filetype == "help" then
    return ""
  end

  return "%<%{expand('%:h')}/"
end

-- Get filename of the current buffer
M.get_filename = function()
  return "%<%t"
end

-- Get status of the file
M.get_filestat = function()
  return " %r%h%w%q%y%m"
end


-- Get line number and column Number
M.get_line_col = function()
  local rhs = ' '

  if vim.fn.winwidth(0) > 80 then
    local column = vim.fn.virtcol('.')
    local width = vim.fn.virtcol('$')
    local line = vim.api.nvim_win_get_cursor(0)[1]
    local height = vim.api.nvim_buf_line_count(0)

    -- Add padding to stop RHS from changing too much as we move the cursor.
    local padding = #tostring(height) - #tostring(line)
    if padding > 0 then
      rhs = rhs .. (' '):rep(padding)
    end

    rhs = rhs .. 'l: ' -- (Literal, \u2113 "SCRIPT SMALL L").
    rhs = rhs .. line
    rhs = rhs .. '/'
    rhs = rhs .. height
    rhs = rhs .. ' c: ' -- (Literal, \u1d68c "MATHEMATICAL MONOSPACE SMALL C").
    rhs = rhs .. column
    rhs = rhs .. '/'
    rhs = rhs .. width
    rhs = rhs .. ' '

    -- Add padding to stop rhs from changing too much as we move the cursor.
    if #tostring(column) < 2 then
      rhs = rhs .. ' '
    end
    if #tostring(width) < 2 then
      rhs = rhs .. ' '
    end
  else
    rhs = "𝚌 %2c"
  end

  return rhs
end

-- Left separator
-- source: @wincent
M.left_padding = function()
  local signcolumn = 0
  local option = vim.wo.signcolumn
  if option == 'yes' then
    signcolumn = 2
  elseif option == 'auto' then
    local signs = vim.fn.sign_getplaced('')
    if #signs[1].signs > 0 then
      signcolumn = 2
    end

    -- Check if there is any diagnostics
    if vim.diagnostic.get_next() then
      signcolumn = 2
    end

    -- Check if gitsigns is present
    if gitsigns.get_hunks() ~= nil and #(gitsigns.get_hunks()) ~= 0 then
      signcolumn = 2
    end
  end

  -- Determine the number width
  local num_width = 0
  local minwidth = 2
  local numberwidth = vim.wo.numberwidth
  local row = vim.api.nvim_buf_line_count(0)
  if vim.wo.number == true or vim.wo.relativenumber == true then
    num_width = math.max((#tostring(row) + 1), minwidth, numberwidth)
  end

  -- check for commandline window
  local commandline_window = 0
  if vim.fn.bufexists("[Command Line]") == 1 then
    commandline_window = 1
  end

  local gutterwidth = num_width + signcolumn + commandline_window
  local padding = (' '):rep(gutterwidth)
  if vim.bo.filetype == "help" then
    padding = " "
  end
  return padding
end

-------------------------------------------------------------------------------

-- Set active statusline
M.set_active = function(self)
  local colors = self.colors
  local left_sep = colors.left .. self:left_padding()
  local git = colors.git .. self:get_git_status()
  local filename = colors.active .. self:get_dir() .. colors.filename .. self:get_filename()
  local filestat = colors.active .. self:get_filestat()
  -- local filetype = colors.filetype .. self:get_filetype()
  local line_col = colors.line_col .. self:get_line_col()

  return table.concat({
    left_sep,
    colors.left_powerline,
    '|',
    colors.active,
    " ",
    filename,
    filestat,
    "%=",
    git,
    -- filetype,
    colors.right_powerline,
    '|',
    colors.active,
    colors.line_col,
    line_col
  })
end

-- Set inactive statusline
M.set_inactive = function(self)
  return self.colors.inactive .. '%= %f %='
end


Statusline = setmetatable(M, {
  __call = function(statusline, mode)
    if mode == "active" then return statusline:set_active() end
    if mode == "inactive" then return statusline:set_inactive() end
  end
})

-- set statusline
-- TDO: replace this once we can define autocmd using lua
api.nvim_exec([[
augroup Statusline
au!
" Without BufReadPost quickfix list buffers won't have this custom statusline when opened via :copen
au WinEnter,BufEnter,FocusGained,BufReadPost * setlocal statusline=%!v:lua.Statusline('active')
au WinLeave,BufLeave,FocusLost * setlocal statusline=%!v:lua.Statusline('inactive')
augroup END
]], false)


-- -- thanks to: https://elianiva.my.id/post/neovim-lua-statusline
--
-- -- usage: require('reverseila.utils.statusline')
