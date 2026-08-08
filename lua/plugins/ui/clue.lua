vim.pack.add({ "https://github.com/nvim-mini/mini.nvim" })

local clue = require("mini.clue")

clue.setup({
  triggers = {
    { mode = "n", keys = "<Leader>" },
    { mode = "x", keys = "<Leader>" },
    { mode = "n", keys = "g" },
    { mode = "x", keys = "g" },
    { mode = "n", keys = "z" },
    { mode = "x", keys = "z" },
    { mode = "n", keys = "]" },
    { mode = "n", keys = "[" },
    { mode = "n", keys = "<C-w>" },
    { mode = "n", keys = '"' },
    { mode = "x", keys = '"' },
    { mode = "i", keys = "<C-x>" },
  },
  clues = {
    clue.gen_clues.builtin_completion(),
    clue.gen_clues.g(),
    clue.gen_clues.registers(),
    clue.gen_clues.windows(),
    clue.gen_clues.z(),
    { mode = "n", keys = "<Leader>a", desc = "+ai" },
    { mode = "n", keys = "<Leader>g", desc = "+git" },
    { mode = "n", keys = "<Leader>n", desc = "+notes" },
    { mode = "n", keys = "<Leader>s", desc = "+search" },
    { mode = "n", keys = "<Leader>t", desc = "+toggle" },
    { mode = "n", keys = "<Leader>w", desc = "+window" },
    { mode = "n", keys = "<Leader>x", desc = "+diagnostics" },
  },
  window = { delay = 300 },
})
