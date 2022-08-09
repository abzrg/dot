-- Check if the foam environment is loaded, first
-- note that in macos you must create a case-sensitive /Volumes/OpenFOAM/
-- partition

local wm_project_dir = os.getenv("WM_PROJECT_DIR")

if not vim.fn.empty(wm_project_dir) then
  local tag_file = wm_project_dir .. "/tags"
  local foam_src = wm_project_dir .. "/src"

  -- OpenFOAM specific hooks
  local foam_group = vim.api.nvim_create_augroup("Foam_Hooks", { clear = true })

  -- Add projcet directory to path and set the make program to wmake when you
  -- open a source file (settings are local to the buffer)
  vim.api.nvim_create_autocmd(
    { "BufEnter", "BufReadPost", "BufRead" }, {
    pattern = { "*.C", "*.H" },
    callback = function()
      vim.opt_local.path:append({ foam_src })
      vim.opt_local.tags:append(tag_file)
      vim.opt_local.makeprg = "wmake"
    end,
    group = foam_group,
  }
  )

  -- disable lsp diagnostics for OpenFOAM header files
  -- buffer 0 means the current buffer
  vim.api.nvim_create_autocmd(
    { "BuffEnter", "BufReadPost", "BufRead", "BufNewFile" }, {
    pattern = "*/OpenFOAM/**/*.H",
    callback = function() vim.diagnostic.disable(0) end,
    group = foam_group,
  }
  )

  -- make all files under src/ readonly
  --
  -- the reason I have two autocmd is that I wanted to differentiate between
  -- the user directory and the openfoam source code directory, so that the
  -- files under user src/ directories are not in readonly mode
  vim.api.nvim_create_autocmd(
    { "BufEnter", "BufReadPost", "BufRead", "BufNewFile" }, {
    pattern = { "*/OpenFOAM/OpenFOAM-*/src/**", "*/OpenFOAM/foam-extend-*/src/**" },
    callback = function()
      vim.opt_local.readonly = true
      vim.opt_local.modifiable = false
    end,
    group = foam_group
  }
  )
end
