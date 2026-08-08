vim.pack.add({ "https://github.com/dhruvasagar/vim-table-mode" })

vim.g.table_mode_corner = "|" -- markdown-style separators

vim.keymap.set("n", "<leader>tm", "<cmd>TableModeToggle<cr>", { desc = "Toggle table mode" })
