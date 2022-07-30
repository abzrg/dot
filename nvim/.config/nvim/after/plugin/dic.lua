-- Check sdcv is installed on system
if vim.fn.executable("sdcv") ~= 1 then
    print("sdcv is not installed.")
    return
end


function normal_dict(word)
    -- Get the width of the window
    local winwidth = vim.fn.winwidth(0)
    if winwidth >= 80 then
        winwidth = 80
    end

    -- -- Create a split scratch buffer
    vim.api.nvim_command("botright split")
    local win = vim.api.nvim_get_current_win()
    local buf = vim.api.nvim_create_buf(true, true)
    vim.api.nvim_win_set_buf(win, buf)

    -- Buffer local settings
    vim.opt_local.buflisted = false
    vim.opt_local.buftype = "nofile"
    vim.opt_local.bufhidden = "wipe"
    vim.opt_local.swapfile = false
    vim.opt_local.textwidth = winwidth
    vim.opt_local.relativenumber = false
    vim.opt_local.number = false

    -- Buffer local mappings
    --   source (nowait): https://vi.stackexchange.com/a/24555/30665
    vim.api.nvim_buf_set_keymap(0, "n", "q", "<cmd>q<CR>", {noremap = true, nowait = true})
    vim.api.nvim_buf_set_keymap(0, "n", "<Space>", "<C-f>", {noremap = true, nowait = true})
    vim.api.nvim_buf_set_keymap(0, "n", "<Shift><Space>", "<C-b>", {noremap = true, nowait = true})
    vim.api.nvim_buf_set_keymap(0, "n", "d", "<C-d>", {noremap = true, nowait = true})
    vim.api.nvim_buf_set_keymap(0, "n", "u", "<C-u>", {noremap = true, nowait = true})

    -- Put output of the external into split
    local cmd = {
        "sdcv", "-n", "--utf8-output", word, "2>&1",
    }

    vim.api.nvim_put(vim.fn.systemlist(table.concat(cmd, " ")), "", false, false)

    -- Clear output
    vim.api.nvim_command([[silent! %s/\v\<.?b\>//g]])
    vim.api.nvim_command([[silent! %s/\v\<br\>/\r/g]])
    vim.api.nvim_command([[silent! %s/\v\<[^>]*\>//g]])
    vim.api.nvim_command([[silent! %s/\/\//\r/g]])
    vim.api.nvim_command([[silent! %s/\v(\s+)--/\1● /g]])
    vim.api.nvim_command([[silent! %s/\v\~/●/g]])
    vim.api.nvim_command([[silent! %s/\s*$//g]])

    -- Format according to textwidth
    vim.api.nvim_command("silent g/./ normal gqq")

    -- Move to top
    vim.api.nvim_command("norm gg")

    -- Fill search register with the search query
    vim.api.nvim_command("/" .. word)

    vim.api.nvim_command("nohl")

    -- Better color support
        -- Vim regexp
        --   Non-greedy: .\{-} instead of .* (https://vi.stackexchange.com/a/199/30665)
        --   Multiline regexp: \_. instead of . (https://stackoverflow.com/a/784203/13041067)
        --   ignorecase: \c
        --   magic: \v
        --   word boundary: \<word\>
    vim.cmd([[syntax match NvimString "\~"]])
    vim.cmd([[syntax match NonText "\v\c^\d\d?"]])
    vim.cmd([[syntax match NonText "\v\csee also.+$"]])
    vim.cmd([[syntax match PmenuSel "\v\c<(-ing|-ed)>"]])
    vim.cmd([[syntax match PmenuSel "\v\c<(supp|poss|brd-neg)>"]])
    vim.cmd([[syntax match PmenuSel "\v\c<ADJ|ADV|PHR>\.?"]])
    vim.cmd([[syntax match PmenuSel "\v\c<noun|verb>"]])
    vim.cmd([[syntax match DiffAdd "\v\c<FORMAL|INFORMAL>"]])
    vim.cmd([[syntax match PmenuSel "\v\c<V-ed>"]])
    vim.cmd([[syntax match PmenuSel "\v\c<[pvn]>"]])
    vim.cmd([[syntax match DiffAdd " \zs\/[^ \/]*\/\ze "]])
    vim.cmd("syntax match DiffDelete +\\[[^\\]]*\\]+")
    vim.cmd([[syntax match NonText "-->.*"]])
    vim.cmd("syntax match Question +\\c" .. word .. "+")
    vim.cmd("syntax match Question +\\c" .. word .. "+")
    vim.cmd([[syntax match String +●\_.\{-}\(\.\.\?\.\?\|?\|!\)$+]])

    vim.opt_local.readonly = true
    vim.opt_local.modifiable = false
    vim.opt_local.cursorline = false
end

local nnoremap = require("reverseila.utils.keymap").nnoremap

nnoremap("<leader>?", "", {callback = function()
    normal_dict(vim.fn.expand("<cword>"))
end})
