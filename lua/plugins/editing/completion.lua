vim.pack.add({
  { src = "https://github.com/Saghen/blink.cmp", version = vim.version.range("1.*") },
})

require("blink.cmp").setup({
  -- The Rust matcher ships as a prebuilt binary that does not run unpatched on NixOS; the Lua one needs no build step.
  fuzzy = { implementation = "lua" },
  keymap = {
    -- super-tab accepts with <Tab>; <CR> is added so either key works.
    preset = "super-tab",
    -- ["<CR>"] = { "accept", "fallback" },
  },
  sources = { default = { "lsp", "path", "snippets", "buffer" } },
  signature = { enabled = true },
  completion = {
    documentation = { auto_show = true },
    ghost_text = { enabled = true },
  },
})
