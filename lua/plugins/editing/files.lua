vim.pack.add({ "https://github.com/nvim-mini/mini.nvim" })

require("mini.files").setup()

-- File tree as an editable buffer, next to the snacks explorer sidebar.
vim.keymap.set("n", "<leader>o", function()
  require("mini.files").open(vim.api.nvim_buf_get_name(0))
end, { desc = "Browse files from here" })
