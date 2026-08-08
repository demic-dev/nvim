vim.lsp.config("tinymist", {
  settings = {
    formatterMode = "typstyle",
    exportPdf = "never", -- :TypstWatch owns compilation
  },
})

vim.lsp.enable("tinymist")
