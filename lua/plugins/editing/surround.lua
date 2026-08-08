vim.pack.add({ "https://github.com/nvim-mini/mini.nvim" })

require("mini.surround").setup()

-- Typing a delimiter over a selection wraps it, like in VS Code. mini.surround
-- pads with spaces when given an opening bracket, so the closing one is used.
-- This shadows the visual-mode sentence and paragraph motions on these keys.
local wrappers = { ["("] = ")", ["["] = "]", ["{"] = "}", ['"'] = '"', ["'"] = "'", ["`"] = "`", ["*"] = "*" }

for key, delimiter in pairs(wrappers) do
  vim.keymap.set("x", key, "sa" .. delimiter, { remap = true, desc = "Wrap selection in " .. key })
end
