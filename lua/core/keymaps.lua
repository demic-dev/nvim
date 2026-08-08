local map = vim.keymap.set

map("n", "<leader>bd", "<cmd>bd<cr>", { desc = "Close buffer" })

-- Keep the selection while indenting, like every other editor.
map("x", "<Tab>", ">gv", { desc = "Indent selection" })
map("x", "<S-Tab>", "<gv", { desc = "Dedent selection" })

-- Also in terminal mode, so the Claude and shell splits are not one-way doors.
-- This shadows the TUI's own <C-j>; use \<CR> or <S-CR> for a literal newline.
for _, direction in ipairs({ "h", "j", "k", "l" }) do
  map({ "n", "t" }, "<C-" .. direction .. ">", "<C-\\><C-n><C-w>" .. direction, { desc = "Window " .. direction })
end

map("n", "<C-Left>", "<cmd>vertical resize -4<cr>", { desc = "Narrow window" })
map("n", "<C-Right>", "<cmd>vertical resize +4<cr>", { desc = "Widen window" })
map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Shorten window" })
map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Heighten window" })
map("n", "<leader>w=", "<C-w>=", { desc = "Equalize windows" })

-- <cmd> keeps the current mode, so saving mid-insert does not kick you out.
map({ "n", "i", "x" }, "<C-s>", "<cmd>write<cr>", { desc = "Save file" })

map("n", "<Esc>", "<cmd>nohlsearch<cr>", { desc = "Clear search highlight" })
map("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Leave terminal mode" })

map("n", "<leader>ts", function()
  vim.o.spell = not vim.o.spell
end, { desc = "Toggle spell check" })

map("n", "<leader>xx", function()
  vim.diagnostic.setqflist()
end, { desc = "Diagnostics to quickfix" })
