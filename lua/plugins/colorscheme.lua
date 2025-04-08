return {
  -- Nightfox theme
  {
    "EdenEast/nightfox.nvim",
    priority = 1000, -- Load colorscheme before other plugins
    config = function()
      require("nightfox").setup({
        options = {
          transparent = false,
          terminal_colors = true,
          styles = {
            comments = "italic",
            keywords = "bold",
            types = "italic,bold",
          },
        },
      })
      
      -- Set the colorscheme
      vim.cmd.colorscheme("duskfox")
    end,
  },
}