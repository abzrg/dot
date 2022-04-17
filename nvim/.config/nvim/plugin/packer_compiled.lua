-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

  local time
  local profile_info
  local should_profile = false
  if should_profile then
    local hrtime = vim.loop.hrtime
    profile_info = {}
    time = function(chunk, start)
      if start then
        profile_info[chunk] = hrtime()
      else
        profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
      end
    end
  else
    time = function(chunk, start) end
  end
  
local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end

  _G._packer = _G._packer or {}
  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/Users/ali/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/Users/ali/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/Users/ali/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/Users/ali/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/Users/ali/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s), name, _G.packer_plugins[name])
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  ["Comment.nvim"] = {
    config = { "\27LJ\2\n5\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\fComment\frequire\0" },
    loaded = true,
    path = "/Users/ali/.local/share/nvim/site/pack/packer/start/Comment.nvim",
    url = "https://github.com/numToStr/Comment.nvim"
  },
  ["clever-f.vim"] = {
    loaded = true,
    path = "/Users/ali/.local/share/nvim/site/pack/packer/start/clever-f.vim",
    url = "https://github.com/rhysd/clever-f.vim"
  },
  ["committia.vim"] = {
    config = { " require('plugins/committia') " },
    loaded = true,
    path = "/Users/ali/.local/share/nvim/site/pack/packer/start/committia.vim",
    url = "https://github.com/rhysd/committia.vim"
  },
  fzf = {
    loaded = true,
    path = "/Users/ali/.local/share/nvim/site/pack/packer/start/fzf",
    url = "https://github.com/junegunn/fzf"
  },
  ["fzf.vim"] = {
    loaded = true,
    path = "/Users/ali/.local/share/nvim/site/pack/packer/start/fzf.vim",
    url = "https://github.com/junegunn/fzf.vim"
  },
  ["markdown-preview.nvim"] = {
    commands = { "MarkdownPreview" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/ali/.local/share/nvim/site/pack/packer/opt/markdown-preview.nvim",
    url = "https://github.com/iamcco/markdown-preview.nvim"
  },
  ["numb.nvim"] = {
    config = { " require('plugins/numb') " },
    loaded = true,
    path = "/Users/ali/.local/share/nvim/site/pack/packer/start/numb.nvim",
    url = "https://github.com/nacro90/numb.nvim"
  },
  ["nvim-autopairs"] = {
    config = { " require('plugins/autopairs') " },
    loaded = true,
    path = "/Users/ali/.local/share/nvim/site/pack/packer/start/nvim-autopairs",
    url = "https://github.com/windwp/nvim-autopairs"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/Users/ali/.local/share/nvim/site/pack/packer/start/packer.nvim",
    url = "https://github.com/wbthomason/packer.nvim"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/Users/ali/.local/share/nvim/site/pack/packer/start/plenary.nvim",
    url = "https://github.com/nvim-lua/plenary.nvim"
  },
  ["popup.nvim"] = {
    loaded = true,
    path = "/Users/ali/.local/share/nvim/site/pack/packer/start/popup.nvim",
    url = "https://github.com/nvim-lua/popup.nvim"
  },
  ["starlite-nvim"] = {
    config = { " require('plugins/starlite') " },
    loaded = true,
    path = "/Users/ali/.local/share/nvim/site/pack/packer/start/starlite-nvim",
    url = "https://github.com/ironhouzi/starlite-nvim"
  },
  ["targets.vim"] = {
    loaded = true,
    path = "/Users/ali/.local/share/nvim/site/pack/packer/start/targets.vim",
    url = "https://github.com/wellle/targets.vim"
  },
  ["telescope-env.nvim"] = {
    config = { " require('telescope').load_extension('env') " },
    loaded = true,
    path = "/Users/ali/.local/share/nvim/site/pack/packer/start/telescope-env.nvim",
    url = "https://github.com/LinArcX/telescope-env.nvim"
  },
  ["telescope-file-browser.nvim"] = {
    loaded = true,
    path = "/Users/ali/.local/share/nvim/site/pack/packer/start/telescope-file-browser.nvim",
    url = "https://github.com/nvim-telescope/telescope-file-browser.nvim"
  },
  ["telescope.nvim"] = {
    config = { " require('plugins/telescope') " },
    loaded = true,
    path = "/Users/ali/.local/share/nvim/site/pack/packer/start/telescope.nvim",
    url = "https://github.com/nvim-telescope/telescope.nvim"
  },
  ["twilight.nvim"] = {
    loaded = true,
    path = "/Users/ali/.local/share/nvim/site/pack/packer/start/twilight.nvim",
    url = "https://github.com/folke/twilight.nvim"
  },
  ["vim-autocorrect"] = {
    config = { " vim.cmd('autocmd BufReadPost ~/Documents/notes/* call AutoCorrect()') " },
    loaded = true,
    path = "/Users/ali/.local/share/nvim/site/pack/packer/start/vim-autocorrect",
    url = "https://github.com/panozzaj/vim-autocorrect"
  },
  ["vim-chalk"] = {
    loaded = true,
    path = "/Users/ali/.local/share/nvim/site/pack/packer/start/vim-chalk",
    url = "https://github.com/dbmrq/vim-chalk"
  },
  ["vim-cheat"] = {
    loaded = true,
    path = "/Users/ali/.local/share/nvim/site/pack/packer/start/vim-cheat",
    url = "https://github.com/reverseila/vim-cheat"
  },
  ["vim-dispatch"] = {
    commands = { "Dispatch", "Make", "Focus", "Start" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/ali/.local/share/nvim/site/pack/packer/opt/vim-dispatch",
    url = "https://github.com/tpope/vim-dispatch"
  },
  ["vim-endwise"] = {
    loaded = true,
    path = "/Users/ali/.local/share/nvim/site/pack/packer/start/vim-endwise",
    url = "https://github.com/tpope/vim-endwise"
  },
  ["vim-eunuch"] = {
    loaded = true,
    path = "/Users/ali/.local/share/nvim/site/pack/packer/start/vim-eunuch",
    url = "https://github.com/tpope/vim-eunuch"
  },
  ["vim-fetch"] = {
    loaded = true,
    path = "/Users/ali/.local/share/nvim/site/pack/packer/start/vim-fetch",
    url = "https://github.com/wsdjeg/vim-fetch"
  },
  ["vim-foam"] = {
    loaded = true,
    path = "/Users/ali/.local/share/nvim/site/pack/packer/start/vim-foam",
    url = "https://github.com/lervag/vim-foam"
  },
  ["vim-fugitive"] = {
    config = { " require('plugins/vim-fugitive') " },
    loaded = true,
    path = "/Users/ali/.local/share/nvim/site/pack/packer/start/vim-fugitive",
    url = "https://github.com/tpope/vim-fugitive"
  },
  ["vim-highlight-match-under-cursor"] = {
    loaded = true,
    path = "/Users/ali/.local/share/nvim/site/pack/packer/start/vim-highlight-match-under-cursor",
    url = "https://github.com/adamheins/vim-highlight-match-under-cursor"
  },
  ["vim-repeat"] = {
    loaded = true,
    path = "/Users/ali/.local/share/nvim/site/pack/packer/start/vim-repeat",
    url = "https://github.com/tpope/vim-repeat"
  },
  ["vim-rsi"] = {
    loaded = true,
    path = "/Users/ali/.local/share/nvim/site/pack/packer/start/vim-rsi",
    url = "https://github.com/tpope/vim-rsi"
  },
  ["vim-speeddating"] = {
    loaded = true,
    path = "/Users/ali/.local/share/nvim/site/pack/packer/start/vim-speeddating",
    url = "https://github.com/tpope/vim-speeddating"
  },
  ["vim-surround"] = {
    loaded = true,
    path = "/Users/ali/.local/share/nvim/site/pack/packer/start/vim-surround",
    url = "https://github.com/tpope/vim-surround"
  },
  ["vim-tmux-navigator"] = {
    config = { ' require("plugins/vim-tmux-navigator") ' },
    loaded = true,
    path = "/Users/ali/.local/share/nvim/site/pack/packer/start/vim-tmux-navigator",
    url = "https://github.com/christoomey/vim-tmux-navigator"
  },
  ["zen-mode.nvim"] = {
    config = { " require('plugins/zen-mode') " },
    loaded = true,
    path = "/Users/ali/.local/share/nvim/site/pack/packer/start/zen-mode.nvim",
    url = "https://github.com/folke/zen-mode.nvim"
  }
}

time([[Defining packer_plugins]], false)
-- Config for: telescope-env.nvim
time([[Config for telescope-env.nvim]], true)
 require('telescope').load_extension('env') 
time([[Config for telescope-env.nvim]], false)
-- Config for: nvim-autopairs
time([[Config for nvim-autopairs]], true)
 require('plugins/autopairs') 
time([[Config for nvim-autopairs]], false)
-- Config for: vim-fugitive
time([[Config for vim-fugitive]], true)
 require('plugins/vim-fugitive') 
time([[Config for vim-fugitive]], false)
-- Config for: telescope.nvim
time([[Config for telescope.nvim]], true)
 require('plugins/telescope') 
time([[Config for telescope.nvim]], false)
-- Config for: zen-mode.nvim
time([[Config for zen-mode.nvim]], true)
 require('plugins/zen-mode') 
time([[Config for zen-mode.nvim]], false)
-- Config for: starlite-nvim
time([[Config for starlite-nvim]], true)
 require('plugins/starlite') 
time([[Config for starlite-nvim]], false)
-- Config for: vim-tmux-navigator
time([[Config for vim-tmux-navigator]], true)
 require("plugins/vim-tmux-navigator") 
time([[Config for vim-tmux-navigator]], false)
-- Config for: vim-autocorrect
time([[Config for vim-autocorrect]], true)
 vim.cmd('autocmd BufReadPost ~/Documents/notes/* call AutoCorrect()') 
time([[Config for vim-autocorrect]], false)
-- Config for: Comment.nvim
time([[Config for Comment.nvim]], true)
try_loadstring("\27LJ\2\n5\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\fComment\frequire\0", "config", "Comment.nvim")
time([[Config for Comment.nvim]], false)
-- Config for: numb.nvim
time([[Config for numb.nvim]], true)
 require('plugins/numb') 
time([[Config for numb.nvim]], false)
-- Config for: committia.vim
time([[Config for committia.vim]], true)
 require('plugins/committia') 
time([[Config for committia.vim]], false)

-- Command lazy-loads
time([[Defining lazy-load commands]], true)
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file Dispatch lua require("packer.load")({'vim-dispatch'}, { cmd = "Dispatch", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file Make lua require("packer.load")({'vim-dispatch'}, { cmd = "Make", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file Focus lua require("packer.load")({'vim-dispatch'}, { cmd = "Focus", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file Start lua require("packer.load")({'vim-dispatch'}, { cmd = "Start", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file MarkdownPreview lua require("packer.load")({'markdown-preview.nvim'}, { cmd = "MarkdownPreview", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
time([[Defining lazy-load commands]], false)

vim.cmd [[augroup packer_load_aucmds]]
vim.cmd [[au!]]
  -- Filetype lazy-loads
time([[Defining lazy-load filetype autocommands]], true)
vim.cmd [[au FileType markdown ++once lua require("packer.load")({'markdown-preview.nvim'}, { ft = "markdown" }, _G.packer_plugins)]]
time([[Defining lazy-load filetype autocommands]], false)
vim.cmd("augroup END")
if should_profile then save_profiles() end

end)

if not no_errors then
  error_msg = error_msg:gsub('"', '\\"')
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
