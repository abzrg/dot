-- Source: https://www.youtube.com/watch?v=x2QJYq4IX6M

local M = {}

local function bind(op, outer_opts)
    outer_opts = outer_opts or {noremap = true}
    return function(lhs, rhs, opts)
        opts = vim.tbl_extend("force",
            outer_opts,
            opts or {}
        )
        vim.keymap.set(op, lhs, rhs, opts)
    end
end


-- Helpers

M.nmap = bind("n", {noremap = false})
M.xmap = bind("x", {noremap = false})
M.vmap = bind("v", {noremap = false})
M.imap = bind("i", {noremap = false})
M.cmap = bind("c", {noremap = false})

M.nnoremap = bind("n", {noremap = true})
M.vnoremap = bind("v", {noremap = true})
M.xnoremap = bind("x", {noremap = true})
M.inoremap = bind("i", {noremap = true})
M.cnoremap = bind("c", {noremap = true})


return M
