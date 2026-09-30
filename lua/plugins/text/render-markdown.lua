vim.pack.add({ "https://github.com/MeanderingProgrammer/render-markdown.nvim" })

local quotes = vim.treesitter.query.parse("markdown", "(block_quote) @quote")

-- render-markdown draws a callout title as an overlay, which does not wrap
-- with the line. An empty title keeps the tag concealed but draws nothing,
-- and quote_marks draws the icon and colors the title instead.
local quote = require("render-markdown.render.markdown.quote")
local title = quote.title
quote.title = function(...)
  return title(...) and ""
end

-- render-markdown draws the border only on lines that start with ">", but a
-- line without it directly below a quote still belongs to the quote (lazy
-- continuation).
local function quote_marks(ctx)
  local marks = {}
  for _, node in quotes:iter_captures(ctx.root, ctx.buf) do
    local ancestor = node:parent()
    while ancestor and ancestor:type() ~= "block_quote" do
      ancestor = ancestor:parent()
    end
    if ancestor then
      goto continue -- the outermost quote draws the border
    end

    local start_row, col, end_row, end_col = node:range()
    if end_col == 0 then
      end_row = end_row - 1
    end
    local lines = vim.api.nvim_buf_get_lines(ctx.buf, start_row, end_row + 1, false)

    local tag = lines[1]:match("^%s*>%s*(%[!%a+%])")
    local callout = tag and require("render-markdown.state").get(ctx.buf).resolved:callout({ text = tag })
    local hl = callout and callout.highlight or "RenderMarkdownQuote1"

    local tag_start, tag_end = lines[1]:find(tag or "", 1, true)
    if callout and lines[1]:find("%S", tag_end + 1) then
      marks[#marks + 1] = {
        conceal = true,
        start_row = start_row,
        start_col = tag_start - 1,
        opts = { virt_text = { { vim.split(callout.rendered, " ")[1], hl } }, virt_text_pos = "inline" },
      }
      marks[#marks + 1] = {
        conceal = false,
        start_row = start_row,
        start_col = tag_end,
        opts = { end_col = #lines[1], hl_group = hl },
      }
    end

    for i = 2, #lines do
      if lines[i] ~= "" and not lines[i]:match("^%s*>") then
        local row = start_row + i - 1
        marks[#marks + 1] = {
          conceal = false,
          start_row = row,
          start_col = 0,
          opts = { virt_text = { { "  " } }, virt_text_pos = "inline" },
        }
        marks[#marks + 1] = {
          conceal = false,
          start_row = row,
          start_col = 0,
          opts = { virt_text = { { "▋", hl } }, virt_text_win_col = col, virt_text_repeat_linebreak = true },
        }
      end
    end
    ::continue::
  end
  return marks
end

require("render-markdown").setup({
  completions = { blink = { enabled = true } },
  -- Show the raw markup of the line being edited.
  anti_conceal = { enabled = true },
  quote = { repeat_linebreak = true },
  custom_handlers = { markdown = { extends = true, parse = quote_marks } },
})
