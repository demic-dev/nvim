local map = vim.keymap.set

map("n", "<leader>q", "<cmd>bp|bd #<cr>", { desc = "Close buffer" })

-- Keep the selection while indenting, like every other editor.
map("x", "<Tab>", ">gv", { desc = "Indent selection" })
map("x", "<S-Tab>", "<gv", { desc = "Dedent selection" })

map({"n", "i"}, "<A-z>", ":set wrap!<CR>", { desc = "Toggle wrap" })

-- Also in terminal mode, so the Claude and shell splits are not one-way doors.
-- This shadows the TUI's own <C-j>; use \<CR> or <S-CR> for a literal newline.
for _, direction in ipairs({ "h", "j", "k", "l" }) do
  map({ "n", "t" }, "<C-" .. direction .. ">", "<C-\\><C-n><C-w>" .. direction, { desc = "Window " .. direction })
end

map("n", "<C-Left>", "<cmd>vertical resize -4<cr>", { desc = "Narrow window" })
map("n", "<C-Right>", "<cmd>vertical resize +4<cr>", { desc = "Widen window" })
map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Shorten window" })
map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Heighten window" })
map("n", "<leader>w=", "<C-w>=", { desc = "Equalize windows" })

-- <cmd> keeps the current mode, so saving mid-insert does not kick you out.
map({ "n", "i", "x" }, "<C-s>", "<cmd>write<cr>", { desc = "Save file" })

map("n", "<Esc>", "<cmd>nohlsearch<cr>", { desc = "Clear search highlight" })
map("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Leave terminal mode" })

map("n", "<leader>ts", function()
  vim.o.spell = not vim.o.spell
end, { desc = "Toggle spell check" })

map("n", "<leader>xx", function()
  vim.diagnostic.setqflist()
end, { desc = "Diagnostics to quickfix" })

-- Neovim's link detection does not resolve Markdown reference links such as [text][1].
local function reference_target()
  local line = vim.api.nvim_get_current_line()
  local col = vim.api.nvim_win_get_cursor(0)[2] + 1
  for start, label, finish in line:gmatch("()%b[]%[([^%]]+)%]()") do
    if start <= col and col < finish then
      for _, definition in ipairs(vim.api.nvim_buf_get_lines(0, 0, -1, false)) do
        local target = definition:match("^%s*%[" .. vim.pesc(label) .. "%]:%s*<?([^%s>]+)")
        if target then
          return target
        end
      end
    end
  end
end

-- Ctrl+click: text files open in a buffer; URLs and binary files go to the system handler.
local function open_link()
  local link = reference_target() or require("vim.ui")._get_urls()[1]
  if link == "" then
    return
  end
  if link:match("^%a[%w+.-]*://") or link:match("^mailto:") then
    if not link:match("^file://") then
      return vim.ui.open(link)
    end
    link = vim.uri_to_fname(link)
  end

  local path = vim.fs.normalize((link:gsub("#.*", "")))
  local beside_buffer = vim.fs.joinpath(vim.fn.expand("%:p:h"), path)
  if not vim.startswith(path, "/") and vim.uv.fs_stat(beside_buffer) then
    path = beside_buffer
  end

  local stat = vim.uv.fs_stat(path)
  if not stat then
    return vim.notify("No such file: " .. path, vim.log.levels.WARN)
  end
  if stat.type == "file" then
    local file = assert(io.open(path, "rb"))
    local head = file:read(1024) or ""
    file:close()
    -- A NUL byte in the first block marks the file as binary, as Git does.
    if head:find("\0", 1, true) then
      return vim.ui.open(path)
    end
  end
  vim.cmd.edit(vim.fn.fnameescape(path))
end

map("n", "<C-LeftMouse>", function()
  local mouse = vim.fn.getmousepos()
  vim.api.nvim_set_current_win(mouse.winid)
  vim.api.nvim_win_set_cursor(0, { mouse.line, math.max(mouse.column - 1, 0) })
  open_link()
end, { desc = "Open link under mouse" })
map("n", "gx", open_link, { desc = "Open link under cursor" })
