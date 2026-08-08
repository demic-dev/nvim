vim.pack.add({
  { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
})

require("nvim-treesitter").setup()

-- Installs asynchronously and skips parsers that are already built.
require("nvim-treesitter").install({
  "bash",
  "json",
  "lua",
  "markdown",
  "markdown_inline",
  "nix",
  "python",
  "tsx",
  "typescript",
  "typst",
  "yaml",
})

vim.api.nvim_create_autocmd("FileType", {
  desc = "Start treesitter highlighting when a parser exists for the filetype",
  callback = function(ev)
    pcall(vim.treesitter.start, ev.buf)
  end,
})
