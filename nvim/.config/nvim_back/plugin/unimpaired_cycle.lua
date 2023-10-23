-- -- The problem is if there is only one error in the buffer, and in the qflist,
-- -- or loclist it is pointed on that error, in the buffer if you move past that
-- -- error you cannot jump back with ]q and ]l, or jump forward with [q and [l.

-- local nnoremap = require("reverseila.utils.keymap").nnoremap

-- -- Quick Fix List

-- nnoremap("]q", "", { callback = function()
--   if pcall(function() vim.cmd("cnext") end) then
--     -- You're just fine
--   else
--     vim.cmd("silent cc")
--   end
-- end
-- })

-- nnoremap("[q", "", { callback = function()
--   if pcall(function() vim.cmd("cprev") end) then
--     -- You're just fine
--   else
--     vim.cmd("silent cc")
--   end
-- end
-- })


-- -- Location List

-- nnoremap("]l", "", { callback = function()
--   if pcall(function() vim.cmd("lnext") end) then
--     -- You're just fine
--   else
--     vim.cmd("silent ll")
--   end
-- end
-- })

-- nnoremap("[l", "", { callback = function()
--   if pcall(function() vim.cmd("lprev") end) then
--     -- You're just fine
--   else
--     vim.cmd("silent ll")
--   end
-- end
-- })
