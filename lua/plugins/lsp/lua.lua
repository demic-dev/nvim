vim.lsp.config("lua_ls", {
  settings = {
    Lua = {
      runtime = { version = "LuaJIT" },
      diagnostics = { globals = { "vim", "Snacks", "MiniStatusline" } },
      workspace = { checkThirdParty = false },
      format = {
        enable = true,
        defaultConfig = { indent_style = "space", indent_size = "2" },
      },
      hint = { enable = true },
    },
  },
})

vim.lsp.enable("lua_ls")
