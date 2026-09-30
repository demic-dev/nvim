vim.pack.add({ "https://github.com/nvim-mini/mini.nvim" })

require("mini.surround").setup()

-- Typing a delimiter over a selection wraps it, like in VS Code. mini.surround
-- pads with spaces when given an opening bracket, so the closing one is used.
-- This shadows the visual-mode sentence and paragraph motions on these keys.
-- A characterwise selection is extended over the delimiters, so another key wraps it again.
local wrappers = { ["("] = ")", ["["] = "]", ["{"] = "}", ['"'] = '"', ["'"] = "'", ["`"] = "`", ["*"] = "*", ["_"] = "_" }

for key, delimiter in pairs(wrappers) do
  vim.keymap.set("x", key, function()
    local mode = vim.fn.mode()
    local first, last = vim.fn.getpos("v"), vim.fn.getpos(".")
    if first[2] > last[2] or (first[2] == last[2] and first[3] > last[3]) then
      first, last = last, first
    end
    -- The closing delimiter follows the last byte of the selected character, shifted by the opening one on a single line.
    local last_col = last[3] + vim.str_utf_end(vim.fn.getline(last[2]), last[3]) + 1
    vim.api.nvim_feedkeys("sa" .. delimiter, "mx", false)
    if mode ~= "v" then
      return
    end
    if first[2] == last[2] then
      last_col = last_col + 1
    end
    vim.fn.setpos("'<", first)
    vim.fn.setpos("'>", { 0, last[2], last_col, 0 })
    vim.cmd("normal! gv")
  end, { desc = "Wrap selection in " .. key })
end
