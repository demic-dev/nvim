vim.pack.add({ "https://github.com/lewis6991/gitsigns.nvim" })

require("gitsigns").setup({
  on_attach = function(buf)
    local gs = require("gitsigns")
    local map = function(mode, lhs, rhs, desc)
      vim.keymap.set(mode, lhs, rhs, { buffer = buf, desc = desc })
    end

    map("n", "]c", function()
      gs.nav_hunk("next")
    end, "Next hunk")
    map("n", "[c", function()
      gs.nav_hunk("prev")
    end, "Previous hunk")

    map({ "n", "v" }, "<leader>gs", gs.stage_hunk, "Stage hunk")
    map({ "n", "v" }, "<leader>gr", gs.reset_hunk, "Reset hunk")
    map("n", "<leader>gp", gs.preview_hunk, "Preview hunk")
    map("n", "<leader>gb", function()
      gs.blame_line({ full = true })
    end, "Blame line")
    map("n", "<leader>gB", gs.blame, "Blame buffer")
    map("n", "<leader>gd", gs.diffthis, "Diff buffer")
  end,
})
