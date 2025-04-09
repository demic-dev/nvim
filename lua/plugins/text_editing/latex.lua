-- filepath: /Users/micheledecillis/.config/nvim-config/lua/plugins/text_editing/latex.lua
return {
  -- LaTeX support
  {
    "lervag/vimtex",
    lazy = false,
    ft = { "tex", "bib" },
    init = function()
      -- PDF viewer settings
      vim.g.vimtex_view_method = 'skim'
      
      -- Don't open the quickfix window automatically for warnings
      vim.g.vimtex_quickfix_mode = 0
      
      -- Enable custom syntax highlighting
      vim.g.vimtex_syntax_enabled = 1
      
      -- Configure the TOC window
      vim.g.vimtex_toc_config = {
        split_pos = 'rightbelow',
        split_width = 30,
        tocdepth = 3,
        fold_enable = 1,
        fold_level_start = 1,
        show_help = 0,
      }

      -- Use latex flavor instead of plaintex
      vim.g.tex_flavor = 'latex'
      
      -- Set the main file build directory
      vim.g.vimtex_compiler_latexmk = {
        build_dir = "build",
      }
      
      -- Setup concealing for better LaTeX display
      vim.g.vimtex_syntax_conceal = {
        accents = 1,
        ligatures = 1,
        cites = 1,
        fancy = 1,
        spacing = 1,
        greek = 1,
        math_bounds = 1,
        math_delimiters = 1,
        math_fracs = 1,
        math_super_sub = 1,
        math_symbols = 1,
        sections = 1,
        styles = 1,
      }
    end,
    keys = {
      { "<leader>ll", "<cmd>VimtexCompile<cr>", desc = "Compile LaTeX" },
      { "<leader>lv", "<cmd>VimtexView<cr>", desc = "View PDF" },
      { "<leader>lt", "<cmd>VimtexTocOpen<cr>", desc = "Open TOC" },
      { "<leader>lc", "<cmd>VimtexClean<cr>", desc = "Clean auxiliary files" },
    },
  },
}