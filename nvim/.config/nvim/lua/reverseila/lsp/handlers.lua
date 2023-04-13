local M = {}

M.setup = function()
  -- local signs = {
  --   { name = "DiagnosticSignError", text = "" },
  --   { name = "DiagnosticSignWarn", text = "" },
  --   { name = "DiagnosticSignHint", text = "" },
  --   { name = "DiagnosticSignInfo", text = "" },
  -- }

  -- for _, sign in ipairs(signs) do
  --   vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
  -- end

  local config = {
    -- disable virtual text
    virtual_text = false,
    -- show signs
    -- signs = {
    --   active = signs,
    -- },
    update_in_insert = true,
    underline = true,
    severity_sort = true,
    float = {
      focusable = false,
      style = "minimal",
      -- border = "rounded",
      source = "always",
      header = "",
      -- prefix = "",
    },
  }

  vim.diagnostic.config(config)

  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = "rounded",
    width = 60,
  })

  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = "rounded",
    width = 60,
  })
end

local function lsp_highlight_document(client, bufnr)
  -- local cap = client.server_capabilities

  -- if client.server_capabilities.document_highlight then
  if client.server_capabilities.document_highlight then
    vim.api.nvim_create_augroup("lsp_document_highlight", { clear = true })
    vim.api.nvim_clear_autocmds { buffer = bufnr, group = "lsp_document_highlight" }
    vim.api.nvim_create_autocmd("CursorHold", {
      callback = function()
        -- thanks to: https://www.reddit.com/r/neovim/comments/uvemjr/comment/i9lrdpc/?utm_source=share&utm_medium=web2x&context=3
        -- exclude fucking cmake from document highliting
        if vim.bo.filetype ~= "cmake" and vim.bo.filetype ~= "json" then
          vim.lsp.buf.document_highlight()
        end
      end,
      buffer = bufnr,
      group = "lsp_document_highlight",
      desc = "Document Highlight",
    })
    vim.api.nvim_create_autocmd("CursorMoved", {
      callback = function()
        if vim.bo.filetype ~= "cmake" and vim.bo.filetype ~= "json" then
          vim.lsp.buf.clear_references()
        end
      end,
      buffer = bufnr,
      group = "lsp_document_highlight",
      desc = "Clear All the References",
    })
  end
end

local function lsp_keymaps(bufnr)
  local opts = { noremap = true, silent = true }
  local nmap = function(keys, func, desc)
    if desc then
      desc = "LSP: " .. desc
    end
    vim.keymap.set("n", keys, func, { buffer = bufnr, silent = true, noremap = true, desc = desc })
  end

  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

  nmap("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
  nmap("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

  nmap("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
  nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
  nmap("gr", vim.lsp.buf.references, "[G]oto [R]eferences")
  nmap("gI", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
  nmap("<leader>D", vim.lsp.buf.type_definition, "Type [D]efinition")

  -- See `:help K` for why this keymap
  nmap("K", vim.lsp.buf.hover, "Hover Documentation")
  vim.keymap.set('i',
    "<C-k>",
    vim.lsp.buf.signature_help,
    {
      desc = "Signature Documentation",
      noremap = true,
      silent = true
    })

  -- vim.api.nvim_buf_set_keymap(bufnr, "n", "gl", '<cmd>lua vim.diagnostic.open_float({ border = "rounded" })<CR>', opts)
  nmap("gl", vim.diagnostic.open_float, "[Go] and [L]int")
  nmap("<C-p>", vim.diagnostic.goto_prev, "[P]revious Diagnostic")
  nmap("<C-n>", vim.diagnostic.goto_next, "[N]ext Diagnostic")
  nmap("<space>l", vim.diagnostic.setloclist, "Open [L]ocation List (contains errors)")

  -- See `:help =` for why this keymap
  vim.keymap.set("n", "<leader>=", function() vim.lsp.buf.format { async = true } end, { noremap = true, silent = true })

  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
    if vim.lsp.buf.format then
      vim.lsp.buf.format()
    elseif vim.lsp.buf.formatting then
      vim.lsp.buf.formatting()
    end
  end, { desc = "Format current buffer with LSP" })
end

--  This function gets run when an LSP connects to a particular buffer.
M.on_attach = function(client, bufnr)
  if client.name == "tsserver" then
    client.server_capabilities.document_formatting = false
  end
  if client.name == "cmake" then
    client.server_capabilities.document_highlight = false
  else
    client.server_capabilities.document_highlight = true
  end
  lsp_keymaps(bufnr)
  lsp_highlight_document(client)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()

local status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not status_ok then
  return
end
M.capabilities = cmp_nvim_lsp.default_capabilities(capabilities)

return M
