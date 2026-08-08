vim.pack.add({ "https://github.com/folke/snacks.nvim" })
require("snacks")

-- The float style lazygit uses already asks for `backdrop = 60`, but snacks
-- draws that by blending a black float over the editor, and it skips the whole
-- thing when termguicolors is off (snacks/win.lua, `drop`). 16 colors cannot
-- blend, so the nearest equivalent is a solid pane behind the modal: no real
-- opacity, but enough to tell lazygit apart from the buffer underneath.
local backdrop

local function open_backdrop()
  if backdrop and backdrop:valid() then
    return
  end
  -- Set here rather than once at startup so a :colorscheme cannot clear it.
  vim.api.nvim_set_hl(0, "LazygitBackdrop", { ctermbg = 8 })
  backdrop = Snacks.win({
    enter = false,
    backdrop = false,
    relative = "editor",
    width = 0, -- 0 means "fill the editor" in snacks
    height = 0,
    style = "minimal",
    border = "none",
    focusable = false,
    zindex = 49, -- the float style sits at 50
    wo = { winhighlight = "Normal:LazygitBackdrop" },
    bo = { buftype = "nofile", filetype = "lazygit_backdrop" },
  })
end

local function close_backdrop()
  if backdrop then
    backdrop:close()
    backdrop = nil
  end
end

vim.keymap.set("n", "<leader>gg", function()
  Snacks.lazygit({
    win = {
      on_win = open_backdrop,
      on_close = close_backdrop,
    },
  })
end, { desc = "Lazygit" })
