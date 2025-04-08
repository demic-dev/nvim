return {
  {
    "nvimdev/dashboard-nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "VimEnter",
    config = function()
      require("dashboard").setup {
        theme = "doom",
        config = {
          header = {
            "",
            "   ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗",
            "   ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║",
            "   ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║",
            "   ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║",
            "   ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║",
            "   ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝",
            "",
          },
          center = {
            {
              icon = "󰈞 ",
              icon_hl = "Title",
              desc = "Find File",
              key = "f",
              key_hl = "Number", 
              action = "Telescope find_files"
            },
            {
              icon = "󰈢 ",
              icon_hl = "Title",
              desc = "Recent Files",
              key = "r",
              key_hl = "Number",
              action = "Telescope oldfiles"
            },
            {
              icon = " ",
              icon_hl = "Title",
              desc = "Find Word",
              key = "g",
              key_hl = "Number",
              action = "Telescope live_grep"
            },
            {
              icon = " ",
              icon_hl = "Title",
              desc = "New File",
              key = "n",
              key_hl = "Number",
              action = "enew"
            },
            {
              icon = " ",
              icon_hl = "Title",
              desc = "Configuration",
              key = "c",
              key_hl = "Number",
              action = "cd ~/.config/nvim-test-config | e init.lua"
            },
            {
              icon = " ",
              icon_hl = "Title",
              desc = "Exit Neovim",
              key = "q",
              key_hl = "Number",
              action = "qa"
            },
          },
          footer = {
            "",
            "Minimal Neovim Configuration",
            "",
          }
        },
      }
    end,
  },
}