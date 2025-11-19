vim.keymap.set({ "n", "v" }, "<leader>=", function()
    require("conform").format({
        lsp_fallback = true,
        async = false,
        timeout_ms = 1000,
    })
    print("Prettier: Done")
end, { silent = true, buffer = true })
