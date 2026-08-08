-- Shared LSP setup. nvim-lspconfig only supplies the per-server defaults that
-- vim.lsp.enable() picks up; each language lives in its own file next to this one.
vim.pack.add({ "https://github.com/neovim/nvim-lspconfig" })

local ok, blink = pcall(require, "blink.cmp")
if ok then
  vim.lsp.config("*", { capabilities = blink.get_lsp_capabilities(nil, true) })
end

vim.diagnostic.config({
  severity_sort = true,
  virtual_text = { spacing = 2 },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "E",
      [vim.diagnostic.severity.WARN] = "W",
      [vim.diagnostic.severity.INFO] = "I",
      [vim.diagnostic.severity.HINT] = "H",
    },
  },
})

-- Neovim 0.12 already maps K, grn, gra, grr, gri and gO on attach.
vim.api.nvim_create_autocmd("LspAttach", {
  desc = "LSP keymaps",
  callback = function(ev)
    local map = function(lhs, rhs, desc)
      vim.keymap.set("n", lhs, rhs, { buffer = ev.buf, desc = desc })
    end

    map("gd", function()
      if Snacks then
        Snacks.picker.lsp_definitions()
      else
        vim.lsp.buf.definition()
      end
    end, "Goto definition")

    map("<leader>f", function()
      vim.lsp.buf.format()
    end, "Format buffer")
  end,
})
