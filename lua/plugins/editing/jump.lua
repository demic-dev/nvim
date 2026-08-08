vim.pack.add({ "https://github.com/nvim-mini/mini.nvim" })

-- The default <CR> trigger would shadow <CR> in the quickfix window.
require("mini.jump2d").setup({
  mappings = { start_jumping = "<leader>j" },
})
