return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  ---@global Snacks
  opts = {
    -- bigfile = { enabled = true },
    -- dashboard = { enabled = false },
    -- explorer = { enabled = true },
    -- indent = { enabled = true },
    -- input = { enabled = true },
    picker = {
      enabled = true,
      layout = "ivy",
      layouts = {
        ivy = {
          layout = {
            box = "vertical",
            backdrop = false,
            row = -1,
            width = 0,
            height = 0.7,
            border = "top",
            title = " {title} {live} {flags}",
            title_pos = "left",
            { win = "input", height = 1, border = "bottom" },
            {
              box = "horizontal",
              { win = "list",    border = "none" },
              { win = "preview", title = "{preview}", width = 0.5, border = "left" },
            },
          },
        }
      },
    },
    -- notifier = { enabled = false },
    -- quickfile = { enabled = true },
    scope = { enabled = true },
    -- scroll = { enabled = false },
    -- statuscolumn = { enabled = true },
    -- words = { enabled = true },

  },
  keys = {
    { "<leader>f",  function() Snacks.picker.smart({ cwd = vim.fn.getcwd() }) end,                                                     desc = "Smart Find Files" },
    { "<leader>,",  function() Snacks.picker.buffers({ on_show = function() vim.cmd.stopinsert() end, }) end, desc = "Buffers" },
    { "<leader>/",  function() Snacks.picker.grep() end,                                                      desc = "Grep" },
    { "<leader>:",  function() Snacks.picker.command_history() end,                                           desc = "Command History" },
    { "<leader>n",  function() Snacks.picker.notifications() end,                                             desc = "Notification History" },
    { "<leader>en", function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end,                   desc = "Find Config File" },
    { "<leader>ed", function() Snacks.picker.smart({ cwd = "~/.dot/" }) end,                                  desc = "Smart Find Files" },
    { "<leader>es", function() Snacks.picker.files({ cwd = "~/workspace/abzrg/snippets/" }) end,                    desc = "Smart Find Files" },
    { "<leader>eh", function() Snacks.picker.help({ layout = "select" }) end,                                 desc = "Help Pages" },
    { "<leader>ek", function() Snacks.picker.keymaps() end,                                                   desc = "Keymaps" },
    { "<leader>eo", function() Snacks.picker.recent() end,                                                    desc = "Recent" },


  }
}
