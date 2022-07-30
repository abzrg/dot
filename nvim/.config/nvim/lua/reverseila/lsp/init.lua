-- Check lspconfig is installed first
local status_lsp_ok, _ = pcall(require, "lspconfig")
if not status_lsp_ok then
    return
end

require("reverseila.lsp.handlers").setup()
require("reverseila/lsp/config")
