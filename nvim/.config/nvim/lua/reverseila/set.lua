-- [ Line Numbers ] --------------------------

vim.opt.number         = true
vim.opt.relativenumber = true


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

vim.opt.scrolloff     = 3 -- start scroll 3 lines before edge of the viewport
vim.opt.sidescrolloff = 3


-- [ Splits ] --------------------------

vim.opt.splitbelow = true
vim.opt.splitright = true


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
  eob  = " ", -- NO-BREAK SPACE (U+00A0, UTF-8: C2 A0) to suppress ~ at EndOfBuffer
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

vim.opt.cmdheight  = 1
vim.opt.laststatus = 3
vim.opt.textwidth  = 80 -- automatically hard wrap at 120 columns
vim.opt.updatetime = 500 -- CursorHold interval

vim.opt.wrap          = false
vim.opt.cursorline    = true
vim.opt.equalalways   = false
vim.opt.joinspaces    = false -- don't autoinsert two spaces after '.', '?', '!' for join command
vim.opt.lazyredraw    = false -- don't bother updating screen during macro playback
vim.opt.showmatch     = false
vim.opt.showmode      = false
vim.opt.termguicolors = true
vim.opt.title         = true

vim.opt.encoding    = "utf-8"
vim.opt.fileformat  = "unix"
-- vim.opt.foldmethod      = 'indent'
vim.opt.inccommand  = "split" -- live preview of :s results
vim.opt.mouse       = "a" -- enable mouse
vim.opt.shell       = "bash"
vim.opt.shortmess   = "filnxtToOc"
vim.opt.signcolumn  = "number"
vim.opt.virtualedit = "block" -- allow cursor to move where there is no text in visual block mode

vim.opt.clipboard:append("unnamedplus")
vim.opt.isfname:remove("=") -- Avoid recognizing = as part of file name
vim.opt.iskeyword:append("-") -- treat dash separated words as a word text object

vim.opt.completeopt = {
  "menuone", "noselect"
}

vim.opt.fileencodings = {
  "utf-8"
}

vim.opt.suffixesadd = {
  ".js", ".es", ".jsx", ".json", ".css", ".less", "sass", ".styl", ".php",
  ".py", ".md"
}
