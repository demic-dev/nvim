return {
  -- Zen mode for distraction-free writing
  {
    "folke/zen-mode.nvim",
    cmd = "ZenMode",
    keys = {
      { "<leader>z", "<cmd>ZenMode<cr>", desc = "Toggle Zen Mode" },
    },
    opts = {
      window = {
        width = 0.75, -- Width is set to 85% of the editor width
        options = {
          number = false,
          relativenumber = false,
          signcolumn = "no",
          cursorline = false,
          cursorcolumn = false,
          foldcolumn = "0",
          list = false,
        },
      },
      plugins = {
        options = {
          enabled = true,
          ruler = false,
          showcmd = false,
        },
        twilight = { enabled = true }, -- Enable Twilight when entering Zen Mode
        gitsigns = { enabled = false },
        tmux = { enabled = false },
        wezterm = { enabled = false, font = "+2" },
      },
    },
  },
  
  -- Twilight for dimming non-focused text (centered mode)
  {
    "folke/twilight.nvim",
    cmd = { "Twilight", "TwilightEnable", "TwilightDisable" },
    keys = {
      { "<leader>t", "<cmd>Twilight<cr>", desc = "Toggle Twilight" },
    },
    opts = {
      dimming = {
        alpha = 0.25, -- amount of dimming
        color = { "Normal", "#ffffff" },
        term_bg = "#000000", -- if guibg=NONE, this will be used to calculate text color
        inactive = false, -- when true, other windows will be fully dimmed
      },
      context = 15, -- amount of lines we will try to show around the current line
      treesitter = true, -- use treesitter when available for the filetype
      -- treesitter is used to automatically expand the visible text,
      -- but you can further control the types of nodes that should always be fully expanded
      expand = { -- for treesitter, we expand to textobjects.scm nodes
        "function",
        "method",
        "table",
        "if_statement",
        "function_definition",
        "class_definition",
        "argument_list",
      },
      exclude = {}, -- exclude these filetypes
    },
  },
}