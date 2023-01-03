-- Check if the foam environment is loaded, first
-- note that in macos you must create a case-sensitive /Volumes/OpenFOAM/
-- partition

local wm_project_dir = os.getenv("WM_PROJECT_DIR")

if vim.fn.empty(wm_project_dir) == 0 then
  local tag_file = wm_project_dir .. "/tags"
  local foam_src = wm_project_dir .. "/src"
  print(foam_src)

  -- OpenFOAM specific hooks
  local foam_group = vim.api.nvim_create_augroup("Foam_Hooks", { clear = true })

  -- Add projcet directory to path and set the make program to wmake when you
  -- open a source file (settings are local to the buffer)
  vim.api.nvim_create_autocmd(
    { "BufReadPost" }, {
    pattern = { "*.C", "*.H" },
    callback = function()
      vim.bo.path = vim.bo.path .. ",**," .. foam_src .. "/**"
      vim.bo.tags = tag_file
      vim.bo.makeprg = "wmake"
    end,
    group = foam_group,
  })

  -- Dictionary files (clash between cpp ftdetect and vim-foam)
  vim.api.nvim_create_autocmd(
    { "BufReadPost" }, {
    pattern = {
      "*/system/*",
      "*/constant/*",
      "*/0/*",
      "*Dict",
    },
    callback = function()
      vim.bo.filetype = "foam"
      -- Disable lsp (possibly clangd)
      vim.lsp.stop_client(1)
    end,
    group = foam_group,
  })

  -- make all files under src/ readonly
  --
  -- the reason I have two autocmd is that I wanted to differentiate between
  -- the user directory and the openfoam source code directory, so that the
  -- files under user src/ directories are not in readonly mode
  vim.api.nvim_create_autocmd(
    { "BufEnter", "BufReadPost", "BufRead", "BufNewFile" }, {
    pattern = {
      "*/OpenFOAM/OpenFOAM-*/src/**",
      "*/OpenFOAM/foam-extend-*/src/**",
      "*/OpenFOAM/OpenFOAM-*/applications/**",
      "*/OpenFOAM/foam-extend-*/applications/**"
    },
    callback = function()
      vim.opt_local.readonly = true
      vim.opt_local.modifiable = false
    end,
    group = foam_group
  }
  )

  vim.cmd([[
      autocmd BufEnter,BufReadPost,BufRead,BufNewFile
                \ */OpenFOAM/**/*.C lua vim.diagnostic.disable(0)
  ]])

end
