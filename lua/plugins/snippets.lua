return {
  {
    "L3MON4D3/LuaSnip",
    event = "LazyLoad",
    config = function()
      local ls = require("luasnip")

      s({
        trig = "init",
        snippetType = "snippet",
        desc = "Initialise .org file with some metadata...",
      }, {
          t("#+TITLE: ...\n#+AUTHOR: Michele De Cillis")
        })
    end,
  }
}
