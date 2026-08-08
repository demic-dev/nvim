vim.lsp.config("vtsls", {
  settings = {
    typescript = {
      updateImportsOnFileMove = { enabled = "always" },
      preferences = { importModuleSpecifier = "non-relative" },
    },
  },
})

vim.lsp.enable("vtsls")
