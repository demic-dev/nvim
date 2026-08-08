vim.pack.add({ "https://github.com/nvim-mini/mini.nvim" })

local hipatterns = require("mini.hipatterns")

-- mini's own hex highlighter paints with 24-bit colors, which a 16-color
-- terminal ignores; these swatches use the nearest xterm-256 cube index.
local function swatch(_, match)
  local group = "HexSwatch" .. match:sub(2)
  if vim.fn.hlexists(group) == 0 then
    local channels = { tonumber(match:sub(2, 3), 16), tonumber(match:sub(4, 5), 16), tonumber(match:sub(6, 7), 16) }
    local cube = vim.tbl_map(function(c)
      return math.floor(c * 5 / 255 + 0.5)
    end, channels)
    local luminance = 0.299 * channels[1] + 0.587 * channels[2] + 0.114 * channels[3]
    vim.api.nvim_set_hl(0, group, {
      ctermbg = 16 + 36 * cube[1] + 6 * cube[2] + cube[3],
      ctermfg = luminance > 127 and 0 or 15,
      bg = match,
    })
  end
  return group
end

hipatterns.setup({
  highlighters = {
    fixme = { pattern = "%f[%w]()FIXME()%f[%W]", group = "MiniHipatternsFixme" },
    hack = { pattern = "%f[%w]()HACK()%f[%W]", group = "MiniHipatternsHack" },
    todo = { pattern = "%f[%w]()TODO()%f[%W]", group = "MiniHipatternsTodo" },
    note = { pattern = "%f[%w]()NOTE()%f[%W]", group = "MiniHipatternsNote" },
    hex_color = { pattern = "#%x%x%x%x%x%x%f[%X]", group = swatch },
  },
})
