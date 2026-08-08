vim.pack.add({ "https://github.com/obsidian-nvim/obsidian.nvim" })

local vault = vim.fn.expand("~/Documents/notes")

-- Without a vault obsidian.nvim errors out, so stay out of the way until the
-- path above points somewhere real. Silently: a message here would make every
-- startup end in a "Press ENTER" prompt.
if vim.fn.isdirectory(vault) == 0 then
  return
end

require("obsidian").setup({
  legacy_commands = false,
  workspaces = { { name = "notes", path = vault } },
  picker = { name = "snacks.pick" },
  ui = { enable = false }, -- render-markdown.nvim draws the buffer
  -- Wiki-link and tag completion comes from obsidian's own LSP server, which
  -- blink.cmp picks up like any other.
})

-- :Obsidian paste_img writes the clipboard image into the vault and links it.
vim.keymap.set("n", "<leader>ni", "<cmd>Obsidian paste_img<cr>", { desc = "Paste image" })
vim.keymap.set("n", "<leader>nn", "<cmd>Obsidian new<cr>", { desc = "New note" })
vim.keymap.set("n", "<leader>ns", "<cmd>Obsidian search<cr>", { desc = "Search notes" })
vim.keymap.set("n", "<leader>nt", "<cmd>Obsidian today<cr>", { desc = "Today's note" })
