-- Custom statusline
function _G.statusline()
    local filepath = '%<%f %h%m%r'
    local align_section = '%='
    local file_encoding = '%{"[".(&fenc==""?&enc:&fenc).((exists("+bomb") && &bomb)?",B":"")."] "}'
    local file_format = '[%{&fileformat}]'
    local percentage_through_file = ' %3p%% '
    local column_and_line_number = '%3l→ ,%3c↓%='
    local filetype = '%y %q'
    return string.format(
        '%s%s%s%s%s%s%s%s',
        filepath,
        align_section,
        column_and_line_number,
        percentage_through_file,
        align_section,
        filetype,
        file_encoding,
        file_format
    )
end

if vim.fn.has("statusline") == 1 then
  vim.opt.statusline=_G.statusline()
end
