vim.pack.add({ "https://github.com/kaarmu/typst.vim" })

-- :TypstWatch recompiles on save; zathura reloads the PDF on its own.
vim.g.typst_pdf_viewer = "zathura"
vim.g.typst_auto_open_quickfix = 0
vim.g.typst_output_to_tmp = 1 -- watch writes to /tmp/typst_out/, keeping the source tree clean

vim.keymap.set("n", "<leader>tw", "<cmd>TypstWatch<cr>", { desc = "Typst watch" })
vim.keymap.set("n", "<leader>te", function()
  local file = vim.fn.expand("%:p")
  vim.system({ "typst", "compile", file }, {}, function(res)
    vim.schedule(function()
      if res.code == 0 then
        vim.notify("Exported " .. vim.fn.fnamemodify(file, ":r") .. ".pdf")
      else
        vim.notify(res.stderr, vim.log.levels.ERROR)
      end
    end)
  end)
end, { desc = "Typst export PDF" })
