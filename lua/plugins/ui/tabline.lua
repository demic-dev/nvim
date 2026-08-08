vim.pack.add({ "https://github.com/nvim-mini/mini.nvim" })

local tabline = require("mini.tabline")

tabline.setup({
  -- mini marks unsaved buffers by linking them to StatusLine, which is
  -- indistinguishable from the normal label in a 16-color terminal. Put the
  -- marker in the text instead.
  format = function(buf_id, label)
    local marker = vim.bo[buf_id].modified and "● " or ""
    return tabline.default_format(buf_id, label) .. marker
  end,
})
