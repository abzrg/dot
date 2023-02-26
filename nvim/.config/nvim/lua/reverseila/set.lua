-- [ Disable netrw ] --------------------------

-- vim.g.loaded_netrw = 1
-- vim.g.loaded_netrwPlugin = 1


-- [ Line Numbers ] --------------------------

vim.opt.number         = false
vim.opt.relativenumber = false


-- [ Indentation ] --------------------------

vim.opt.autoindent = true -- maintain indent of current line
vim.opt.expandtab  = true -- always use tabs instead of spaces
vim.opt.smarttab   = true -- <tab>/<BS> indent/deindent in loading whitespace
vim.opt.shiftwidth = 4
vim.opt.tabstop    = 4 -- spaces per tab


-- [ Search ] --------------------------

vim.opt.hlsearch   = true
vim.opt.ignorecase = true
vim.opt.incsearch  = true
vim.opt.smartcase  = true


-- [ Scroll ] --------------------------

vim.opt.scrolloff     = 8 -- start scroll 3 lines before edge of the viewport
vim.opt.sidescrolloff = 3


-- [ Splits ] --------------------------

vim.opt.splitbelow = true -- open horizontal splits below current window
vim.opt.splitright = true -- open vertical splits to the right of the current window


-- [ Backup ] --------------------------

vim.opt.backup      = false
vim.opt.swapfile    = false -- don't create swap file
vim.opt.writebackup = false


-- [ Path ] --------------------------

vim.opt.path = "**"
vim.opt.path:append(vim.fn.expand("$HOME/.config/nvim"))


-- [ Wild Menu ] --------------------------

vim.opt.wildmenu       = true -- show options as list when switching to buffers etc
vim.opt.wildignorecase = true
vim.opt.wildchar       = 9 -- ('<Tab>') character to trigger wildcard expansion
vim.opt.wildcharm      = 26 -- ('<C-z>') substitue for 'wildchar' in macros

-- shell-like autocomplete to unambigious portion
vim.opt.wildmode = {
    'longest', 'list', 'full'
}

-- patterns to ingore durng file navigation
vim.opt.wildignore:append({
    '*.git/*', '*.tags', 'tags', '*.o', '*.class'
})


-- [ Undo-Files ] --------------------------

if root then
    vim.opt.undofile = false -- Don't create root-owned files
else
    vim.opt.undofile = true
    -- Keep undo file out of the way
    -- (Check if the undodir exist. If not create one)
    local undo_dir = "$XDG_CACHE_HOME/nvim/undo/"
    if not vim.fn.isdirectory(undo_dir) then
        print("No undo directory. Creating one in " .. undo_dir .. ".")
        vim.fn.system("mkdir -p " .. undo_dir)
    end
    vim.opt.undodir = vim.fn.expand(undo_dir)
    vim.opt.undodir:append(".") -- fallback
end


-- [ Special Characters ] --------------------------

vim.opt.fillchars = {
    diff = "∙", -- BULLET OPERATOR (U+2219, UTF-8: E2 88 99)
    -- eob  = " ", -- NO-BREAK SPACE (U+00A0, UTF-8: C2 A0) to suppress ~ at EndOfBuffer
    fold = " ", -- Space
    vert = "┃", -- BOX DRAWINGS HEAVY VERTICAL (U+2503, UTF-8: E2 94 83)
}

vim.opt.list = true
vim.opt.listchars = {
    nbsp     = '¬', -- NOT SIGN (U+00AC, UTF-8: C2 AC)
    extends  = '»', -- RIGHT-POINTING DOUBLE ANGLE QUOTATION MARK (U+00BB, UTF-8: C2 BB)
    precedes = '«', -- LEFT-POINTING DOUBLE ANGLE QUOTATION MARK (U+00AB, UTF-8: C2 AB)
    tab      = '▸ ', -- BLACK RIGHT-POINTING SMALL TRIANGLE (U+25B8, UTF-8: E2 96 B8)
    trail    = '•', -- BULLET (U+2022, UTF-8: E2 80 A2)
}


-- [ Misc. ] --------------------------

vim.opt.showcmd = true
vim.opt.showbreak = '↪ ' -- ↳ DOWNWARDS ARROW WITH TIP RIGHTWARDS (U+21B3, UTF-8: E2 86 B3)
vim.opt.linebreak = true
vim.opt.cmdheight   = 1
vim.opt.laststatus  = 3
-- vim.opt.ruler       = true
-- vim.opt.rulerformat = [[%30(%{FugitiveStatusline()}%=%l,%c%V   %P%)]]
vim.opt.textwidth   = 80 -- automatically hard wrap at 120 columns
vim.opt.updatetime  = 250 -- CursorHold interval

vim.opt.wrap          = false
vim.opt.cursorline    = true
vim.opt.equalalways   = false
vim.opt.joinspaces    = false -- don't autoinsert two spaces after '.', '?', '!' for join command
vim.opt.lazyredraw    = false -- don't bother updating screen during macro playback
vim.opt.showmatch     = false
vim.opt.showmode      = false
vim.opt.termguicolors = true
vim.opt.title         = true

-- vim.opt.guicursor       = ""
vim.opt.encoding    = "utf-8"
vim.opt.fileformat  = "unix"
-- vim.opt.foldmethod      = 'indent'
vim.opt.inccommand  = "split" -- live preview of :s results
vim.opt.mouse       = "a" -- enable mouse
vim.opt.shell       = "zsh"
vim.opt.shortmess   = "filnxtToOcI"
vim.opt.signcolumn  = "no"
vim.opt.virtualedit = "block" -- allow cursor to move where there is no text in visual block mode
vim.opt.spellcapcheck = '' -- don't check for capital letters at start of sentence


vim.opt.clipboard:append("unnamedplus")
vim.opt.isfname:remove("=") -- Avoid recognizing = as part of file name
vim.opt.iskeyword:append("-") -- treat dash separated words as a word text object

vim.opt.completeopt = {
    "menu","menuone", "noselect"
}

vim.opt.fileencodings = {
    "utf-8"
}

vim.opt.suffixesadd = {
    ".js", ".es", ".jsx", ".json", ".css", ".less", "sass", ".styl", ".php",
    ".py", ".md"
}

-- -- Focused
-- local focused_colorcolumn = '+' .. table.concat({
--     '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12',
--     '13', '14', '15', '16', '17', '18', '19', '20', '21', '22', '23',
--     '24', '25', '26', '27', '28', '29', '30', '31', '32', '33', '34',
--     '35', '36', '37', '38', '39', '40', '41', '42', '43', '44', '45',
--     '46', '47', '48', '49', '50', '51', '52', '53', '54', '55', '56',
--     '57', '58', '59', '60', '61', '62', '63', '64', '65', '66', '67',
--     '68', '69', '70', '71', '72', '73', '74', '75', '76', '77', '78',
--     '79', '80', '81', '82', '83', '84', '85', '86', '87', '88', '89',
--     '90', '91', '92', '93', '94', '95', '96', '97', '98', '99', '100',
--     '101', '102', '103', '104', '105', '106', '107', '108', '109', '110',
--     '111', '112', '113', '114', '115', '116', '117', '118', '119', '120',
--     '121', '122', '123', '124', '125', '126', '127', '128', '129', '130',
--     '131', '132', '133', '134', '135', '136', '137', '138', '139', '140',
--     '141', '142', '143', '144', '145', '146', '147', '148', '149', '150',
--     '151', '152', '153', '154', '155', '156', '157', '158', '159', '160',
--     '161', '162', '163', '164', '165', '166', '167', '168', '169', '170',
--     '171', '172', '173', '174', '175', '176', '177', '178', '179', '180',
--     '181', '182', '183', '184', '185', '186', '187', '188', '189', '190',
--     '191', '192', '193', '194', '195', '196', '197', '198', '199', '200',
--     '201', '202', '203', '204', '205', '206', '207', '208', '209', '210',
--     '211', '212', '213', '214', '215', '216', '217', '218', '219', '220',
--     '221', '222', '223', '224', '225', '226', '227', '228', '229', '230',
--     '231', '232', '233', '234', '235', '236', '237', '238', '239', '240',
--     '241', '242', '243', '244', '245', '246', '247', '248', '249', '250',
--     '251', '252', '253', '254'
-- }, ',+')
-- vim.wo.colorcolumn = focused_colorcolumn
