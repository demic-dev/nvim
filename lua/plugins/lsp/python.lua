-- basedpyright types and navigates, ruff lints and formats.
vim.lsp.config("basedpyright", {
  settings = {
    basedpyright = {
      disableOrganizeImports = true, -- ruff does it
      analysis = {
        typeCheckingMode = "standard",
        diagnosticMode = "openFilesOnly",
      },
    },
  },
})

vim.lsp.config("ruff", {
  on_attach = function(client)
    client.server_capabilities.hoverProvider = false -- basedpyright owns K
  end,
})

vim.lsp.enable({ "basedpyright", "ruff" })
