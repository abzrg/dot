-- https://github.com/aca/emmet-ls
-- Installation: npm i -g emmet-ls

return {
  cmd = { "emmet-ls", "--stdio" },
  filetypes = {
    "astro", "css", "eruby",
    "html", "htmldjango", "javascriptreact",
    "less", "pug", "sass", "scss",
    "svelte", "typescriptreact", "vue"
  },
  -- root_dir = function(fname)
  --   return require("lspconfig.util")(fname) or vim.loop.os_homedir()
  -- end,
  single_file_support = true,
}
