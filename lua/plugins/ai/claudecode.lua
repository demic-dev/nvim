vim.pack.add({
  "https://github.com/folke/snacks.nvim", -- terminal provider
  "https://github.com/coder/claudecode.nvim",
})
require("snacks")

require("claudecode").setup({
  terminal = { provider = "snacks" },
  log_level = "warn", -- the default logs a message on every exit
})

local map = vim.keymap.set

map("n", "<leader>ac", "<cmd>ClaudeCode<cr>", { desc = "Toggle Claude" })
map("n", "<leader>af", "<cmd>ClaudeCodeFocus<cr>", { desc = "Focus Claude" })
map("n", "<leader>ar", "<cmd>ClaudeCode --resume<cr>", { desc = "Resume Claude" })
map("n", "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>", { desc = "Add buffer to context" })
map("x", "<leader>as", "<cmd>ClaudeCodeSend<cr>", { desc = "Send selection" })
map("n", "<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>", { desc = "Accept diff" })
map("n", "<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>", { desc = "Deny diff" })
