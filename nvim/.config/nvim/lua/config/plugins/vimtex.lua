-- Nice article
-- https://dr563105.github.io/blog/skim-vimtex-setup/
return {
  "lervag/vimtex",
  lazy = false, -- we don't want to lazy load VimTeX

  init = function()
    vim.g.vimtex_view_method = "skim" -- Choose which program to use to view PDF file
    --  skim synx settings:
    --   - preset: custom
    --   - command: nvim
    --   - arguments: --headless -c "VimtexInverseSearch %line '%file'"

    vim.g.tex_flavor = 'latex' -- Default tex file format
    vim.g.vimtex_quickfix_mode = 0
    vim.g.vimtex_complete_enabled = 1
    -- vim.g.vimtex_fold_enabled=1
    vim.g.vimtex_view_skim_sync = 1   -- Value 1 allows forward search after every successful compilation
    vim.g.vimtex_view_skim_activate = 1 -- Value 1 allows change focus to skim after command `:VimtexView` is given
    vim.g.vimtex_compiler_method = 'latexmk'
    vim.g.vimtex_syntax_enabled = 1

    vim.g.vimtex_compiler_latexmk = {
      aux_dir    = 'build',
      out_dir    = 'build',
      callback   = 1,
      continuous = 1,
      executable = 'latexmk',
      hooks      = {},
      options    = {
        '-dvi-',
        '-pdf',
        '-verbose',
        '-file-line-error',
        '-synctex=1',
        '-interaction=nonstopmode',
        '-shell-escape'
      },
    }

    vim.keymap.set('n', '<localleader>c', '<cmd>VimtexCompile<cr>', { buffer = true, silent = true, noremap = true })

    -- Vimtex Events
    local au_group = vim.api.nvim_create_augroup("vimtex_events", {})

    -- Specify extra behaviour after reverse goto
    vim.api.nvim_create_autocmd("User", {
      pattern = "VimtexEventViewReverse",
      group = au_group,
      command = "normal! zMzvzz"
    })
  end
}
