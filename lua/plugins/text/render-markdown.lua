vim.pack.add({ "https://github.com/MeanderingProgrammer/render-markdown.nvim" })

require("render-markdown").setup({
  completions = { blink = { enabled = true } },
  -- Show the raw markup of the line being edited.
  anti_conceal = { enabled = true },
})
