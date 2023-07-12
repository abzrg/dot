-- Check it is installed first
local status_ok = pcall(require, "nvim-treesitter")
if not status_ok then
  return
end

-- Setup
require('nvim-treesitter.configs').setup {
  highlight = {
    enable = true,
    -- disable = { "bash", "make", "html", "vim", "tex", "latex", "yaml" },
  },

  indent = {
    enable = false,     -- creates wierd indentation problem in python files
    -- disable = { "bash" },
  },

  -- List of languages
  ensure_installed = {
    "c",
    "cpp",
    "foam",
    "python",
    "html",
    "css",
    "comment",
    "javascript",
    "typescript",
    "java",
    "lua",
  },

  -- Playground config
  playground = {
    enable = true,
    disable = {},
    updatetime = 25,             -- Debounced time for highlighting nodes in the playground from source code
    persist_queries = false,     -- Whether the query persists across vim sessions
    keybindings = {
      toggle_query_editor = 'o',
      toggle_hl_groups = 'i',
      toggle_injected_languages = 't',
      toggle_anonymous_nodes = 'a',
      toggle_language_display = 'I',
      focus_language = 'f',
      unfocus_language = 'F',
      update = 'R',
      goto_node = '<cr>',
      show_help = '?',
    },
  },

  -- Plugins

  endwise = {
    enable = true,
  },

  autotag = {
    enable = true,
    filetypes = {
      'html', 'htmldjango', 'javascript', 'typescript', 'javascriptreact', 'typescriptreact', 'svelte', 'vue', 'tsx', 'jsx',
      'rescript',
      'xml',
      'php',
      'markdown',
      'astro', 'glimmer', 'handlebars', 'hbs'
    },
    skip_tags = {
      'area', 'base', 'br', 'col', 'command', 'embed', 'hr', 'img', 'slot',
      'input', 'keygen', 'link', 'meta', 'param', 'source', 'track', 'wbr', 'menuitem', 'option'
    },
  },

  context_commentstring = {
    enable = true,
  },
}
