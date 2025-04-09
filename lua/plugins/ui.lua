local icons = require("icons")

return {
  -- Enhanced UI experience with centered command-line
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify", -- Optional but recommended for notifications
    },
    opts = {
      cmdline = {
        enabled = true,
        view = "cmdline_popup", -- Use the pop-up view
        opts = {
          position = {
            row = "50%",
            col = "50%",
          },
          size = {
            width = "60%",
            height = "auto",
          },
        },
        icons = {
          ["/"] = { icon = icons.ui.Search, hl_group = "NoiceCmdlineIconSearch" },
          ["?"] = { icon = icons.ui.Search, hl_group = "NoiceCmdlineIconSearch" },
          [":"] = { icon = icons.ui.ChevronRight, hl_group = "NoiceCmdlineIconCommand" },
        },
      },
      messages = {
        enabled = true,
        view = "notify",
        view_error = "notify",
        view_warn = "notify",
        view_history = "messages",
        view_search = "virtualtext",
      },
      popupmenu = {
        enabled = true,
        backend = "nui", -- Use nui.nvim for the popupmenu
        kind_icons = {},
      },
      notify = {
        enabled = true,
        view = "notify",
      },
      lsp = {
        -- Override markdown rendering so that cmp and other plugins use Treesitter
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = false,
          ["vim.lsp.util.stylize_markdown"] = false,
          ["cmp.entry.get_documentation"] = true,
        },
        progress = {
          enabled = true,
          format = "lsp_progress",
          format_done = "lsp_progress_done",
          throttle = 1000 / 30, -- frequency to update lsp progress message
          view = "mini",
        },
      },
      presets = {
        bottom_search = false, -- use a classic bottom cmdline for search
        command_palette = true, -- position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages will be sent to a split
        inc_rename = false, -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = true, -- add a border to hover docs and signature help
      },
    },
    keys = {
      { "<leader>nl", function() require("noice").cmd("last") end, desc = "Noice Last Message" },
      { "<leader>nh", function() require("noice").cmd("history") end, desc = "Noice History" },
      { "<leader>na", function() require("noice").cmd("all") end, desc = "Noice All" },
      { "<leader>nd", function() require("noice").cmd("dismiss") end, desc = "Dismiss All Notifications" },
    },
  },
  
  -- Better UI components (dependency for Noice)
  {
    "MunifTanjim/nui.nvim",
    lazy = true,
  },

  -- Better notifications
  {
    "rcarriga/nvim-notify",
    lazy = true,
    opts = {
      timeout = 3000,
      max_height = function()
        return math.floor(vim.o.lines * 0.75)
      end,
      max_width = function()
        return math.floor(vim.o.columns * 0.75)
      end,
      background_colour = "#000000",
      stages = "fade",
    },
  },

  -- Color highlighter for color codes
  {
    "norcalli/nvim-colorizer.lua",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("colorizer").setup({
        "*", -- Highlight all files
        css = { css = true, css_fn = true },
        html = { names = false }, -- Disable color names in HTML to avoid conflicts
        markdown = { names = false },
      })
    end,
  },
}