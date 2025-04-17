-- filepath: /Users/micheledecillis/.config/nvim-config/lua/plugins/text_editing/markdown.lua
return {
  -- Markdown support
  {
    "preservim/vim-markdown",
    ft = { "markdown" },
    dependencies = { "godlygeek/tabular" },
    init = function()
      -- Disable folding
      vim.g.vim_markdown_folding_disabled = 1
      -- Enable TOC auto update
      vim.g.vim_markdown_toc_autofit = 1
      -- Highlight YAML front matter
      vim.g.vim_markdown_frontmatter = 1
      -- Enable strikethrough with ~~text~~
      vim.g.vim_markdown_strikethrough = 1
      -- Enable math highlighting
      vim.g.vim_markdown_math = 1
      -- Don't require .md extension for markdown files
      vim.g.vim_markdown_auto_extension_ext = 'md'
    end,
  },
  
  -- Markdown preview
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function()
      vim.cmd[[Lazy load markdown-preview.nvim]]
      vim.fn["mkdp#util#install"]()
    end,
    init = function()
      vim.g.mkdp_auto_start = 0
      vim.g.mkdp_auto_close = 1
      vim.g.mkdp_refresh_slow = 0
      vim.g.mkdp_browser = ""
      vim.g.mkdp_echo_preview_url = 1
    end,
    keys = {
      { "<leader>mp", "<cmd>MarkdownPreview<cr>", desc = "Markdown Preview" },
      { "<leader>ms", "<cmd>MarkdownPreviewStop<cr>", desc = "Markdown Preview Stop" },
    },
  },

  -- Beautiful math display for scientific writing
  {
    "jbyuki/nabla.nvim",
    ft = { "markdown", "tex" },
    keys = {
      { "<leader>mm", function() require("nabla").toggle_virt() end, desc = "Toggle Math Preview" },
      { "<leader>mp", function() require("nabla").popup() end, desc = "Math Preview Popup" },
    },
  },

  -- Markdown/Org-mode document highlights and decorations
  --[[ {
    "lukas-reineke/headlines.nvim",
    ft = { "org", "norg" },
    dependencies = "nvim-treesitter/nvim-treesitter",
    opts = {
      org = {
        headline_highlights = { "Headline1", "Headline2", "Headline3" },
        fat_headline_upper_string = "",
        fat_headline_lower_string = "",
      },
    },
    config = function(_, opts)
      -- Create highlight groups
      vim.api.nvim_set_hl(0, "Headline1", { fg = "#7aa2f7", bg = "#24293b", bold = true })
      vim.api.nvim_set_hl(0, "Headline2", { fg = "#e0af69", bg = "#2e2a2d", bold = true })
      vim.api.nvim_set_hl(0, "Headline3", { fg = "#9ece6a", bg = "#272d2d", bold = true })
      vim.api.nvim_set_hl(0, "CodeBlock", { bg = "#282828" })
      vim.api.nvim_set_hl(0, "Dash", { fg = "#d65d0e", bold = true })
      vim.api.nvim_set_hl(0, "Quote", { fg = "#928374", italic = true })
      
      require("headlines").setup(opts)
    end,
  }, ]]
  {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
    ft = { "markdown" },
    opts = {
      render_modes = true,
      file_types = { "markdown" },
      sign = {
        enabled = false,
      },
    },
  },
}
