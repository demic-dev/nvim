vim.pack.add({ "https://github.com/hat0uma/csvview.nvim" })

require("csvview").setup({
  -- An empty filetype map makes the delimiter come from the content, so a
  -- tab-separated .csv or a semicolon-separated export is still split correctly.
  parser = { delimiter = { ft = {} } },
  view = {
    display_mode = "border",
    sticky_columns = { enabled = true },
  },
  keymaps = {
    textobject_field_inner = { "if", mode = { "o", "x" } },
    textobject_field_outer = { "af", mode = { "o", "x" } },
    jump_next_field_end = { "<Tab>", mode = { "n", "v" } },
    jump_prev_field_end = { "<S-Tab>", mode = { "n", "v" } },
    jump_next_row = { "<Enter>", mode = { "n", "v" } },
    jump_prev_row = { "<S-Enter>", mode = { "n", "v" } },
  },
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "csv", "tsv" },
  desc = "Display CSV and TSV files as aligned tables",
  callback = function(ev)
    vim.opt_local.wrap = false -- wrapped rows break the column alignment
    require("csvview").enable(ev.buf)
  end,
})

-- Miller parses headers and quoted fields, which :sort cannot. A shell runs the
-- arguments so that quoting such as '$age > 30' works as on the command line.
-- The buffer is replaced only on success; u restores the previous contents.
-- The delimiter and header detected by csvview are reused, so the output keeps
-- the file's separator; headerless files get columns named 1, 2, 3...
vim.api.nvim_create_user_command("Mlr", function(opts)
  local info = vim.b.csvview_info
  local flags = "--csv --fs " .. vim.fn.shellescape(info and info.delimiter.text or ",")
  if info and not info.header.lnum then
    flags = flags .. " --implicit-csv-header --headerless-csv-output"
  end
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  local result = vim.system({ "sh", "-c", ("mlr %s %s"):format(flags, opts.args) }, { stdin = table.concat(lines, "\n") .. "\n" }):wait()
  if result.code ~= 0 then
    vim.notify(result.stderr, vim.log.levels.ERROR)
    return
  end
  vim.api.nvim_buf_set_lines(0, 0, -1, false, vim.split(result.stdout, "\n", { trimempty = true }))
end, { nargs = "+", desc = "Filter the buffer through Miller, e.g. :Mlr sort -nr age" })
