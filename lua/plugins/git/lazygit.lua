vim.pack.add({ "https://github.com/folke/snacks.nvim" })
require("snacks")

vim.keymap.set("n", "<leader>gg", function()
  Snacks.lazygit()
end, { desc = "Lazygit" })
