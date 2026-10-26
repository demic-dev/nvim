vim.pack.add({
  "https://github.com/folke/snacks.nvim", -- terminal provider
  "https://github.com/coder/claudecode.nvim",
})
require("snacks")

-- Set only for the next spawn by <leader>ao; nil falls back to the default cwd.
local next_cwd

require("claudecode").setup({
  terminal = {
    provider = "snacks",
    cwd_provider = function()
      return next_cwd
    end,
  },
  log_level = "warn", -- the default logs a message on every exit
})

local map = vim.keymap.set

map("n", "<leader>ac", "<cmd>ClaudeCode<cr>", { desc = "Toggle Claude" })
map("n", "<leader>ao", function()
  local root = vim.fn.getcwd()
  -- fd respects .gitignore and skips hidden directories.
  local out = vim.system({ "fd", "--type", "d" }, { cwd = root, text = true }):wait().stdout
  local dirs = vim.split(out, "\n", { trimempty = true })
  table.sort(dirs)
  vim.ui.select(dirs, { prompt = "Open Claude in" }, function(dir)
    if not dir then
      return
    end
    -- A running session keeps its cwd, so it is replaced.
    local terminal = require("claudecode.terminal")
    terminal.close()
    next_cwd = root .. "/" .. dir
    terminal.open()
    next_cwd = nil
  end)
end, { desc = "Open Claude in subdirectory" })
map("n", "<leader>af", "<cmd>ClaudeCodeFocus<cr>", { desc = "Focus Claude" })
map("n", "<leader>ar", "<cmd>ClaudeCode --resume<cr>", { desc = "Resume Claude" })
map("n", "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>", { desc = "Add buffer to context" })
map("x", "<leader>as", "<cmd>ClaudeCodeSend<cr>", { desc = "Send selection" })
map("n", "<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>", { desc = "Accept diff" })
map("n", "<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>", { desc = "Deny diff" })
