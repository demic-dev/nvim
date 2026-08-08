local o = vim.o

-- The terminal palette is themed by the desktop; staying in 16 colors makes
-- Neovim follow it instead of painting over it with its own 24-bit scheme.
o.termguicolors = false
vim.cmd.colorscheme("default")

-- The default scheme gives Comment a gui color but no cterm one, so in 16
-- colors comments render as plain Normal text. 8 is the terminal's "bright
-- black", the conventional dimmed grey, so it still follows the desktop theme.
vim.api.nvim_create_autocmd("ColorScheme", {
  group = vim.api.nvim_create_augroup("comment-contrast", { clear = true }),
  desc = "Keep comments dimmed in a 16-color terminal",
  callback = function()
    local comment = vim.api.nvim_get_hl(0, { name = "Comment" })
    comment.ctermfg, comment.italic = 8, true
    vim.api.nvim_set_hl(0, "Comment", comment)
  end,
})
vim.cmd.doautocmd("ColorScheme")

o.number = true
o.relativenumber = true
o.signcolumn = "yes"
o.cursorline = true
o.scrolloff = 8
o.wrap = false
o.splitbelow = true
o.splitright = true
o.showmode = false -- the statusline shows it
o.laststatus = 3 -- one statusline for all windows
o.winborder = "rounded"

o.expandtab = true
o.shiftwidth = 2
o.tabstop = 2
o.smartindent = true

o.ignorecase = true
o.smartcase = true
o.inccommand = "split"

o.undofile = true
o.swapfile = false
o.updatetime = 250
o.timeoutlen = 400
o.confirm = true

-- Missing dictionaries are downloaded into stdpath("data")/site/spell on first
-- use. Spell checking itself stays off until <leader>ts.
o.spelllang = "en,it,fr,es"
o.spell = false

o.mouse = "a"
o.clipboard = "unnamedplus" -- via wl-clipboard
o.sessionoptions = "buffers,curdir,folds,tabpages,winsize"
