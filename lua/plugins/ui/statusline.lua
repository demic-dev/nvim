vim.pack.add({ "https://github.com/nvim-mini/mini.nvim" })

local statusline = require("mini.statusline")

-- Same layout as mini's default, with the git section reading the branch that
-- gitsigns publishes instead of mini.git's.
statusline.setup({
  content = {
    active = function()
      local mode, mode_hl = statusline.section_mode({ trunc_width = 120 })
      local branch = vim.b.gitsigns_head and (" " .. vim.b.gitsigns_head) or ""
      local diagnostics = statusline.section_diagnostics({ trunc_width = 75 })
      local filename = statusline.section_filename({ trunc_width = 140 })
      local location = "%l:%v"
      local words = ""
      if vim.bo.filetype == "markdown" or vim.bo.filetype == "typst" then
        local count = vim.fn.wordcount().visual_words
        words = count and (count .. " words") or ""
      end

      return statusline.combine_groups({
        { hl = mode_hl, strings = { mode } },
        { hl = "MiniStatuslineDevinfo", strings = { branch, diagnostics } },
        "%<%=", -- truncate and right-align from here
        { hl = "MiniStatuslineFilename", strings = { filename } },
        "%=",
        { hl = "MiniStatuslineFileinfo", strings = { words, vim.bo.filetype } },
        { hl = mode_hl, strings = { location } },
      })
    end,
  },
})
