vim.lsp.config("nixd", {
  settings = {
    nixd = {
      formatting = { command = { "nixfmt" } },
    },
  },
})

vim.lsp.enable("nixd")
