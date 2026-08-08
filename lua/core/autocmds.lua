local group = vim.api.nvim_create_augroup("core", { clear = true })

vim.api.nvim_create_autocmd("TextYankPost", {
  group = group,
  desc = "Briefly highlight yanked text",
  callback = function()
    vim.hl.on_yank()
  end,
})

vim.api.nvim_create_autocmd("BufReadPost", {
  group = group,
  desc = "Restore the last cursor position",
  callback = function(ev)
    local mark = vim.api.nvim_buf_get_mark(ev.buf, '"')
    if mark[1] > 0 and mark[1] <= vim.api.nvim_buf_line_count(ev.buf) then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- One session per working directory: saved on exit, restored on demand from
-- the dashboard or :SessionRestore.
local session_dir = vim.fn.stdpath("state") .. "/sessions/"

local function session_file()
  return session_dir .. vim.fn.getcwd():gsub("/", "%%") .. ".vim"
end

vim.api.nvim_create_autocmd("VimLeavePre", {
  group = group,
  desc = "Save the session of the current directory",
  callback = function()
    vim.fn.mkdir(session_dir, "p")
    pcall(vim.cmd, "mksession! " .. vim.fn.fnameescape(session_file()))
  end,
})

vim.api.nvim_create_user_command("SessionRestore", function()
  local file = session_file()
  if vim.uv.fs_stat(file) then
    vim.cmd("source " .. vim.fn.fnameescape(file))
  else
    vim.notify("No session saved for " .. vim.fn.getcwd(), vim.log.levels.WARN)
  end
end, { desc = "Restore the session of the current directory" })
