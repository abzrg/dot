-- Check it is installed
local status_ok, colorizer = pcall(require, "colorizer")
if (not status_ok) then
  return
end


colorizer.setup {}
