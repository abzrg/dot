local helpers = require('snippets.snippet_helper')
local get_visual = helpers.get_visual

local line_begin = require("luasnip.extras.expand_conditions").line_begin

return {
  s('INCLUDE', {
    d(1, function(args, snip)
      -- Create a table of nodes that will go into the header choice_node
      local headers_to_load_into_choice_node = {}

      -- Step 1: get companion .h file if the current file is a .c or .cpp file excluding main.c
      local extension = vim.fn.expand('%:e')
      local is_main = vim.fn.expand('%'):match('main%.cp?p?') ~= nil
      if (extension == 'c' or extension == 'cpp') and not is_main then
        local matching_h_file = vim.fn.expand('%:t'):gsub('%.c', '.h')
        local companion_header_file = string.format('#include "%s"', matching_h_file)
        table.insert(headers_to_load_into_choice_node, t(companion_header_file))
      end

      -- Step 2: get all the local headers in current directory and below
      local current_file_directory = vim.fn.expand('%:h')
      local local_header_files = require('plenary.scandir').scan_dir(
        current_file_directory,
        { respect_gitignore = true, search_pattern = '.*%.h$' }
      )

      -- Clean up and insert the detected local header files
      for _, local_header_name in ipairs(local_header_files) do
        -- Trim down path to be a true relative path to the current file
        local shortened_header_path = local_header_name:gsub(current_file_directory, '')
        -- Replace '\' with '/'
        shortened_header_path = shortened_header_path:gsub([[\+]], '/')
        -- Remove leading forward slash
        shortened_header_path = shortened_header_path:gsub('^/', '')
        local new_header = t(string.format('#include "%s"', shortened_header_path))
        table.insert(headers_to_load_into_choice_node, new_header)
      end

      -- Step 3: allow for custom insert_nodes for local and system headers
      local custom_insert_nodes = {
        sn(
          nil,
          fmt(
            [[
                         #include "{}"
                         ]],
            {
              i(1, 'custom_insert.h'),
            }
          )
        ),
        sn(
          nil,
          fmt(
            [[
                         #include <{}>
                         ]],
            {
              i(1, 'custom_system_insert.h'),
            }
          )
        ),
      }
      -- Add the custom insert_nodes for adding custom local (wrapped in "") or system (wrapped in <>) headers
      for _, custom_insert_node in ipairs(custom_insert_nodes) do
        table.insert(headers_to_load_into_choice_node, custom_insert_node)
      end

      -- Step 4: finally last priority is the system headers
      local system_headers = {
        t('#include <assert.h>'),
        t('#include <complex.h>'),
        t('#include <ctype.h>'),
        t('#include <errno.h>'),
        t('#include <fenv.h>'),
        t('#include <float.h>'),
        t('#include <inttypes.h>'),
        t('#include <iso646.h>'),
        t('#include <limits.h>'),
        t('#include <locale.h>'),
        t('#include <math.h>'),
        t('#include <setjmp.h>'),
        t('#include <signal.h>'),
        t('#include <stdalign.h>'),
        t('#include <stdarg.h>'),
        t('#include <stdatomic.h>'),
        t('#include <stdbit.h>'),
        t('#include <stdbool.h>'),
        t('#include <stdckdint.h>'),
        t('#include <stddef.h>'),
        t('#include <stdint.h>'),
        t('#include <stdio.h>'),
        t('#include <stdlib.h>'),
        t('#include <stdnoreturn.h>'),
        t('#include <string.h>'),
        t('#include <tgmath.h>'),
        t('#include <threads.h>'),
        t('#include <time.h>'),
        t('#include <uchar.h>'),
        t('#include <wchar.h>'),
        t('#include <wctype.h>'),
      }
      for _, header_snippet in ipairs(system_headers) do
        table.insert(headers_to_load_into_choice_node, header_snippet)
      end

      return sn(1, c(1, headers_to_load_into_choice_node))
    end, {}),
  }),
}
