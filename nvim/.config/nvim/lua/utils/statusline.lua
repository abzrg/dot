local fn = vim.fn
local api = vim.api

local M = {}

-- possible values are 'arrow' | 'rounded' | 'blank'
local active_sep = 'blank'

-- change them if you want to different separator
M.separators = {
  arrow = { '', '' },
  rounded = { '', '' },
  blank = { '', '' },
}

-- highlight groups
M.colors = {
  active        = '%#StatusLine#',
  inactive      = '%#StatuslineNC#',
  mode          = '%#Mode#',
  git           = '%#Git#',
  filename      = '%#FileName#',
  filetype      = '%#FileType#',
  line_col      = '%#LineCol#',
}

M.trunc_width = setmetatable({
  mode       = 80,
  git_status = 90,
  filename   = 140,
  filedir   = 140,
  line_col   = 60,
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
  local signs = vim.b.gitsigns_status_dict or {head = '', added = 0, changed = 0, removed = 0}
  local is_head_empty = signs.head ~= ''

  if self:is_truncated(self.trunc_width.git_status) then
    return is_head_empty and string.format('  %s ', signs.head or '') or ''
  end

  return is_head_empty and string.format(
    ' +%s ~%s -%s |  %s |',
    signs.added, signs.changed, signs.removed, signs.head
  ) or ''
end



M.get_filedir = function(self)
    if vim.fn.bufname() == '' then
        return ''
    end
    if self:is_truncated(self.trunc_width.filedir) then return "" end
    return "%<%{expand('%:p:h')}/"
end

M.get_filename = function(self)
  if self:is_truncated(self.trunc_width.filename) then return " %<%f " end
  return "%<%t"
end


M.get_filetype = function()
  local file_name, file_ext = fn.expand("%:t"), fn.expand("%:e")
  local icon = require'nvim-web-devicons'.get_icon(file_name, file_ext, { default = true })
  local filetype = vim.bo.filetype

  if filetype == '' then return '' end
  return string.format(' %s %s  |', icon, filetype):lower()
end

M.get_line_col = function(self)
  if self:is_truncated(self.trunc_width.line_col) then return ' %l:%c ' end
  return ' Ln %4l, Col %4c, %P '
end


M.set_active = function(self)
  local colors = self.colors
  local git = colors.git .. self:get_git_status()
  local filename = colors.active .. self:get_filedir() .. colors.filename .. self:get_filename()
  local filetype = colors.filetype .. self:get_filetype()
  local line_col = colors.line_col .. self:get_line_col()

  return table.concat({
      colors.active,
      filename, "%=",
      git,
      filetype, line_col
  })
end

M.set_inactive = function(self)
  return self.colors.inactive .. '%= %F %='
end

M.set_explorer = function(self)
  local title = self.colors.mode .. '   '
  local title_alt = self.colors.mode_alt .. self.separators[active_sep][2]

  return table.concat({ self.colors.active, title, title_alt })
end

Statusline = setmetatable(M, {
  __call = function(statusline, mode)
    if mode == "active" then return statusline:set_active() end
    if mode == "inactive" then return statusline:set_inactive() end
    if mode == "explorer" then return statusline:set_explorer() end
  end
})

-- set statusline
-- TODO: replace this once we can define autocmd using lua
api.nvim_exec([[
  augroup Statusline
  au!
  au WinEnter,BufEnter * setlocal statusline=%!v:lua.Statusline('active')
  au WinLeave,BufLeave * setlocal statusline=%!v:lua.Statusline('inactive')
  augroup END
]], false)


-- -- thanks to: https://elianiva.my.id/post/neovim-lua-statusline
--
-- -- usage: require('utils.statusline')
