return {
  -- Flash.nvim - Jump anywhere in the visible text with minimal keystrokes
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {
      labels = "asdfghjklqwertyuiopzxcvbnm",
      search = {
        -- search/jump in all windows
        multi_window = true,
        -- search direction
        forward = true,
        -- when true, search wraps around the buffer
        wrap = true,
        -- treat horizontal and vertical motions differently for efficiency
        incremental = true,
      },
      jump = {
        -- automatically jump when there's only one match
        autojump = true,
        -- position offset from the matched character
        position = { row = 0, col = 0 },
        -- highlight the jumped position
        highlight = true,
        -- This is the name of the highlight group for the jumped position
        highlight_group = "FlashMatch",
      },
      label = {
        -- enable this to show the label before the match
        before = true,
        -- enable this to show the label after the match
        after = false,
        -- position of the label extmark
        position = "overlay",
        -- flash tries to re-use labels that were already assigned to a position
        reuse = "all",
      },
      modes = {
        search = {
          enabled = true,
        },
        char = {
          enabled = true,
          jump_labels = true,
        },
      },
    },
    keys = {
      {
        "s",
        mode = { "n", "x", "o" },
        function()
          require("flash").jump()
        end,
        desc = "Flash Jump",
      },
    },
  },
}