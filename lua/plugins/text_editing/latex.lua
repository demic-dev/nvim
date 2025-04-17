-- filepath: /Users/micheledecillis/.config/nvim-config/lua/plugins/text_editing/latex.lua
return {
  -- LaTeX support
  {
    "lervag/vimtex",
    lazy = false,
    ft = { "tex", "bib" },
    init = function()
      vim.g.vimtex_view_method = 'zathura'    -- For Wayland compatibility, avoid xdotool
      -- vim.g.vimtex_context_pdf_viewer = 'okular'     -- External PDF viewer for the Vimtex menu

      -- Formatting settings
      vim.g.vimtex_format_enabled = true             -- Enable formatting with latexindent
      vim.g.vimtex_format_program = 'latexindent'

      -- Indentation settings
      vim.g.vimtex_indent_enabled = false            -- Disable auto-indent from Vimtex
      vim.g.tex_indent_items = false                 -- Disable indent for enumerate
      vim.g.tex_indent_brace = false                 -- Disable brace indent

      -- Suppression settings
      vim.g.vimtex_quickfix_mode = 0                 -- Suppress quickfix on save/build
      vim.g.vimtex_log_ignore = {                    -- Suppress specific log messages
        'Underfull',
        'Overfull',
        'specifier changed to',
        'Token not allowed in a PDF string',
      }

      -- Other settings
      vim.g.vimtex_mappings_enabled = false          -- Disable default mappings
      vim.g.tex_flavor = 'latex'                     -- Set file type for TeX files,
    end,
    keys = {
      { "<leader>ll", "<cmd>VimtexCompile<cr>", desc = "Compile LaTeX" },
      { "<leader>lv", "<cmd>VimtexView<cr>", desc = "View PDF" },
      { "<leader>lt", "<cmd>VimtexTocOpen<cr>", desc = "Open TOC" },
      { "<leader>lc", "<cmd>VimtexClean<cr>", desc = "Clean auxiliary files" },
    },
  },
}
