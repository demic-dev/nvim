vim.pack.add({ "https://github.com/folke/snacks.nvim" })

require("snacks").setup({
  bigfile = { enabled = true },
  explorer = { enabled = true },
  indent = { enabled = true },
  input = { enabled = true },
  picker = { enabled = true },
  words = { enabled = true }, -- highlight other references to the word under the cursor
  quickfile = { enabled = true },
  dashboard = {
    -- The default sections end with a footer that reads lazy.nvim's stats,
    -- which vim.pack cannot provide.
    sections = {
      { section = "header" },
      { section = "keys", gap = 1, padding = 1 },
      { section = "recent_files", title = "Recent", limit = 5, padding = 1 },
    },
    preset = {
      keys = {
        { icon = " ", key = "f", desc = "Find file", action = ":lua Snacks.picker.files()" },
        { icon = " ", key = "r", desc = "Recent files", action = ":lua Snacks.picker.recent()" },
        { icon = " ", key = "g", desc = "Grep", action = ":lua Snacks.picker.grep()" },
        { icon = " ", key = "s", desc = "Restore session", action = ":SessionRestore" },
        { icon = " ", key = "n", desc = "New note", action = ":Obsidian new" },
        { icon = " ", key = "c", desc = "Config", action = ":lua Snacks.picker.files({ cwd = vim.fn.stdpath('config') })" },
        { icon = " ", key = "q", desc = "Quit", action = ":qa" },
      },
    },
  },
})

local map = vim.keymap.set

map("n", "<leader><leader>", function()
  Snacks.picker.files()
end, { desc = "Find files" })
map("n", "<leader>/", function()
  Snacks.picker.grep()
end, { desc = "Grep" })
map("n", "<leader>,", function()
  -- Land on the list, not the filter box: with few buffers j/k beats typing.
  -- `i` or `/` switches to filtering.
  Snacks.picker.buffers({ focus = "list" })
end, { desc = "Buffers" })
map("n", "<leader>e", function()
  Snacks.explorer()
end, { desc = "Explorer" })

map("n", "<leader>su", function()
  Snacks.picker.undo()
end, { desc = "Undo history" })
map("n", "<leader>st", function()
  Snacks.picker.grep({ search = "TODO|FIXME|NOTE|HACK", regex = true, live = false })
end, { desc = "Search TODOs" })
map("n", "<leader>ss", function()
  Snacks.picker.lsp_symbols()
end, { desc = "Document symbols" })
map("n", "<leader>sh", function()
  Snacks.picker.help()
end, { desc = "Help pages" })
map("n", "<leader>sr", function()
  Snacks.picker.resume()
end, { desc = "Resume last picker" })

map({ "n", "t" }, "<C-\\>", function()
  Snacks.terminal.toggle()
end, { desc = "Toggle terminal" })
