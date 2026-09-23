-- Web frameworks. JSX and TSX are already served by vtsls (see typescript.lua),
-- so only Svelte and Vue need servers of their own. Both embed their own CSS and
-- HTML language services, so cssls and html are here for standalone files only.
vim.lsp.enable({ "cssls", "html", "svelte" })

-- Since version 3 the Vue server runs exclusively in hybrid mode: it owns the
-- template and style blocks and forwards every TypeScript request to vtsls,
-- which must therefore attach to .vue buffers with @vue/typescript-plugin
-- loaded. Nix ships that plugin inside the vue-language-server package.
local vue_prefix = vim.fn.fnamemodify(vim.fn.resolve(vim.fn.exepath("vue-language-server")), ":h:h")

vim.lsp.config("vtsls", {
  filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "vue" },
  settings = {
    vtsls = {
      tsserver = {
        globalPlugins = {
          {
            name = "@vue/typescript-plugin",
            location = vue_prefix .. "/lib/language-tools/packages/language-server",
            languages = { "vue" },
            configNamespace = "typescript",
          },
        },
      },
    },
  },
})

vim.lsp.enable("vue_ls")
