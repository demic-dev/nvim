vim.pack.add({ "https://github.com/kaarmu/typst.vim" })

-- :TypstWatch recompiles on save; zathura reloads the PDF on its own.
vim.g.typst_pdf_viewer = "zathura"
vim.g.typst_auto_open_quickfix = 0

vim.keymap.set("n", "<leader>tw", "<cmd>TypstWatch<cr>", { desc = "Typst watch" })
