vim.opt_local.conceallevel = 2 -- render-markdown hides the markup it draws
-- Wrapped quote lines need room for the repeated border; breakindent is set globally.
vim.opt_local.showbreak = "  "
vim.opt_local.breakindentopt = ""

-- Continue bullet and numbered lists on <CR> and o.
vim.opt_local.comments = "b:- [ ],b:- [x],b:-,b:*,b:+,b:>"
vim.opt_local.formatlistpat = [[^\s*\d\+[\]:.)}\t ]\s*]]
vim.opt_local.formatoptions:append("ron")
vim.opt_local.formatoptions:remove("t")

-- <CR> on an item with no text ends the list; on a numbered item it inserts the next number.
vim.keymap.set("i", "<CR>", function()
  local line = vim.api.nvim_get_current_line()
  if line:match("^%s*[-*+>]%s*$") or line:match("^%s*[-*+] %[.%]%s*$") or line:match("^%s*%d+[.)]%s*$") then
    return '<Esc>0"_C'
  end
  local number, delimiter = line:match("^%s*(%d+)([.)]) ")
  if number then
    return "<CR>" .. (number + 1) .. delimiter .. " "
  end
  return MiniPairs.cr()
end, { buffer = true, expr = true, desc = "Continue or end list" })

local lists = vim.treesitter.query.parse("markdown", "(list) @list")

-- Keeps each numbered list sequential from 1 after items are added or deleted.
local function renumber(args)
  local root = vim.treesitter.get_parser(args.buf, "markdown"):parse()[1]:root()
  local undo_joined = false
  for _, list in lists:iter_captures(root, args.buf) do
    local expected = 1
    for item in list:iter_children() do
      local marker = item:child(0)
      local kind = marker and marker:type()
      if kind == "list_marker_dot" or kind == "list_marker_parenthesis" then
        local row, col = marker:range()
        local text = vim.treesitter.get_node_text(marker, args.buf)
        local first, last = text:find("%d+")
        local number = tonumber(text:sub(first, last))
        if number ~= expected then
          if not undo_joined then
            pcall(vim.cmd.undojoin) -- renumbering is undone together with the edit that caused it
            undo_joined = true
          end
          vim.api.nvim_buf_set_text(args.buf, row, col + first - 1, row, col + last, { tostring(expected) })
        end
        expected = expected + 1
      end
    end
  end
end

local group = vim.api.nvim_create_augroup("markdown_lists", { clear = false })
vim.api.nvim_clear_autocmds({ group = group, buffer = 0 })
vim.api.nvim_create_autocmd({ "TextChanged", "InsertLeave" }, { group = group, buffer = 0, callback = renumber })
