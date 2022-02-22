-- Writing print(vim.inspect(x)) every time you want to inspect the contents of
-- an object can get pretty tedious. It might be worthwhile to have a global
-- wrapper function somewhere in your configuration:
function _G.dump(...)
    local objects = vim.tbl_map(vim.inspect, {...})
    print(unpack(objects))
    return ...
end
-- usage:
--    :lua dump(vim.loop)



-- This API function allows you to escape terminal codes and Vim keycodes.
-- t: termcode
function _G.termcode(str)
    -- Adjust boolean arguments as needed
    return vim.api.nvim_replace_termcodes(str, true, true, true)
end
-- usage:
--    print(t'<Tab>')

