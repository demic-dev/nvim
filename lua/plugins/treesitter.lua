return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpnate",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = "all", 
        auto_install = true,
        ignore_install = { "org" },
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
          disable = { "latex" },
        },
        indent = { enable = true },
        autopairs = { enable = true },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "gnn",
            node_incremental = "grn",
            scope_incremental = "grc",
            node_decremental = "grm",
          },
        },
      })
    end,
  },
}
