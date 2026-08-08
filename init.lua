if vim.fn.has("nvim-0.12") == 0 then
  error("This configuration requires Neovim 0.12 (vim.pack, vim.lsp.config)")
end

vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("core.options")
require("core.keymaps")
require("core.autocmds")
require("core.loader")
