-- Org mode configuration for Neovim
-- Using nvim-orgmode and orgmode.nvim plugins

return {
  -- Main org-mode plugin for Neovim
  {
    "nvim-orgmode/orgmode",
    dependencies = {
      { "nvim-treesitter/nvim-treesitter", lazy = true },
    },
    event = "VeryLazy",
    config = function()
      -- Load treesitter grammar for org
      require("orgmode").setup_ts_grammar()

      -- Setup treesitter
      require("nvim-treesitter.configs").setup({
        highlight = {
          enable = true,
        },
        ensure_installed = { "org" },
      })

      require("orgmode").setup({
        org_agenda_files = { "~/org/*", "~/Documents/org/*" },
        org_default_notes_file = "~/org/refile.org",
        org_hide_emphasis_markers = true,
        org_highlight_latex_and_related = "entities",
        org_todo_keywords = { "TODO", "NEXT", "WAITING", "DONE" },
        mappings = {
          global = {
            org_agenda = "<Leader>oa",
            org_capture = "<Leader>oc",
          },
        },
        org_capture_templates = {
          t = {
            description = "Todo",
            template = "* TODO %?\n  %u",
            target = "~/org/todo.org",
          },
          n = {
            description = "Notes",
            template = "* %?\n  %u",
            target = "~/org/notes.org",
          },
        },
      })
    end,
  },
  
  -- Org-roam for networked thought in org mode
  {
    "chipsenkbeil/org-roam.nvim",
    dependencies = {
      "nvim-orgmode/orgmode",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    },
    config = function()
      require("org-roam").setup({
        directory = "~/org-roam", -- Directory where your org-roam files will be stored
        db_path = "~/.org-roam.db", -- Path to your org-roam database
        
        -- Daily notes configuration
        dailies = {
          directory = "~/org-roam/daily/", -- Directory for daily notes
          today_heading = true, -- Add a heading with today's date
          filename_format = "%Y-%m-%d", -- Format for the daily note filenames
        },
        
        -- Key mappings for org-roam functionality
        mappings = {
          -- Global mappings
          global = {
            -- Find an existing note
            org_roam_find = "<leader>rf",
            -- Insert a link to another note
            org_roam_insert = "<leader>ri",
            -- Open the org-roam graph
            org_roam_graph = "<leader>rg",
            -- Open today's daily note
            org_roam_dailies_today = "<leader>rt",
            -- Find a daily note
            org_roam_dailies_find = "<leader>rd",
            -- Create a capture in a daily note
            org_roam_dailies_capture = "<leader>rc",
          },
          
          -- Mappings in org mode buffers
          org = {
            -- Follow a link to another org-roam note
            org_roam_follow = "<leader>rf",
          },
        },
        
        -- Templates for creating new notes
        templates = {
          default = {
            title = "%?", -- %? Will be replaced with the cursor position
            template = [[
* %?
%u

]], -- %u inserts a timestamp
          },
          project = {
            title = "Project: %?",
            template = [[
* Project: %?
%u

** Goals

** Tasks

** Notes

]],
          },
          literature = {
            title = "Literature: %?",
            template = [[
* %?
%u

** Source
  
** Summary

** Notes

** References

]],
          },
        },
      })
    end,
  },
  
  -- Org bullets for better visual representation
  {
    "akinsho/org-bullets.nvim",
    dependencies = { "nvim-orgmode/orgmode" },
    config = function()
      require("org-bullets").setup({
        symbols = { "◉", "○", "✸", "✿" },
      })
    end,
  },
  
  -- Markdown preview for org files
  {
    "dhruvasagar/vim-table-mode",
    ft = { "org", "markdown" },
    cmd = "TableModeToggle",
    config = function()
      vim.g.table_mode_corner = "|"
    end,
  },
}
