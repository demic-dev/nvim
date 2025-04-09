local icons = require("icons")

return {
  -- Git signs in the gutter
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      signs = {
        add = { text = icons.git.LineAdded },
        change = { text = icons.git.LineModified },
        delete = { text = icons.git.LineRemoved },
        topdelete = { text = icons.git.LineRemoved },
        changedelete = { text = icons.git.LineModified },
        untracked = { text = icons.ui.BoldLine },
      },
      signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
      numhl = false,     -- Toggle with `:Gitsigns toggle_numhl`
      linehl = false,    -- Toggle with `:Gitsigns toggle_linehl`
      word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
      watch_gitdir = {
        interval = 1000,
        follow_files = true,
      },
      attach_to_untracked = true,
      current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
        delay = 1000,
        ignore_whitespace = false,
      },
      current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
      sign_priority = 6,
      update_debounce = 100,
      status_formatter = nil, -- Use default
      max_file_length = 40000, -- Disable if file is longer than this (in lines)
      preview_config = {
        -- Options passed to nvim_open_win
        border = "rounded",
        style = "minimal",
        relative = "cursor",
        row = 0,
        col = 1,
      },
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map('n', ']c', function()
          if vim.wo.diff then return ']c' end
          vim.schedule(function() gs.next_hunk() end)
          return '<Ignore>'
        end, {expr=true, desc = "Next Hunk"})

        map('n', '[c', function()
          if vim.wo.diff then return '[c' end
          vim.schedule(function() gs.prev_hunk() end)
          return '<Ignore>'
        end, {expr=true, desc = "Previous Hunk"})

        -- Actions
        map('n', '<leader>hs', gs.stage_hunk, { desc = "Stage Hunk" })
        map('n', '<leader>hr', gs.reset_hunk, { desc = "Reset Hunk" })
        map('v', '<leader>hs', function() gs.stage_hunk {vim.fn.line('.'), vim.fn.line('v')} end, { desc = "Stage Selected Hunk" })
        map('v', '<leader>hr', function() gs.reset_hunk {vim.fn.line('.'), vim.fn.line('v')} end, { desc = "Reset Selected Hunk" })
        map('n', '<leader>hS', gs.stage_buffer, { desc = "Stage Buffer" })
        map('n', '<leader>hu', gs.undo_stage_hunk, { desc = "Undo Stage Hunk" })
        map('n', '<leader>hR', gs.reset_buffer, { desc = "Reset Buffer" })
        map('n', '<leader>hp', gs.preview_hunk, { desc = "Preview Hunk" })
        map('n', '<leader>hb', function() gs.blame_line{full=true} end, { desc = "Blame Line" })
        map('n', '<leader>tb', gs.toggle_current_line_blame, { desc = "Toggle Line Blame" })
        map('n', '<leader>hd', gs.diffthis, { desc = "Diff This" })
        map('n', '<leader>hD', function() gs.diffthis('~') end, { desc = "Diff This ~" })
        map('n', '<leader>td', gs.toggle_deleted, { desc = "Toggle Deleted" })
      end,
    },
  },

  -- Git diff view and merge conflict resolution
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewFileHistory" },
    keys = {
      { "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "DiffView Open" },
      { "<leader>gh", "<cmd>DiffviewFileHistory %<cr>", desc = "File History" },
      { "<leader>gH", "<cmd>DiffviewFileHistory<cr>", desc = "Repository History" },
    },
    opts = {
      diff_binaries = false,
      enhanced_diff_hl = true,
      git_cmd = { "git" },
      use_icons = true,
      icons = {
        folder_closed = icons.kind.Folder,
        folder_open = icons.kind.Folder,
      },
      signs = {
        fold_closed = icons.ui.Triangle,
        fold_open = icons.ui.Triangle,
        done = icons.ui.Tick,
      },
      view = {
        default = {
          layout = "diff2_horizontal",
          winbar_info = false,
        },
        merge_tool = {
          layout = "diff3_horizontal",
          disable_diagnostics = true,
          winbar_info = true,
        },
        file_history = {
          layout = "diff2_horizontal",
          winbar_info = false,
        },
      },
      file_panel = {
        listing_style = "tree",
        tree_options = {
          flatten_dirs = true,
          folder_statuses = "only_folded",
        },
        win_config = {
          position = "left",
          width = 35,
          win_opts = {},
        },
      },
      file_history_panel = {
        log_options = {
          git = {
            single_file = {
              max_count = 512,
              follow = true,
            },
            multi_file = {
              max_count = 128,
            },
          },
        },
        win_config = {
          position = "bottom",
          height = 16,
          win_opts = {},
        },
      },
      commit_log_panel = {
        win_config = {
          win_opts = {},
        },
      },
      default_args = {
        DiffviewOpen = {},
        DiffviewFileHistory = {},
      },
      hooks = {},
      keymaps = {
        disable_defaults = false,
        view = {
          ["<tab>"] = "select_next_entry",
          ["<s-tab>"] = "select_prev_entry",
          ["gf"] = "goto_file",
          ["<C-w><C-f>"] = "goto_file_split",
          ["<C-w>gf"] = "goto_file_tab",
          ["<leader>e"] = "focus_files",
          ["<leader>b"] = "toggle_files",
          ["q"] = "close",
        },
        file_panel = {
          ["j"] = "next_entry",
          ["<down>"] = "next_entry",
          ["k"] = "prev_entry",
          ["<up>"] = "prev_entry",
          ["<cr>"] = "select_entry",
          ["o"] = "select_entry",
          ["R"] = "refresh_files",
          ["<tab>"] = "select_next_entry",
          ["<s-tab>"] = "select_prev_entry",
          ["gf"] = "goto_file",
          ["<C-w><C-f>"] = "goto_file_split",
          ["<C-w>gf"] = "goto_file_tab",
          ["i"] = "listing_style",
          ["f"] = "toggle_flatten_dirs",
          ["<leader>e"] = "focus_files",
          ["<leader>b"] = "toggle_files",
          ["q"] = "close",
        },
        file_history_panel = {
          ["g!"] = "options",
          ["<C-A-d>"] = "open_in_diffview",
          ["y"] = "copy_hash",
          ["L"] = "open_commit_log",
          ["zR"] = "open_all_folds",
          ["zM"] = "close_all_folds",
          ["j"] = "next_entry",
          ["<down>"] = "next_entry",
          ["k"] = "prev_entry",
          ["<up>"] = "prev_entry",
          ["<cr>"] = "select_entry",
          ["o"] = "select_entry",
          ["<tab>"] = "select_next_entry",
          ["<s-tab>"] = "select_prev_entry",
          ["gf"] = "goto_file",
          ["<C-w><C-f>"] = "goto_file_split",
          ["<C-w>gf"] = "goto_file_tab",
          ["<leader>e"] = "focus_files",
          ["<leader>b"] = "toggle_files",
          ["q"] = "close",
        },
        option_panel = {
          ["<tab>"] = "select",
          ["q"] = "close",
        },
      },
    },
  },
}