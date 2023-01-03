-- Check it is installed
local status_ok, fidget = pcall(require, "fidget")
if (not status_ok) then
  return
end


-- Turn on lsp status information
fidget.setup {}
