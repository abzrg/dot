return {
  "rhysd/committia.vim",
  lazy = true,
  ft = "gitcommit",
  config = function()
    vim.g.committia_min_window_width = 90
    vim.g.committia_edit_window_width = 72
    vim.g.committia_status_window_min_height = 100

    vim.cmd [[
      let g:committia_hooks = {}
      function! g:committia_hooks.edit_open(info)
        " Additional settings
        setlocal spell

        " If no commit message, start with insert mode
        if a:info.vcs ==# 'git' && getline(1) ==# ''
          startinsert
        endif

        " Scroll the diff window from insert mode
        " Map <C-n> and <C-p>
        imap <buffer><C-n> <Plug>(committia-scroll-diff-down-half)
        imap <buffer><C-p> <Plug>(committia-scroll-diff-up-half)
      endfunction
    ]]
  end
}
