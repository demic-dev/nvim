-- Harper checks English; Vim's spell checker covers the remaining languages
-- listed in spelllang. Both are off until toggled. lspconfig limits harper_ls
-- to a fixed list of filetypes; listing every known filetype extends it to all files.
vim.lsp.config("harper_ls", { filetypes = vim.fn.getcompletion("", "filetype") })

vim.keymap.set("n", "<leader>ts", function()
  local enable = not vim.lsp.is_enabled("harper_ls")
  vim.lsp.enable("harper_ls", enable)
  vim.o.spell = enable
end, { desc = "Toggle spell check" })
