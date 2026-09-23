vim.lsp.config("gopls", {
  settings = {
    gopls = {
      gofumpt = true,
      staticcheck = true,
    },
  },
})

vim.lsp.enable("gopls")
