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
      local orgmode = require("orgmode")

      orgmode.setup({
        org_agenda_files = { "~/.org/**/*" },
        org_default_notes_file = "~/.org/",
        org_hide_emphasis_markers = true,
        org_highlight_latex_and_related = "entities",
        org_todo_keywords = { "TODO(t)", "NEXT(n)", "WAITING(w)", "SOMEDAY/MAYBE(m)", "|", "DONE(d)", "CANCELLED(c)" },
        --[[ org_todo_keywords_faces = {
          TODO = "",
        }, ]]
        mappings = {
          global = {
            org_agenda = "<Leader>o<Leader>a",
            org_capture = "<Leader>o<Leader>c",
          },
        },
        org_capture_templates = {
          i = {
            description = "inbox",
            template = "* TODO %?\n  %u",
            target = "~/.org/inbox.org",
          },
          ic = {
            description = "inbox clipboard",
            template = "* TODO %x%?\n  %u",
            target = "~/.org/inbox.org",
          },
        },
        org_agenda_custom_commands = {
           c = {
            -- https://blog.jethro.dev/posts/processing_inbox/
            description = 'Combined view',
            types = {
              {
                type = 'agenda',
                org_agenda_overriding_header = 'Today agenda',
                org_agenda_span = 'day'
              },
              {
                type = 'agenda',
                org_agenda_overriding_header = 'Tomorrow agenda',
                org_agenda_span = 'day',
                org_agenda_start_day = '+1d',
              },
              {
                type = 'tags',
                org_agenda_overriding_header = 'To refile',
                org_agenda_files = "~/.org/inbox.org",
              },
              {
                type = 'tags',
                match = "+TODO=\"NEXT\"",
                org_agenda_overriding_header = 'In progress',
                org_agenda_files = "~/.org/**/*",
              },
              {
                type = 'tags',
                match = "+TODO=\"TODO\"",
                org_agenda_overriding_header = 'Projects',
                org_agenda_files = "~/.org/projects/*"
              },
              {
                type = 'tags',
                match = "+TODO=\"TODO\"",
                org_agenda_overriding_header = 'Areas',
                org_agenda_files = "~/.org/area/*"
              },
              {
                type = 'tags',
                org_agenda_overriding_header = 'One off tasks',
                org_agenda_files = "~/.org/one-off.org",
              },
            }
          },
        },
        ui = {
          input = {
            use_vim_ui = false
          }
        }
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
        directory = "~/.org/roam", -- Directory where your org-roam files will be stored
        db_path = "~/.org/roam/.org-roam.db", -- Path to your org-roam database
        
        -- Daily notes configuration
        dailies = {
          directory = "~/.org/roam/daily/", -- Directory for daily notes
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
            template = "[[ * %? %u ]]", -- %u inserts a timestamp
          },
          project = {
            title = "Project: %?",
            template = "[[ * Project: %? %u ** Goals ** Tasks ** Notes ]]",
          },
          literature = {
            title = "Literature: %?",
            template = "[[ * %? %u ** Source ** Summary ** Notes ** References ]]",
          },
        },
      })
    end,
    -- keys = {
    --   { "<leader>op", "[[:lua require('core.functions').process_inbox_item()<CR>]]", desc = "Process Inbox Item" }
    -- }
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

