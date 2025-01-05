vim.opt.number         = true
vim.opt.relativenumber = true

vim.opt.autoindent     = true -- maintain indent of current line
vim.opt.expandtab      = true -- always use tabs instead of spaces
vim.opt.smarttab       = true -- <tab>/<BS> indent/deindent in loading whitespace
vim.opt.shiftwidth     = 4
vim.opt.tabstop        = 4    -- spaces per tab

vim.opt.hlsearch       = true
vim.opt.ignorecase     = true
vim.opt.incsearch      = true
vim.opt.smartcase      = true

vim.opt.scrolloff      = 3 -- start scroll 3 lines before edge of the viewport
vim.opt.sidescrolloff  = 3

vim.opt.splitbelow     = true -- open horizontal splits below current window
vim.opt.splitright     = true -- open vertical splits to the right of the current window

vim.opt.backup         = false
vim.opt.swapfile       = false -- don't create swap file
vim.opt.writebackup    = false

vim.opt.path           = "**"

vim.opt.wildmenu       = true -- show options as list when switching to buffers etc
vim.opt.wildignorecase = true
vim.opt.wildchar       = 9    -- ('<Tab>') character to trigger wildcard expansion
vim.opt.wildcharm      = 26   -- ('<C-z>') substitue for 'wildchar' in macros
vim.opt.wildmode       = {    -- shell-like autocomplete to unambigious portion
    'longest', 'list', 'full'
}
vim.opt.wildignore:append({ -- patterns to ingore durng file navigation
    '*.git/*', '*.tags', 'tags', '*build/*', '*.o', '*.class', '*.egg-info/**',
    '__pycache__', 'venv', '*venv/**', '*dist/**', '**/.vim/undo/**', '**/.vim/pack/**',
    '*.cache/*',
})

vim.opt.undofile       = true
vim.opt.undodir        = vim.fn.stdpath('cache') .. "/undo"

vim.opt.fillchars      = { diff = "∙", eob = " ", fold = " ", vert = "┃", }

vim.opt.list           = true
vim.opt.listchars      = { nbsp = '¬', extends = '»', precedes = '«', tab = '▸ ', trail = '•', }

vim.opt.showcmd        = true
vim.opt.showbreak      = '↪ '
vim.opt.linebreak      = true
vim.opt.cmdheight      = 1
vim.opt.laststatus     = 3

vim.opt.updatetime     = 200 -- CursorHold interval

vim.opt.pumheight      = 10

vim.opt.breakindent    = true
vim.opt.wrap           = false
vim.opt.cursorline     = true
vim.opt.cursorlineopt  = "both"
vim.opt.cursorcolumn   = false
vim.opt.equalalways    = false
vim.opt.joinspaces     = false -- Don't autoinsert two spaces after '.', '?', '!' for join command
vim.opt.lazyredraw     = true  -- Don't bother updating screen during macro playback
vim.opt.showmatch      = false
vim.opt.showmode       = false
vim.opt.termguicolors  = true
vim.opt.title          = true

vim.opt.encoding       = "utf-8"
-- vim.opt.fileformat  = "unix" -- creates problem with gitsigns
--
-- vim.opt.foldmethod      = 'expr'
vim.opt_local.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldtext       = ""
-- vim.opt.foldlevelstart = 99
-- vim.opt_local.foldtext = "v:lua.vim.treesitter.foldtext()"

vim.opt.inccommand     = "split" -- live preview of :s results
vim.opt.mouse          = "a"     -- enable mouse
vim.opt.shortmess      = "FfilnxtToOc"
vim.opt.signcolumn     = "yes"
vim.opt.virtualedit    = "block" -- allow cursor to move where there is no text in visual block mode
vim.opt.startofline    = false
vim.opt.spellcapcheck  = ''      -- don't check for capital letters at start of sentence
vim.opt.spelllang      = 'en_us'

vim.opt.clipboard      = "unnamedplus"

vim.opt.isfname:remove("=") -- Avoid recognizing = as part of file name
-- vim.opt.iskeyword:append("-") -- treat dash separated words as a word text object

vim.opt.completeopt     = {
    "menu", "menuone", "noselect"
}

vim.opt.fileencodings   = {
    "utf-8"
}

vim.opt.suffixesadd     = {
    ".js", ".es", ".jsx", ".json", ".css", ".less", "sass", ".styl", ".php",
    ".py", ".md"
}

-- vim.wo.colorcolumn =

local textwidth         = 90
vim.opt.textwidth       = textwidth
vim.wo.colorcolumn      = tostring(textwidth)
